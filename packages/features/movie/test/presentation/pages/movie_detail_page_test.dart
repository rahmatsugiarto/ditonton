import 'package:bloc_test/bloc_test.dart';
import 'package:core/state/view_data_state.dart';
import 'package:core/testing/dummy_data/dummy_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class FakeMovieDetailEvent extends Fake implements MovieDetailEvent {}

class FakeMovieDetailState extends Fake implements MovieDetailState {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MovieDetailState movieDetailState;

  setUp(() {
    registerFallbackValue(FakeMovieDetailEvent());
    registerFallbackValue(FakeMovieDetailState());

    mockMovieDetailBloc = MockMovieDetailBloc();
    movieDetailState = MovieDetailState(
      movieState: ViewData.initial(),
      movieRecommendationsState: ViewData.initial(),
      isAddedToWatchlist: false,
      watchlistMessage: "",
      isErrorWatchlist: false,
    );
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
      value: mockMovieDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state).thenReturn(
      movieDetailState.copyWith(
        movieState: ViewData.loaded(data: testMovieDetail),
        movieRecommendationsState: ViewData.loaded(),
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state).thenReturn(
      movieDetailState.copyWith(
        movieState: ViewData.loaded(data: testMovieDetail),
        movieRecommendationsState: ViewData.loaded(),
        isAddedToWatchlist: true,
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    whenListen(
      mockMovieDetailBloc,
      initialState: movieDetailState,
      Stream.fromIterable([
        movieDetailState.copyWith(
          isAddedToWatchlist: false,
        ),
        movieDetailState.copyWith(
          isAddedToWatchlist: false,
          watchlistMessage: 'Added to Watchlist',
        ),
      ]),
    );

    final snackbar = find.byType(SnackBar);
    final textMessage = find.text('Added to Watchlist');

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

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
        mockMovieDetailBloc,
        initialState: movieDetailState,
        Stream.fromIterable([
          movieDetailState.copyWith(
            isAddedToWatchlist: false,
          ),
          movieDetailState.copyWith(
            isAddedToWatchlist: false,
            watchlistMessage: 'Failed Add to Watchlist',
          ),
        ]),
      );

      final alertDialog = find.byType(AlertDialog);
      final textMessage = find.text('Failed Add to Watchlist');

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(alertDialog, findsNothing);
      expect(textMessage, findsNothing);

      await tester.pump();

      expect(alertDialog, findsOneWidget);
      expect(textMessage, findsOneWidget);
    };
  });
}
