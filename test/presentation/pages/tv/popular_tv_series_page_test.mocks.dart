// Mocks generated by Mockito 5.4.2 from annotations
// in ditonton/test/presentation/pages/tv/popular_tv_series_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:ui' as _i7;

import 'package:ditonton/common/enum.dart' as _i4;
import 'package:ditonton/domain/entities/tv_series.dart' as _i5;
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart' as _i2;
import 'package:ditonton/presentation/provider/popular_tv_series_notifier.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetPopularTvSeries_0 extends _i1.SmartFake
    implements _i2.GetPopularTvSeries {
  _FakeGetPopularTvSeries_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [PopularTvSeriesNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockPopularTvSeriesNotifier extends _i1.Mock
    implements _i3.PopularTvSeriesNotifier {
  MockPopularTvSeriesNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetPopularTvSeries get getPopularTvSeries => (super.noSuchMethod(
        Invocation.getter(#getPopularTvSeries),
        returnValue: _FakeGetPopularTvSeries_0(
          this,
          Invocation.getter(#getPopularTvSeries),
        ),
      ) as _i2.GetPopularTvSeries);
  @override
  _i4.RequestState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _i4.RequestState.Empty,
      ) as _i4.RequestState);
  @override
  List<_i5.TvSeries> get listTvSeries => (super.noSuchMethod(
        Invocation.getter(#listTvSeries),
        returnValue: <_i5.TvSeries>[],
      ) as List<_i5.TvSeries>);
  @override
  String get message => (super.noSuchMethod(
        Invocation.getter(#message),
        returnValue: '',
      ) as String);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  _i6.Future<void> fetchPopularTvSeries() => (super.noSuchMethod(
        Invocation.method(
          #fetchPopularTvSeries,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  void addListener(_i7.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i7.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
