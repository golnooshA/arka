import 'package:flutter/material.dart';
import 'package:wood/component/http_request/http_request.dart';
import 'package:wood/core/localization/language.dart';

class HttpList {
  Uri uri;
  final Language language;
  final String customListField;
  Map<String, String> queryParams = {'sort': 'created_at', 'order': 'desc'};
  Map<String, String> headers;
  String method = 'get';
  Map<String, dynamic> postReqBody;

  int currentPage;

  int lastPage;
  int nextPage;
  int totalItems;
  int perPage;
  String errorMessage;
  List list;

  ResponseJson response;

  HttpList({
    @required this.uri,
    this.currentPage = 1,
    this.nextPage = 2,
    this.language,
    this.headers,
    this.customListField
  });

  Future<ResponseJson> getCurrentPage(
      {String sort,
        String order,
        int page,
        Map<String, String> queryParams}) async {
    this.currentPage = page ?? currentPage;
    this.queryParams = queryParams ?? this.queryParams;
    this.errorMessage = '';
    final furi = uri.replace(queryParameters: {
      ...uri.queryParameters,
      'page': currentPage.toString(),
      ...this.queryParams
    });
    print(furi.toString());
    response = await (method == 'post' ? PostRequest(
      url: furi.toString(),
      headers: headers,
      reqBody: postReqBody
    ) : GetRequest(
      url: furi.toString(),
      headers: headers,
    )).responseJson();

    switch (response.status) {
      case ReqStatus.success:
        if (response.body is Map) {
          Map body = response.body;
          if(customListField != null){
            if(!body.containsKey(customListField)){
              errorMessage = language.unknownError;
              break;
            }
            body = response.body[customListField];
          }

          if (body.containsKey('data') &&
              body.containsKey('current_page') &&
              body.containsKey('last_page') &&
              body.containsKey('total') &&
              body.containsKey('per_page')) {
            list = body['data'];
            currentPage = body['current_page'];
            lastPage = body['last_page'];
            nextPage = currentPage == lastPage ? currentPage : currentPage + 1;
            perPage = body['per_page'];
            totalItems = body['total'];
            errorMessage = null;
          } else {
            errorMessage = language.unknownError;
          }
        } else {
          errorMessage = language.unknownError;
        }
        break;

      case ReqStatus.fail:
      case ReqStatus.error:
      default:
        errorMessage =
        response.body is Map && response.body.containsKey('message')
            ? response.body['message']
            : language.unknownError;
        break;
    }
    return response;
  }

  Future<ResponseJson> getNextPage() async {
    if (isLastPage()) {
      return null;
    }
    currentPage = nextPage;
    return getCurrentPage();
  }

  bool isLastPage([int page]) {
    return (page ?? currentPage) == lastPage;
  }
}
