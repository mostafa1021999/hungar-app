import 'package:delivery/componants/constant%20values.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static Dio? dioTry;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://hunger-station-clone.onrender.com/',
        receiveDataWhenStatusError: true,
      ),
    );
    dioTry = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  //this method is to get data from link
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    myapp
  }) async {
    myapp? dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang' : dropdownvalue=='English Language'?'en':'ar',
      'Authorization': 'Bearer $token'
    }:dioTry!.options.headers = {
      'Content-Type': 'application/json',
      'lang' : dropdownvalue=='English Language'?'en':'ar',
      'Authorization': token
    };
    return await myapp? dio!.get(url, queryParameters: query):dioTry!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url, // is the path that i will move in it will change while bring data so i need to make a parameter form it so when it is changed i see this change
    Map<String, dynamic>? query,
    required Map<String, dynamic> data ,
    String? token,
  }) async
  {
    dio!.options.headers={
      'Content-Type' : 'application/json',
      'lang' : 'ar',
      'Authorization':token??'',
    };
    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );  }

  static Future<Response> putData({
    required String url, // is the path that i will move in it will change while bring data so i need to make a parameter form it so when it is changed i see this change
    Map<String, dynamic>? query,
    required Map<String, dynamic> data ,
    String? token,
  }) async
  {
    dio!.options.headers={
      'Content-Type' : 'application/json',
      'lang' : 'ar',
      'Authorization':token??'',
    };
    return dio!.put(
      url,
      queryParameters: query,
      data: data,
    );  }
  static Future<Response> patchData({
    required String url, // is the path that i will move in it will change while bring data so i need to make a parameter form it so when it is changed i see this change
    Map<String, dynamic>? query,
    required Map<String, dynamic> data ,
    String? token,
  }) async
  {
    dio!.options.headers={
      'Content-Type' : 'application/json',
      'lang' :'en',
      'Authorization': 'Bearer $token',
    };
    return dio!.patch(
      url,
      queryParameters: query,
      data: data,
    );  }
}