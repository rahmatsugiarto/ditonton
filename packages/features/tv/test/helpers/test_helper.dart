import 'package:core/core.dart';
import 'package:mockito/annotations.dart';
import 'package:tv/tv.dart';

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<SSLPinningClient>(as: #MockSSLPinningClient)
])
void main() {}
