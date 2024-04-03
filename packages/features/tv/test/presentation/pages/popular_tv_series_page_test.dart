import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_dependencies/shared_dependencies.dart';
import 'package:tv/presentation/bloc/popular_tv_series_bloc/popular_tv_series_event.dart';
import 'package:tv/tv.dart';

class MockPopularTvSeriesBloc
    extends MockBloc<PopularTvSeriesEvent, PopularTvSeriesState>
    implements PopularTvSeriesBloc {}

class FakePopularTvSeriesEvent extends Fake implements PopularTvSeriesEvent {}

class FakePopularTvSeriesState extends Fake implements PopularTvSeriesState {}

void main() {
  late MockPopularTvSeriesBloc mockPopularTvSeriesBloc;
  late PopularTvSeriesState popularTvSeriesState;

  setUp(() {
    registerFallbackValue(FakePopularTvSeriesEvent());
    registerFallbackValue(FakePopularTvSeriesState());
    mockPopularTvSeriesBloc = MockPopularTvSeriesBloc();

    popularTvSeriesState = PopularTvSeriesState(
      popularTvSeriesState: ViewData.initial(),
    );
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvSeriesBloc>.value(
      value: mockPopularTvSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularTvSeriesBloc.state).thenReturn(
      popularTvSeriesState.copyWith(
        popularTvSeriesState: ViewData.loading(),
      ),
    );

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularTvSeriesBloc.state).thenReturn(
      popularTvSeriesState.copyWith(
        popularTvSeriesState: ViewData.loaded(data: <TvSeries>[]),
      ),
    );

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularTvSeriesBloc.state).thenReturn(
      popularTvSeriesState.copyWith(
        popularTvSeriesState: ViewData.error(message: 'Error message'),
      ),
    );

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
