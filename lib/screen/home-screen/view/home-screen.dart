import 'package:data_counter/screen/home-screen/bloc/home_bloc.dart';
import 'package:data_counter/screen/home-screen/repository/home-repository.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}
