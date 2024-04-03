import 'package:bloc_test/bloc_test.dart';
import 'package:core/state/view_data_state.dart';
import 'package:core/testing/dummy_data/dummy_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_dependencies/shared_dependencies.dart';
import 'package:tv/tv.dart';

class MockTvSeriesDetailBloc
    extends MockBloc<TvSeriesDetailEvent, TvSeriesDetailState>
    implements TvSeriesDetailBloc {}

class FakeTvSeriesDetailEvent extends Fake implements TvSeriesDetailEvent {}

class FakeTvSeriesDetailState extends Fake implements TvSeriesDetailState {}

void main() {
  late MockTvSeriesDetailBloc mockTvSeriesDetailBloc;
  late TvSeriesDetailState tvSeriesDetailState;

  setUp(() {
    registerFallbackValue(FakeTvSeriesDetailEvent());
    registerFallbackValue(FakeTvSeriesDetailState());

    mockTvSeriesDetailBloc = MockTvSeriesDetailBloc();
    tvSeriesDetailState = TvSeriesDetailState(
      tvSeriesDetailState: ViewData.initial(),
      tvRecommendationsState: ViewData.initial(),
      isAddedToWatchlist: false,
      watchlistMessage: "",
      isErrorWatchlist: false,
    );
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesDetailBloc>.value(
      value: mockTvSeriesDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv series not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state).thenReturn(
      tvSeriesDetailState.copyWith(
        tvSeriesDetailState: ViewData.loaded(data: testTvSeriesDetail),
        tvSeriesRecommendationsState: ViewData.loaded(),
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when tv series is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state).thenReturn(
      tvSeriesDetailState.copyWith(
        tvSeriesDetailState: ViewData.loaded(data: testTvSeriesDetail),
        tvSeriesRecommendationsState: ViewData.loaded(),
        isAddedToWatchlist: true,
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    whenListen(
      mockTvSeriesDetailBloc,
      initialState: tvSeriesDetailState,
      Stream.fromIterable([
        tvSeriesDetailState.copyWith(
          isAddedToWatchlist: false,
        ),
        tvSeriesDetailState.copyWith(
          isAddedToWatchlist: false,
          watchlistMessage: 'Added to Watchlist',
        ),
      ]),
    );

    final snackbar = find.byType(SnackBar);
    final textMessage = find.text('Added to Watchlist');

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(snackbar, findsNothing);
    expect(textMessage, findsNothing);

    await tester.pump();

    expect(snackbar, findsOneWidget);
    expect(textMessage, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    (WidgetTester tester) async {
      whenListen(
        mockTvSeriesDetailBloc,
        initialState: tvSeriesDetailState,
        Stream.fromIterable([
          tvSeriesDetailState.copyWith(
            isAddedToWatchlist: false,
          ),
          tvSeriesDetailState.copyWith(
            isAddedToWatchlist: false,
            watchlistMessage: 'Failed Add to Watchlist',
          ),
        ]),
      );

      final alertDialog = find.byType(AlertDialog);
      final textMessage = find.text('Failed Add to Watchlist');

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

      expect(alertDialog, findsNothing);
      expect(textMessage, findsNothing);

      await tester.pump();

      expect(alertDialog, findsOneWidget);
      expect(textMessage, findsOneWidget);
    };
  });
}
