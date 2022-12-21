import 'dart:convert';

import 'package:loxcorpserv/components/functions.dart';
import 'package:loxcorpserv/config/config.dart';
import 'package:loxcorpserv/services/base_api.dart';

class ProductsService extends BaseApi {
  Future getProducts({String? productId}) async {
    //=====check internet===========//
    if (await getConnectionStatus() == true) {
      /**make a post request*/
      var serverResp = await api.httpGet(
        products,
        query: productId,
        headers: {
          "API_KEY": apiKey,
        },
      );
      /* decode the data received from the server
       */
      var resData = json.decode(serverResp.body);
      return resData;
    }
    return notInternet();
  }
}
