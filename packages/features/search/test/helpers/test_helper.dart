import 'package:mockito/annotations.dart';
import 'package:search/search.dart';
import 'package:shared_dependencies/http/http.dart' as http;

@GenerateMocks([
  SearchRepository,
  SearchRemoteDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
