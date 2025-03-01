abstract class BaseApiServices {

  Future<dynamic> getGetApiResponse(String url, {required Map<String, String> headers});
  Future<dynamic> getPostApiResponse(String url, dynamic data);

}
