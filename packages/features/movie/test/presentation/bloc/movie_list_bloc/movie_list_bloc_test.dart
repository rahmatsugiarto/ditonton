import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/bloc/movie_list_bloc/movie_list_event.dart';
import 'package:shared_dependencies/dartz/dartz.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late MovieListBloc movieListBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MovieListState movieListState;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieListBloc = MovieListBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
    movieListState = MovieListState(
      nowPlayingState: ViewData.initial(),
      popularMoviesState: ViewData.initial(),
      topRatedMoviesState: ViewData.initial(),
    );
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  group("initial state", () {
    test('should have the default value in the init state', () {
      expect(
        movieListBloc.state,
        movieListState,
      );
    });
  });

  group("event FetchNowPlayingMovies", () {
    blocTest<MovieListBloc, MovieListState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        movieListState.copyWith(nowPlayingState: ViewData.loading()),
        movieListState.copyWith(
          nowPlayingState: ViewData.loaded(data: tMovieList),
        )
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<MovieListBloc, MovieListState>(
      'Should emit [Loading, Error] when get movie detail is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        movieListState.copyWith(nowPlayingState: ViewData.loading()),
        movieListState.copyWith(
          nowPlayingState: ViewData.error(message: "Server Failure"),
        )
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });

  group("event FetchPopularMovies", () {
    blocTest<MovieListBloc, MovieListState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        movieListState.copyWith(popularMoviesState: ViewData.loading()),
        movieListState.copyWith(
          popularMoviesState: ViewData.loaded(data: tMovieList),
        )
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<MovieListBloc, MovieListState>(
      'Should emit [Loading, Error] when get movie detail is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        movieListState.copyWith(popularMoviesState: ViewData.loading()),
        movieListState.copyWith(
          popularMoviesState: ViewData.error(message: "Server Failure"),
        )
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });

  group("event FetchTopRatedMovies", () {
    blocTest<MovieListBloc, MovieListState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        movieListState.copyWith(topRatedMoviesState: ViewData.loading()),
        movieListState.copyWith(
          topRatedMoviesState: ViewData.loaded(data: tMovieList),
        )
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<MovieListBloc, MovieListState>(
      'Should emit [Loading, Error] when get movie detail is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        movieListState.copyWith(topRatedMoviesState: ViewData.loading()),
        movieListState.copyWith(
          topRatedMoviesState: ViewData.error(message: "Server Failure"),
        )
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
