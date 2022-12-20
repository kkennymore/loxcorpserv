class Exceptions implements Exception {
  /*
   * return the message status
   */
  Future responseStatus(
    String status, {
    String? message,
    int? code,
    String? details,
    List? data,
  }) async {
    List response = [
      {
        "status": status,
        "message": message,
        "details": details,
        "code": code,
        "data": data,
      }
    ];
    return response[0];
  }
}
