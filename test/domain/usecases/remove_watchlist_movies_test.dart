import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistMovies usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = RemoveWatchlistMovies(mockRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockRepository.removeWatchlistMovies(testMovieDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(mockRepository.removeWatchlistMovies(testMovieDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
