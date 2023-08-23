import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_watchlist_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistMovies usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = SaveWatchlistMovies(mockRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockRepository.saveWatchlistMovies(testMovieDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(mockRepository.saveWatchlistMovies(testMovieDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
