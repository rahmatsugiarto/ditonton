import 'package:core/testing/dummy_data/dummy_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_dependencies/dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesSeasonDetail usecase;
  late MockTvRepository mockTvRepository;
  final tId = 1;
  final tSeason = 1;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvSeriesSeasonDetail(mockTvRepository);
  });

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvRepository.getTvSeriesSeasonDetail(tId, tSeason))
        .thenAnswer((_) async => Right(tTvSeriesSeasonDetail));
    // act
    final result = await usecase.execute(tId, tSeason);
    // assert
    expect(result, Right(tTvSeriesSeasonDetail));
  });
}
