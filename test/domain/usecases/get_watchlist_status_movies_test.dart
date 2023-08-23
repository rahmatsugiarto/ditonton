import 'package:ditonton/domain/usecases/get_watchlist_status_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusMovies usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = GetWatchListStatusMovies(mockRepository);
  });

  test('should get watchlist movie status from repository', () async {
    // arrange
    when(mockRepository.isAddedToWatchlistMovies(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
