import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';
import 'package:shared_dependencies/dartz/dartz.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockSearchRepository mockSearchRepository;

  setUp(() {
    mockSearchRepository = MockSearchRepository();
    usecase = SearchTvSeries(mockSearchRepository);
  });

  final tTvSeries = <TvSeries>[];
  final tQuery = 'Spiderman';

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockSearchRepository.searchTvSeries(tQuery))
        .thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvSeries));
  });
}
