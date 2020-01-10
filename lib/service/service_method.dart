import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

Future request(url,{formData}) async {
  try{
    Response response;
    Dio dio = new Dio();
//    dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
    dio.options.contentType = ContentType.parse('application/json');
    if(formData==null){
      response = await dio.post(url);
    }else{
      response = await dio.post(url,data: formData);
    }
    print(response);
    if(response.statusCode==200){
      if(response.data['code']==0){
        return response.data['data'];
      }else{
        throw Exception(response.data['message']);
      }
    }else{
      throw Exception('后端接口出现异常。');
    }
  }catch(e){
    return print('错误=================>${e.toString()}');
  }
}

Future requestGet(url,{formData}) async {
  try{
    Response response;
    Dio dio = new Dio();
//    dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
    dio.options.contentType = ContentType.parse('application/json');
    if(formData==null){
      response = await dio.get(url);
    }else{
      response = await dio.get(url,queryParameters: formData,);
    }
    if(response.statusCode==200){
//      print();
      if(response.data['code']==0){
        return response.data['data'];
      }else{
        throw Exception(response.data['message']);
      }
    }else{
      throw Exception('后端接口出现异常。');
    }
  }catch(e){
    return print('错误=================>${e.toString()}');
  }
}

