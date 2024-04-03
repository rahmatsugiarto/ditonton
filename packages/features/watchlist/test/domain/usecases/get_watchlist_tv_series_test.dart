import 'package:core/testing/dummy_data/dummy_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_dependencies/dartz/dartz.dart';
import 'package:watchlist/domain/usecases/get_watchlist_tv_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvSeries usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = GetWatchlistTvSeries(mockWatchlistRepository);
  });

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockWatchlistRepository.getWatchlistTvSeries())
        .thenAnswer((_) async => Right(testTvSeriesList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvSeriesList));
  });
}
