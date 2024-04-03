import 'package:shared_dependencies/shared_dependencies.dart';

abstract class EpisodeTvSeriesEvent extends Equatable {
  const EpisodeTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class FetchEpisodeTvSeries extends EpisodeTvSeriesEvent {
  final int id;
  final int season;

  FetchEpisodeTvSeries({required this.id, required this.season});

  @override
  List<Object> get props => [id, season];
}
