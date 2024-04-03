import 'package:core/core.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../../../watchlist.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchlistTvSeries getWatchlistTvSeries;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchlistBloc({
    required this.getWatchlistMovies,
    required this.getWatchlistTvSeries,
  }) : super(WatchlistState(
          watchlistMovieState: ViewData.initial(),
          watchlistTvState: ViewData.initial(),
        )) {
    on<FetchWatchlistMovies>((event, emit) async {
      emit(state.copyWith(watchlistMovieState: ViewData.loading()));
      final result = await getWatchlistMovies.execute();

      result.fold((failure) {
        emit(state.copyWith(
          watchlistMovieState: ViewData.error(message: failure.message),
        ));
      }, (data) {
        if (data.isEmpty) {
          emit(state.copyWith(
              watchlistMovieState: ViewData.noData(
            message: "No Watchlist Movie",
          )));
        } else {
          emit(state.copyWith(
            watchlistMovieState: ViewData.loaded(data: data),
          ));
        }
      });
    });

    on<FetchWatchlistTv>((event, emit) async {
      emit(state.copyWith(watchlistTvState: ViewData.loading()));
      final result = await getWatchlistTvSeries.execute();

      result.fold((failure) {
        emit(state.copyWith(
          watchlistTvState: ViewData.error(message: failure.message),
        ));
      }, (data) {
        if (data.isEmpty) {
          emit(state.copyWith(
              watchlistTvState: ViewData.noData(
            message: "No Watchlist TV",
          )));
        } else {
          emit(state.copyWith(
            watchlistTvState: ViewData.loaded(data: data),
          ));
        }
      });
    });
  }
}
