import 'package:shared_dependencies/shared_dependencies.dart';

abstract class TopRatedTvSeriesEvent extends Equatable {
  const TopRatedTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class FetchTopRatedMovies extends TopRatedTvSeriesEvent {}
