import 'package:core/core.dart';
import 'package:mockito/annotations.dart';
import 'package:movie/movie.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<SSLPinningClient>(as: #MockSSLPinningClient)
])
void main() {}
