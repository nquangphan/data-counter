import 'package:data_counter/screen/home-screen/bloc/home_bloc.dart';
import 'package:data_counter/screen/home-screen/repository/home-repository.dart';
import 'package:data_counter/screen/home-screen/widget/data-item.dart';
import 'package:data_counter/utils/dio-error-mixin.dart';
import 'package:data_counter/utils/injectable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  static Widget widget() {
    return BlocProvider(
      create: (context) => getIt.get<HomeBloc>(),
      child: HomeScreen(),
    );
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with DioErrorHandler {
  late ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      // message = "reach the bottom";
      if (!context.read<HomeBloc>().isLoadAllData())
        context.read<HomeBloc>().add(LoadMoreDataEvent());
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      // message = "reach the top";
    }
  }

  @override
  Widget build(BuildContext context) {
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
              buildWhen: (previous, current) =>
                  current is RenderDataState || current is GetDataErrorState,
              builder: (context, state) {
                if (state is GetDataErrorState) {
                  return retryWidget;
                }
                if (state is RenderDataState)
                  return Container(
                    child: ListView.builder(
                      controller: _controller,
                      itemCount: state.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return DataItem(
                          data: state.data[index],
                        );
                      },
                    ),
                  );
                return SizedBox.shrink();
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

  Widget get retryWidget {
    return Container(
        child: Center(
            child: TextButton(
      child: Text('Retry', style: TextStyle(color: Colors.white)),
      onPressed: () {
        context.read<HomeBloc>().add(GetDataEvent());
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blueAccent)),
    )));
  }

  _handleStateListener(BuildContext context, HomeState state) {
    if (state is GetDataErrorState) {
      handleError(context, state.error);
    }
  }
}
