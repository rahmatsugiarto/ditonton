import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc/top_rated_movies_event.dart';
import 'package:shared_dependencies/dartz/dartz.dart';

import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMoviesBloc topRatedMoviesBloc;
  late TopRatedMoviesState topRatedMoviesState;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc = TopRatedMoviesBloc(
      getTopRatedMovies: mockGetTopRatedMovies,
    );
    topRatedMoviesState = TopRatedMoviesState(
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
        topRatedMoviesBloc.state,
        topRatedMoviesState,
      );
    });
  });

  group("event FetchTopRatedMovies", () {
    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        topRatedMoviesState.copyWith(topRatedMoviesState: ViewData.loading()),
        topRatedMoviesState.copyWith(
          topRatedMoviesState: ViewData.loaded(data: tMovieList),
        )
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'Should emit [Loading, Error] when get movie detail is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        topRatedMoviesState.copyWith(topRatedMoviesState: ViewData.loading()),
        topRatedMoviesState.copyWith(
          topRatedMoviesState: ViewData.error(message: "Server Failure"),
        )
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
