import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvSeries usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = GetWatchlistTvSeries(mockRepository);
  });

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockRepository.getWatchlistTvSeries())
        .thenAnswer((_) async => Right(testTvSeriesList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvSeriesList));
  });
}
