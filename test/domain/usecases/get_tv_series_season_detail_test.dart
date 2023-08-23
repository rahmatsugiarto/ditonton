import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_series_season_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesSeasonDetail usecase;
  late MockRepository mockRepository;
  final tId = 1;
  final tSeason = 1;

  setUp(() {
    mockRepository = MockRepository();
    usecase = GetTvSeriesSeasonDetail(mockRepository);
  });

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockRepository.getTvSeriesSeasonDetail(tId, tSeason))
        .thenAnswer((_) async => Right(tTvSeriesSeasonDetail));
    // act
    final result = await usecase.execute(tId, tSeason);
    // assert
    expect(result, Right(tTvSeriesSeasonDetail));
  });
}
