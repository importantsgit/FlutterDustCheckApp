import 'package:http/http.dart' as http;
import 'dart:convert';
import '../air_result.dart';

class AirFetchbloc {
  Future<AirResult> fetchData() async {
    var response = await http.get(Uri.parse("APIKEY"));

    AirResult result = AirResult.fromJson(json.decode(response.body));

    return result;
  }
}
