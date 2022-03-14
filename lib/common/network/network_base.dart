import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:task/common/constants/api_codes.dart';
import 'model/apiParameters.dart';
import 'network_enum.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class NetworkLayer {
  static NetworkLayer? _instance;

  NetworkLayer._internal();
  String _url=ApiBaseUrl.SERVER_BASE_URL;

  Dio _dio = Dio();

  Options _options=Options(
    sendTimeout: 35000,
    receiveTimeout: 33000,
  );

  Map<String,dynamic> _body={};


  set setURL(String value)=>_url=value;


  factory NetworkLayer() {
    _instance = _instance ?? NetworkLayer._internal();
    return _instance!;
  }

  // Exception
  void _validateValue({DioErrorType? dioErrorType, int statusCode:5, String statusMessage:"There is error happen in transaction please try again"}) {
    if (dioErrorType == DioErrorType.connectTimeout) {
      throw PlatformException(message:"Time Out",code:"2");
    } else if (dioErrorType == DioErrorType.sendTimeout) {
      throw PlatformException(message:"Value must be greater than 0",code:"1");
    } else if (dioErrorType == DioErrorType.receiveTimeout)  {
      throw PlatformException(message:"Value must not be greater than 100",code:"2");
    } else if (dioErrorType == DioErrorType.response)  {
      throw PlatformException(message:"Value must not be greater than 100",code:"2");
    } else if (dioErrorType == DioErrorType.cancel)  {
      throw PlatformException(message:"Value must not be greater than 100",code:"2");
    } else if (dioErrorType == DioErrorType.other)  {
      throw PlatformException(message:"Value must not be greater than 100",code:"2");
    } else {
      throw PlatformException(message:statusMessage ,code:statusCode.toString());
    }
  }

  Future<dynamic> sendAppRequest({required ApiParameters apiParameters,
    NETWORK_REQUEST_TYPE networkType:NETWORK_REQUEST_TYPE.POST,Map<String,dynamic>? header, int timeOutDuration:90}) async {

    String _path='';

      _path=_url+apiParameters.apiCode;

    Map<String,dynamic> _requestBody=json.decode(json.encode(_body));

    if(apiParameters.formData.isNotEmpty) {
      _requestBody.addAll(apiParameters.formData);
    }



    Options _optionSendReq=_options;
    _optionSendReq.method = (networkType==NETWORK_REQUEST_TYPE.POST)?"POST":"GET";

    if(header != null){
      _optionSendReq.headers = header;
    }


    if(!apiParameters.silentProgress) {
      EasyLoading.show();
    }
      try {

        Response response = await _dio.request(_path,
          queryParameters: networkType == NETWORK_REQUEST_TYPE.GET? apiParameters.formData:{},
          data:  networkType == NETWORK_REQUEST_TYPE.POST? _requestBody:{},
          options: _optionSendReq,
          onReceiveProgress: (count, total) {
          log("count: ${count}");
        },
        ).timeout(Duration(seconds: timeOutDuration),
            onTimeout: () async {
              // Time out Exception
              EasyLoading.dismiss();
              if(apiParameters.showError) {
                _validateValue(
                    statusCode: 4000,
                    statusMessage: "Time out"
                );
              }
              return Future.delayed(Duration(seconds: 1));
            });
        if(!apiParameters.silentProgress) {
          EasyLoading.dismiss();
        }
        return(response);
      }on DioError catch (ex) {
        EasyLoading.dismiss();

      if(apiParameters.showError) {
          _validateValue(
              dioErrorType: ex.type,
              statusCode: ex.response?.statusCode ?? 0,
              statusMessage: ex.response?.statusMessage ?? ""
          );
        }else{
          throw PlatformException(message:ex.response?.statusMessage ?? "" ,code: ex.response?.statusCode?.toString()??"");
        }
      }
  }

}


