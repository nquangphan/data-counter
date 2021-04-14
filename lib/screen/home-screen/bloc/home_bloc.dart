import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data_counter/screen/home-screen/repository/home-repository.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.repo) : super(HomeInitial());
  final HomeRepository repo;
  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
