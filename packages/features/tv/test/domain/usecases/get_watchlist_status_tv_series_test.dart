import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusTvSeries usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetWatchListStatusTvSeries(mockTvRepository);
  });

  test('should get watchlist tv series status from repository', () async {
    // arrange
    when(mockTvRepository.isAddedToWatchlistTvSeries(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
