import 'package:core/core.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../../../movie.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatusMovies getWatchListStatus;
  final SaveWatchlistMovies saveWatchlist;
  final RemoveWatchlistMovies removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailState(
          movieState: ViewData.initial(),
          movieRecommendationsState: ViewData.initial(),
          isAddedToWatchlist: false,
          watchlistMessage: "",
          isErrorWatchlist: false,
        )) {
    on<FetchMovieDetail>((event, emit) async {
      emit(state.copyWith(movieState: ViewData.loading()));
      final result = await getMovieDetail.execute(event.id);

      result.fold((failure) {
        emit(state.copyWith(
          movieState: ViewData.error(message: failure.message),
        ));
      }, (data) {
        emit(state.copyWith(
          movieState: ViewData.loaded(data: data),
        ));
      });
    });

    on<FetchMovieRecommendation>((event, emit) async {
      emit(state.copyWith(movieRecommendationsState: ViewData.loading()));
      final result = await getMovieRecommendations.execute(event.id);

      result.fold((failure) {
        emit(state.copyWith(
          movieRecommendationsState: ViewData.error(message: failure.message),
        ));
      }, (data) {
        emit(state.copyWith(
          movieRecommendationsState: ViewData.loaded(data: data),
        ));
      });
    });

    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });

    on<AddWatchlist>((event, emit) async {
      final resultSaveWatchlist = await saveWatchlist.execute(event.movie);
      final resultGetWatchlist =
          await getWatchListStatus.execute(event.movie.id);

      await resultSaveWatchlist.fold(
        (failure) {
          emit(state.copyWith(
            watchlistMessage: failure.message,
            isErrorWatchlist: true,
            isAddedToWatchlist: resultGetWatchlist,
          ));
        },
        (successMessage) {
          emit(state.copyWith(
            watchlistMessage: successMessage,
            isErrorWatchlist: false,
            isAddedToWatchlist: resultGetWatchlist,
          ));
        },
      );
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.movie);
      final resultGetWatchlist =
          await getWatchListStatus.execute(event.movie.id);

      await result.fold(
        (failure) {
          emit(state.copyWith(
            watchlistMessage: failure.message,
            isErrorWatchlist: true,
            isAddedToWatchlist: resultGetWatchlist,
          ));
        },
        (successMessage) {
          emit(state.copyWith(
            watchlistMessage: successMessage,
            isErrorWatchlist: false,
            isAddedToWatchlist: resultGetWatchlist,
          ));
        },
      );
    });
  }
}
