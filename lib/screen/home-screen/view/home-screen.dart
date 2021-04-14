import 'package:data_counter/screen/home-screen/bloc/home_bloc.dart';
import 'package:data_counter/screen/home-screen/repository/home-repository.dart';
import 'package:data_counter/screen/home-screen/widget/data-item.dart';
import 'package:data_counter/utils/dio-error-mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  static Widget widget() {
    HomeRepository repo = HomeRepository();
    return BlocProvider(
      create: (context) => HomeBloc(repo),
      child: RepositoryProvider(
        create: (context) => repo,
        child: HomeScreen(),
      ),
    );
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with DioErrorHandler {
  late HomeRepository _repo;
  @override
  Widget build(BuildContext context) {
    _repo = context.watch();
    return Scaffold(
      appBar: AppBar(
        title: Text('Data counter application'),
      ),
      body: Stack(
        children: <Widget>[
          RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(GetDataEvent());
            },
            child: BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current) => current is RenderDataState,
              builder: (context, state) {
                if (_repo.data?.result?.records?.isNotEmpty != true) {
                  return Container(
                      child: Center(
                          child: TextButton(
                    child: Text('Retry', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      context.read<HomeBloc>().add(GetDataEvent());
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueAccent)),
                  )));
                }
                return Container(
                  child: ListView.builder(
                    itemCount: _repo.data?.result?.records?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return DataItem(
                        record: _repo.data?.result?.records![index],
                        prevRecord: index > 0
                            ? _repo.data?.result?.records![index - 1]
                            : null,
                      );
                    },
                  ),
                );
              },
            ),
          ),
          BlocConsumer<HomeBloc, HomeState>(
            builder: (context, state) {
              return state is HomeLoadingState
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black26,
                      child: Center(child: CupertinoActivityIndicator()),
                    )
                  : SizedBox.shrink();
            },
            listener: (context, state) {
              _handleStateListener(context, state);
            },
          ),
        ],
      ),
    );
  }

  _handleStateListener(BuildContext context, HomeState state) {
    if (state is GetDataErrorState) {
      handleError(context, state.error);
    }
  }
}
