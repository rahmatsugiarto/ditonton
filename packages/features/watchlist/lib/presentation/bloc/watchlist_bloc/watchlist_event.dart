part of 'watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistMovies extends WatchlistEvent {}

class FetchWatchlistTv extends WatchlistEvent {}
