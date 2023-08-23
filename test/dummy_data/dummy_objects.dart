import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/entities/tv_series_season_detail.dart';
import 'package:ditonton/domain/entities/tv_series_seasons.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);
final testTvSeries = TvSeries(
  backdropPath: "/path.jpg",
  firstAirDate: "2023-05-08",
  genreIds: [1, 2, 3],
  id: 1,
  name: "Name",
  originCountry: [
    "BR",
  ],
  originalLanguage: "Original Language",
  originalName: "Original Name",
  overview: "Overview",
  popularity: 9.5,
  posterPath: "/path.jpg",
  voteAverage: 5.7,
  voteCount: 43,
);

final testMovieList = [testMovie];

final testTvSeriesList = [testTvSeries];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testTvSeriesDetail = TvSeriesDetail(
  adult: false,
  backdropPath: "/6UH52Fmau8RPsMAbQbjwN3wJSCj.jpg",
  episodeRunTime: [45],
  firstAirDate: "2021-03-25",
  genres: [
    Genre(
      id: 16,
      name: "Animation",
    ),
  ],
  homepage: "https://www.amazon.com/dp/B08WJP55PR",
  id: 95557,
  inProduction: true,
  languages: ["en"],
  lastAirDate: "2021-04-29",
  name: "Invincible",
  numberOfEpisodes: 12,
  numberOfSeasons: 2,
  originCountry: ["US"],
  originalLanguage: "en",
  originalName: "Invincible",
  overview:
      "Mark Grayson is a normal teenager except for the fact that his father is the most powerful superhero on the planet. Shortly after his seventeenth birthday, Mark begins to develop powers of his own and enters into his father’s tutelage.",
  popularity: 68.151,
  posterPath: "/yDWJYRAwMNKbIYT8ZB33qy84uzO.jpg",
  seasons: [
    TvSeriesSeasons(
      airDate: "2023-07-21",
      episodeCount: 1,
      id: 349664,
      name: 'Specials',
      overview: '',
      posterPath: '/rJcVipFPY6JdFaDPan10f0OhbpM.jpg',
      seasonNumber: 0,
      voteAverage: 0.0,
    )
  ],
  status: "Returning Series",
  tagline: "Almost there.",
  type: "Scripted",
  voteAverage: 8.694,
  voteCount: 3562,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvSeriesMap = {
  'id': 1,
  'name': 'name',
  'overview': 'overview',
  'posterPath': 'posterPath',
};

final tTvSeriesSeasonDetail = TvSeriesSeasonDetail(
  id: "63cafc22ea3949007ca1f2ee",
  airDate: "2023-11-02",
  episodes: [
    Episode(
      airDate: "2023-11-02",
      episodeNumber: 1,
      name: "Episode 1",
      overview: "",
      id: 4590786,
      productionCode: "",
      seasonNumber: 2,
      stillPath: "stillPath",
      voteAverage: 0.0,
      voteCount: 0,
    ),
  ],
  name: "Season 2",
  overview: "",
  seasonsModelId: 325266,
  posterPath: "/lxVS24ZhG3WQf3IMbkFIg6olT6A.jpg",
  seasonNumber: 2,
);
