import 'package:core/core.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_dependencies/http/http.dart' as http;
import 'package:tv/tv.dart';

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
