import 'package:core/testing/dummy_data/dummy_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_dependencies/dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesDetail usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvSeriesDetail(mockTvRepository);
  });

  final tId = 1;

  test('should get tv series detail from the repository', () async {
    // arrange
    when(mockTvRepository.getTvSeriesDetail(tId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvSeriesDetail));
  });
}
