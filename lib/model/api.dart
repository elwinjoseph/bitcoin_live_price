import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/model/mode.dart';

class ApiService {
  final String url = 'https://api.coindesk.com/v1/bpi/currentprice.json';

  Future<BitcoinPrice> fetchCurrentBitcoinPrice() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return BitcoinPrice.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Bitcoin price');
    }
  }
}
