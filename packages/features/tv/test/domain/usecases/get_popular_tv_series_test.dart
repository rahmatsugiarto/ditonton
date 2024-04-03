import 'package:core/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_dependencies/dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvSeries usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetPopularTvSeries(mockTvRepository);
  });

  final tTvSeries = <TvSeries>[];

  group('GetPopularMovies Tests', () {
    group('execute', () {
      test(
          'should get list of movies from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvRepository.getPopularTvSeries())
            .thenAnswer((_) async => Right(tTvSeries));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTvSeries));
      });
    });
  });
}
