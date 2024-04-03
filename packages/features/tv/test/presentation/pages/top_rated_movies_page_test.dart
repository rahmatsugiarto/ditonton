import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_dependencies/bloc/bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv_series_bloc/top_rated_tv_series_event.dart';
import 'package:tv/tv.dart';

class MockTopRatedTvSeriesBloc
    extends MockBloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState>
    implements TopRatedTvSeriesBloc {}

class FakeTopRatedTvSeriesEvent extends Fake implements TopRatedTvSeriesEvent {}

class FakeTopRatedTvSeriesState extends Fake implements TopRatedTvSeriesState {}

void main() {
  late MockTopRatedTvSeriesBloc mockTopRatedTvSeriesBloc;
  late TopRatedTvSeriesState topRatedTvSeriesState;

  setUp(() {
    registerFallbackValue(FakeTopRatedTvSeriesEvent());
    registerFallbackValue(FakeTopRatedTvSeriesState());
    mockTopRatedTvSeriesBloc = MockTopRatedTvSeriesBloc();

    topRatedTvSeriesState = TopRatedTvSeriesState(
      topRatedTvSeriesState: ViewData.initial(),
    );
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvSeriesBloc>.value(
      value: mockTopRatedTvSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvSeriesBloc.state).thenReturn(
      topRatedTvSeriesState.copyWith(
        topRatedTvSeriesState: ViewData.loading(),
      ),
    );

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvSeriesBloc.state).thenReturn(
      topRatedTvSeriesState.copyWith(
        topRatedTvSeriesState: ViewData.loaded(data: <TvSeries>[]),
      ),
    );

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvSeriesBloc.state).thenReturn(
      topRatedTvSeriesState.copyWith(
        topRatedTvSeriesState: ViewData.error(message: 'Error message'),
      ),
    );

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
