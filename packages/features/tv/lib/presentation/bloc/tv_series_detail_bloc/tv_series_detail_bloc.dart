import 'package:core/core.dart';
import 'package:shared_dependencies/shared_dependencies.dart';
import 'package:tv/tv.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetWatchListStatusTvSeries getWatchListStatus;
  final SaveWatchlistTvSeries saveWatchlist;
  final RemoveWatchlistTvSeries removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TvSeriesDetailBloc({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TvSeriesDetailState(
          tvSeriesDetailState: ViewData.initial(),
          tvRecommendationsState: ViewData.initial(),
          isAddedToWatchlist: false,
          watchlistMessage: "",
          isErrorWatchlist: false,
        )) {
    on<FetchTvSeriesDetail>((event, emit) async {
      emit(state.copyWith(tvSeriesDetailState: ViewData.loading()));
      final result = await getTvSeriesDetail.execute(event.id);

      result.fold((failure) {
        emit(state.copyWith(
          tvSeriesDetailState: ViewData.error(message: failure.message),
        ));
      }, (data) {
        emit(state.copyWith(
          tvSeriesDetailState: ViewData.loaded(data: data),
        ));
      });
    });

    on<FetchTvSeriesRecommendation>((event, emit) async {
      emit(state.copyWith(tvSeriesRecommendationsState: ViewData.loading()));
      final result = await getTvSeriesRecommendations.execute(event.id);

      result.fold((failure) {
        emit(state.copyWith(
          tvSeriesRecommendationsState:
              ViewData.error(message: failure.message),
        ));
      }, (data) {
        emit(state.copyWith(
          tvSeriesRecommendationsState: ViewData.loaded(data: data),
        ));
      });
    });

    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });

    on<AddWatchlist>((event, emit) async {
      final resultSaveWatchlist = await saveWatchlist.execute(event.tvSeries);
      final resultGetWatchlist =
          await getWatchListStatus.execute(event.tvSeries.id);

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
      final result = await removeWatchlist.execute(event.tvSeries);
      final resultGetWatchlist =
          await getWatchListStatus.execute(event.tvSeries.id);

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
