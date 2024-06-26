import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:manzil_api/utilities/rest_api_utilities.dart';

import '../models/model_manzil.dart';

class ServiceProduct {
  static var client = http.Client();
  static var duration = Duration(seconds: 30);

  static Future<List<ManzilModel>> LoadManzil() async {
    List<ManzilModel> list = [];

    try {
      Map<String, String> header = {};
      Map<String, String> body = {};

      Response response = await client
          .get(Uri.parse(RestApiUtilities.manzil_url))
          .timeout(duration);

      RestApiUtilities.GetPrintHeaderBodyUrlResponse(
          RestApiUtilities.manzil_url, header, body, response);

      if (response.statusCode == 200) {
        final decodedJson = json.decode(utf8.decode(response.bodyBytes));
        var modelSearchPost = ManzilModel.fromMap(decodedJson);

        list = [modelSearchPost];
        return list;
      } else {
        if (response.statusCode == 404) {
          print("Response: Sorry, resource not found");
        } else {
          print("Response: Sorry, ${response.body}");
        }
        print(RestApiUtilities.GetResponseError(response.statusCode));
        return list;
      }
    } on TimeoutException {
      print(RestApiUtilities.GetResponseError(420));
      return list;
    } on SocketException {
      print(RestApiUtilities.GetResponseError(430));
      return list;
    } catch (e) {
      print("Error: ${e.toString()}");
      return list;
    }
  }
}
