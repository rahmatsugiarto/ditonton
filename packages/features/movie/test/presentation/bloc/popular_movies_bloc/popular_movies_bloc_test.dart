import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/state/view_data_state.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc/popular_movies_event.dart';
import 'package:shared_dependencies/dartz/dartz.dart';

import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMoviesBloc popularMoviesBloc;
  late PopularMoviesState popularMoviesState;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc = PopularMoviesBloc(
      getPopularMovies: mockGetPopularMovies,
    );
    popularMoviesState = PopularMoviesState(
      popularMoviesState: ViewData.initial(),
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
        popularMoviesBloc.state,
        popularMoviesState,
      );
    });
  });

  group("event FetchPopularMovies", () {
    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        popularMoviesState.copyWith(popularMoviesState: ViewData.loading()),
        popularMoviesState.copyWith(
          popularMoviesState: ViewData.loaded(data: tMovieList),
        )
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'Should emit [Loading, Error] when get movie detail is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        popularMoviesState.copyWith(popularMoviesState: ViewData.loading()),
        popularMoviesState.copyWith(
          popularMoviesState: ViewData.error(message: "Server Failure"),
        )
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });
}
