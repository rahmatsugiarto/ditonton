import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/state/view_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc/popular_movies_event.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

class MockPopularMoviesBloc
    extends MockBloc<PopularMoviesEvent, PopularMoviesState>
    implements PopularMoviesBloc {}

class FakePopularMoviesEvent extends Fake implements PopularMoviesEvent {}

class FakePopularMoviesState extends Fake implements PopularMoviesState {}

void main() {
  late MockPopularMoviesBloc mockPopularMoviesBloc;
  late PopularMoviesState popularMoviesState;

  setUp(() {
    registerFallbackValue(FakePopularMoviesEvent());
    registerFallbackValue(FakePopularMoviesState());
    mockPopularMoviesBloc = MockPopularMoviesBloc();

    popularMoviesState = PopularMoviesState(
      popularMoviesState: ViewData.initial(),
    );
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesBloc>.value(
      value: mockPopularMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularMoviesBloc.state).thenReturn(
      popularMoviesState.copyWith(
        popularMoviesState: ViewData.loading(),
      ),
    );

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularMoviesBloc.state).thenReturn(
      popularMoviesState.copyWith(
        popularMoviesState: ViewData.loaded(data: <Movie>[]),
      ),
    );

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularMoviesBloc.state).thenReturn(
      popularMoviesState.copyWith(
        popularMoviesState: ViewData.error(message: 'Error message'),
      ),
    );

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
