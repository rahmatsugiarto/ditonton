import 'dart:io';

import 'package:core/core.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../../domain/repositories/search_repository.dart';
import '../datasources/search_remote_data_source.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Movie>>> searchMovies(String query) async {
    try {
      final result = await remoteDataSource.searchMovies(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query) async {
    try {
      final result = await remoteDataSource.searchTvSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
