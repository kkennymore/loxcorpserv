

import 'package:loxcorpserv/services/check_network_status.dart';
import 'package:loxcorpserv/services/http_requests.dart';

class BaseApi extends CheckNetworkStatus{
  HttpRequests api = HttpRequests();
}
