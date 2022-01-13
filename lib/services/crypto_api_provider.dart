import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:my_blog/models/crypto.dart';

class CryptoProvider {
  // static String _apiKey = 'b54bcf4d-1bca-4e8e-9a24-22ff2c3d462c';
  // static String _domen = 'sandbox-api.coinmarketcap.com';
  static String _apiKey = '83b14350-75b3-4434-954d-09bec5f978fd';
  static String _domen = 'pro-api.coinmarketcap.com';

  static String getCryptoIconPath(id) => 'https://s2.coinmarketcap.com/static/img/coins/64x64/$id.png';

  Future<List<Crypto>> getCryptoList(start, limit, convert) async {
    var parametrs = {
      'start': '$start',
      'limit': '$limit',
      'convert': '$convert',
    };
    var headers = {
      HttpHeaders.acceptHeader: 'application/json',
      'X-CMC_PRO_API_KEY': _apiKey,
    };
    var uri = Uri.https(_domen, '/v1/cryptocurrency/listings/latest', parametrs);
    final responce = await http.get(uri, headers: headers);
    if (responce.statusCode == 200) {
      final List<dynamic> cryptoJson = json.decode(responce.body)['data'];
      return cryptoJson.map((json) => Crypto.fromJson(json)).toList();
    } else {
      throw Exception('Erorr fetching crypto : ${responce.statusCode} - ${responce.reasonPhrase}');
    }
  }

  Future<List<Crypto>> getCryptoDetails(id, convert) async {
    var parametrs = {
      'id': '$id',
      'convert': '$convert',
    };
    var headers = {
      HttpHeaders.acceptHeader: 'application/json',
      'X-CMC_PRO_API_KEY': _apiKey,
    };
    var uri = Uri.https(_domen, '/v1/cryptocurrency/quotes/latest', parametrs);
    final responce = await http.get(uri, headers: headers);
    if (responce.statusCode == 200) {
      final List<dynamic> cryptoJson = json.decode(responce.body)['data'];
      return cryptoJson.map((json) => Crypto.fromJson(json)).toList();
    } else {
      throw Exception('Erorr fetching crypto : ${responce.statusCode} - ${responce.reasonPhrase}');
    }
  }
}