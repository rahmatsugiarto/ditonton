import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc/top_rated_movies_event.dart';
import 'package:shared_dependencies/bloc/bloc.dart';

class MockTopRatedMoviesBloc
    extends MockBloc<TopRatedMoviesEvent, TopRatedMoviesState>
    implements TopRatedMoviesBloc {}

class FakeTopRatedMoviesEvent extends Fake implements TopRatedMoviesEvent {}

class FakeTopRatedMoviesState extends Fake implements TopRatedMoviesState {}

void main() {
  late MockTopRatedMoviesBloc mockTopRatedMoviesBloc;
  late TopRatedMoviesState topRatedMoviesState;

  setUp(() {
    registerFallbackValue(FakeTopRatedMoviesEvent());
    registerFallbackValue(FakeTopRatedMoviesState());
    mockTopRatedMoviesBloc = MockTopRatedMoviesBloc();

    topRatedMoviesState = TopRatedMoviesState(
      topRatedMoviesState: ViewData.initial(),
    );
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesBloc>.value(
      value: mockTopRatedMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedMoviesBloc.state).thenReturn(
      topRatedMoviesState.copyWith(
        topRatedMoviesState: ViewData.loading(),
      ),
    );

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedMoviesBloc.state).thenReturn(
      topRatedMoviesState.copyWith(
        topRatedMoviesState: ViewData.loaded(data: <Movie>[]),
      ),
    );

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedMoviesBloc.state).thenReturn(
      topRatedMoviesState.copyWith(
        topRatedMoviesState: ViewData.error(message: 'Error message'),
      ),
    );

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
