import 'package:http/http.dart' as http;
import 'package:loxcorpserv/config/config.dart';
import 'package:path/path.dart';

class HttpRequests {
  static final _api = HttpRequests._internal();

  factory HttpRequests() {
    return _api;
  }
  HttpRequests._internal();
//========process a get request to the end point===============//
  Future<http.Response> httpGet(String endPoint,
      {String? query, headers}) async {
    print("###########: ${baseUrl + endPoint + query.toString()}");
    Uri uri = Uri.parse(baseUrl + endPoint);
    if (query != null) {
      uri = Uri.parse(baseUrl + endPoint + query.toString());
    }
    return http.get(uri, headers: headers);
  }

//===========process a post request to the endpoint=========
  Future<http.Response> httpPost(String endPointUrl,
      {postBodyData, header}) async {
    Uri uri = Uri.parse(baseUrl + endPointUrl);
    return http.post(uri, body: postBodyData, headers: header);
  }

//====process a multi file upload post request==================
  Future<http.Response> httpPostWithFile(String endPointUrl, {file}) async {
    Map<String, String> headers = {
      'APIKEY': apiKey,
    };
    var uri = Uri.parse(baseUrl + endPointUrl);
    var length = await file.length();
    http.MultipartRequest request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..files.add(
        http.MultipartFile('file', file.openRead(), length,
            filename: basename(file.path)),
      );
    return await http.Response.fromStream(await request.send());
  }
}
