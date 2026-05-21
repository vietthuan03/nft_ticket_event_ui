import 'dart:convert';
import 'package:get/get_connect.dart';
import 'package:get/get.dart';

import '../utility/constants.dart';
import 'package:http/http.dart' as http;

class HttpService  {
  final String baseUrl = MAIN_URL;

  Future<Response> getItems({required String endpointUrl}) async {
    try {
      return await GetConnect().get('$baseUrl/$endpointUrl');
    } catch (e) {
      return Response(body: json.encode({'error': e.toString()}), statusCode: 500);
    }
  }


  Future<Response> addItem({
    required String endpointUrl,
    required dynamic itemData,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/$endpointUrl');

      final http.Response httpResponse = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(itemData),
      );

      final decodedBody =
      httpResponse.body.isNotEmpty ? jsonDecode(httpResponse.body) : null;

      return Response(
        statusCode: httpResponse.statusCode,
        body: decodedBody,
        statusText: httpResponse.reasonPhrase,
      );
    } catch (e) {
      return Response(
        statusCode: 500,
        body: {'message': e.toString()},
      );
    }
  }


  Future<Response> updateItem({required String endpointUrl, required String itemId, required dynamic itemData}) async {
    try {
      return await GetConnect().put('$baseUrl/$endpointUrl/$itemId', itemData);
    } catch (e) {
      return Response(body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }

  Future<Response> deleteItem({required String endpointUrl, required String itemId}) async {
    try {
      return await GetConnect().delete('$baseUrl/$endpointUrl/$itemId');
    } catch (e) {
      return Response(body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }
}
