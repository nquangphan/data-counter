import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data_counter/models/data-by-year-model.dart';
import 'package:data_counter/models/data-counter-model.dart';
import 'package:data_counter/screen/home-screen/repository/home-repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.repo) : super(HomeInitial()) {
    add(GetDataEvent());
  }
  final HomeRepository repo;
  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetDataEvent) {
      yield* _mapGetDataEventToState(event, state);
    } else if (event is LoadMoreDataEvent) {
      yield* _mapLoadMoreDataEventToState(event, state);
    }
  }

  Stream<HomeState> _mapGetDataEventToState(
      GetDataEvent event, HomeState state) async* {
    yield HomeLoadingState();
    var res, error;
    res = await repo.getData().catchError((onError) {
      error = onError;
    });
    if (res is DataCounterResponse) {
      repo.data = res;
      repo.recordsQuarter = res.result?.records ?? [];
      repo.caculateDataByYear();
      yield RenderDataState(repo.dataByYear);
    } else {
      yield GetDataErrorState(error);
    }
  }

  Stream<HomeState> _mapLoadMoreDataEventToState(
      LoadMoreDataEvent event, HomeState state) async* {
    yield HomeLoadingState();
    var res, error;
    res = await repo.loadMoreData().catchError((onError) {
      error = onError;
    });
    if (res is DataCounterResponse) {
      repo.recordsQuarter.addAll(res.result?.records ?? []);
      repo.data?.result?.links = res.result?.links;
      repo.data?.result?.total = res.result?.total;
      repo.caculateDataByYear();
      yield RenderDataState(repo.dataByYear);
    } else {
      yield GetDataErrorState(error);
    }
  }

  bool isLoadAllData() {
    return repo.recordsQuarter.length == (repo.data?.result?.total ?? -1);
  }
}
