part of 'episode_tv_series_bloc.dart';

class EpisodeTvSeriesState extends Equatable {
  final ViewData<List<Episode>> episodeTvSeriesState;

  const EpisodeTvSeriesState({
    required this.episodeTvSeriesState,
  });

  EpisodeTvSeriesState copyWith({
    ViewData<List<Episode>>? episodeTvSeriesState,
  }) {
    return EpisodeTvSeriesState(
      episodeTvSeriesState: episodeTvSeriesState ?? this.episodeTvSeriesState,
    );
  }

  @override
  List<Object?> get props => [
        episodeTvSeriesState,
      ];
}
