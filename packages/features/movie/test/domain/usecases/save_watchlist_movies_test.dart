import 'package:core/core_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:shared_dependencies/dartz/dartz.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SaveWatchlistMovies(mockMovieRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockMovieRepository.saveWatchlistMovies(testMovieDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(mockMovieRepository.saveWatchlistMovies(testMovieDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
