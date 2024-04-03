part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieDetail extends MovieDetailEvent {
  final int id;

  FetchMovieDetail({required this.id});

  @override
  List<Object> get props => [id];
}

class FetchMovieRecommendation extends MovieDetailEvent {
  final int id;

  FetchMovieRecommendation({required this.id});

  @override
  List<Object> get props => [id];
}

class AddWatchlist extends MovieDetailEvent {
  final MovieDetail movie;

  AddWatchlist({required this.movie});

  @override
  List<Object> get props => [movie];
}

class RemoveFromWatchlist extends MovieDetailEvent {
  final MovieDetail movie;

  RemoveFromWatchlist({required this.movie});

  @override
  List<Object> get props => [movie];
}

class LoadWatchlistStatus extends MovieDetailEvent {
  final int id;

  LoadWatchlistStatus({required this.id});

  @override
  List<Object> get props => [id];
}
