import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

enum ReqStatus {
  success,
  fail,
  error
}

class Response {
  final ReqStatus status;
  final int statusCode;
  final String errorMessage;
  final body;

  const Response({@required this.statusCode, @required this.body, @required this.status, this.errorMessage});
}

class ResponseString extends Response {
  final String body;
  const ResponseString({@required statusCode, @required this.body, String errorMessage}) :
        super(
          statusCode: statusCode,
          body: body,
          errorMessage: errorMessage,
          status: statusCode == null || statusCode < 100 ? ReqStatus.error : (statusCode >= 200 && statusCode <= 299 ? ReqStatus.success : ReqStatus.fail)
      );
}

class ResponseJson extends Response {
  final body;
  const ResponseJson({@required statusCode, @required this.body, String errorMessage}) :
        super(
          statusCode: statusCode,
          body: body,
          errorMessage: errorMessage,
          status: statusCode == null || statusCode < 100 ? ReqStatus.error : (statusCode >= 200 && statusCode <= 299 ? ReqStatus.success : ReqStatus.fail)
      );
}



abstract class Request {

  static String accessToken;

  final String url;
  final Map<String, dynamic> reqBody;
  final Map<String, String> headers;
  Future<Response> res;

  Request({
    @required this.url,
    this.reqBody,
    this.headers
  });

  Future<ResponseString> responseString();
  Future<ResponseJson> responseJson();

}

class GetRequest extends Request {

  GetRequest({
    String url,
    Map<String, dynamic> reqBody,
    Map<String, String> headers
  }) : super(url: url, reqBody: reqBody, headers: headers);

  Future<ResponseString> responseString() async {
    try {
      http.Response res = await http.get(url, headers: {
        ...headers ?? {},
        if(Request.accessToken != null) 'Authorization': 'Bearer ${Request.accessToken}'
      });
      return Future<ResponseString>.value(ResponseString(
          statusCode: res.statusCode,
          body: res.body
      ));
    } catch(e){
      return Future<ResponseString>.value(ResponseString(
          statusCode: -1,
          errorMessage: e.toString(),
          body: null
      ));
    }
  }

  Future<ResponseJson> responseJson() async {
    try {
      http.Response res = await http.get(url, headers: {
        ...headers ?? {},
        if(Request.accessToken != null) 'Authorization': 'Bearer ${Request.accessToken}'
      });
      return Future<ResponseJson>.value(ResponseJson(
          statusCode: res.statusCode,
          body: json.decode(res.body)
      ));
    } catch(e){
      print('errrr: $e');
      return Future<ResponseJson>.value(ResponseJson(
          statusCode: -1,
          errorMessage: e.toString(),
          body: null
      ));
    }
  }
}

class DeleteRequest extends Request {

  DeleteRequest({
    String url,
    Map<String, String> headers
  }) : super(url: url, headers: headers);

  Future<ResponseString> responseString() async {
    try {
      http.Response res = await http.delete(url, headers: {
        ...headers ?? {},
        if(Request.accessToken != null) 'Authorization': 'Bearer ${Request.accessToken}'
      });
      return Future<ResponseString>.value(ResponseString(
          statusCode: res.statusCode,
          body: res.body
      ));
    } catch(e){
      return Future<ResponseString>.value(ResponseString(
          statusCode: -1,
          errorMessage: e.toString(),
          body: null
      ));
    }
  }

  Future<ResponseJson> responseJson() async {
    try {
      http.Response res = await http.delete(url, headers: {
        ...headers ?? {},
        if(Request.accessToken != null) 'Authorization': 'Bearer ${Request.accessToken}'
      });
      return Future<ResponseJson>.value(ResponseJson(
          statusCode: res.statusCode,
          body: json.decode(res.body)
      ));
    } catch(e){
      return Future<ResponseJson>.value(ResponseJson(
          statusCode: -1,
          errorMessage: e.toString(),
          body: null
      ));
    }
  }
}

class PostRequest extends Request {

  PostRequest({
    String url,
    Map<String, dynamic> reqBody,
    Map<String, String> headers = const {
      'Content-Type': 'application/json; charset=utf-8'
    },
  }) : super(url: url, reqBody: reqBody, headers: headers);

  Future<ResponseString> responseString() async {
    try {
      http.Response res = await http.post(url, body: json.encode(reqBody), headers: {
        ...headers ?? {},
        if(Request.accessToken != null) 'Authorization': 'Bearer ${Request.accessToken}'
      });
      return Future<ResponseString>.value(ResponseString(
          statusCode: res.statusCode,
          body: res.body
      ));
    } catch(e){
      return Future<ResponseString>.value(ResponseString(
          statusCode: -1,
          errorMessage: e.toString(),
          body: null
      ));
    }
  }

  Future<ResponseJson> responseJson() async {
    try {
      http.Response res = await http.post(url, body: json.encode(reqBody), headers: {
        ...headers ?? {},
        if(Request.accessToken != null) 'Authorization': 'Bearer ${Request.accessToken}'
      });
      return Future<ResponseJson>.value(ResponseJson(
          statusCode: res.statusCode,
          body: json.decode(res.body)
      ));
    } catch(e){
      return Future<ResponseJson>.value(ResponseJson(
          statusCode: -1,
          errorMessage: e.toString(),
          body: null
      ));
    }
  }
}