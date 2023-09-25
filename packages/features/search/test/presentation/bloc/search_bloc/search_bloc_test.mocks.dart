// Mocks generated by Mockito 5.4.2 from annotations
// in search/test/presentation/bloc/search_bloc/search_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:core/core.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:search/domain/repositories/search_repository.dart' as _i2;
import 'package:search/domain/usecases/search_movies.dart' as _i4;
import 'package:search/domain/usecases/search_tv_series.dart' as _i7;
import 'package:shared_dependencies/dartz/dartz.dart' as _i3;

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

class _FakeSearchRepository_0 extends _i1.SmartFake
    implements _i2.SearchRepository {
  _FakeSearchRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SearchMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchMovies extends _i1.Mock implements _i4.SearchMovies {
  MockSearchMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SearchRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSearchRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.SearchRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i6.Movie>>> execute(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [query],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, List<_i6.Movie>>>.value(
            _FakeEither_1<_i6.Failure, List<_i6.Movie>>(
          this,
          Invocation.method(
            #execute,
            [query],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i6.Movie>>>);
}

/// A class which mocks [SearchTvSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchTvSeries extends _i1.Mock implements _i7.SearchTvSeries {
  MockSearchTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SearchRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSearchRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.SearchRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i6.TvSeries>>> execute(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [query],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, List<_i6.TvSeries>>>.value(
                _FakeEither_1<_i6.Failure, List<_i6.TvSeries>>(
          this,
          Invocation.method(
            #execute,
            [query],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i6.TvSeries>>>);
}
