import 'package:core/network/ssl_pinning_client.dart';
import 'package:mockito/annotations.dart';
import 'package:search/search.dart';

@GenerateMocks([
  SearchRepository,
  SearchRemoteDataSource,
], customMocks: [
  MockSpec<SSLPinningClient>(as: #MockSSLPinningClient)
])
void main() {}
