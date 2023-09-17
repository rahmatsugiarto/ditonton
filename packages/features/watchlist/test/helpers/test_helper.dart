import 'package:core/database/database_helper.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:watchlist/watchlist.dart';

@GenerateMocks([
  WatchlistRepository,
  WatchlistLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
