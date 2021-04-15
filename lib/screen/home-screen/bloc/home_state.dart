part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [Uuid().v4()];
}

class RenderDataState extends HomeState {
  final List<DataByYear> data;

  RenderDataState(this.data);
  @override
  List<Object> get props => [Uuid().v4()];
}

class GetDataErrorState extends HomeState {
  final dynamic error;

  GetDataErrorState(this.error);
  @override
  List<Object> get props => [Uuid().v4()];
}
