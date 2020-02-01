import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';

class Http {
  static Http instance;
  Dio dio;
  BaseOptions options;

  static Http getInstance() {
    if (null == instance) instance = new Http();
    return instance;
  }

  Http() {
    options = new BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Connection': 'keep-alive',
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101 Firefox/73.0',
        // 'Referer': 'http://zhjw.qfnu.edu.cn'
      },
      contentType: ContentType.parse("application/x-www-form-urlencoded"),
      responseType: ResponseType.plain, //以文本方式接收数据
    );

    dio = new Dio(options);

    //Cookie管理
    dio.interceptors.add(CookieManager(CookieJar()));

    //添加拦截器
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      // print("-----开始请求-----");
      return options;
    }, onResponse: (Response response) {
      // print("-----开始响应-----");
      return response;
    }, onError: (DioError e) {
      // print("-----发生错误-----");
      return e;
    }));
  }

  /*
   * get请求
   */
  get(url, {data, options, cancelToken}) async {
    //dio.options.responseType = ResponseType.plain;
    Response response;
    try {
      response = await dio.get(url,
          queryParameters: data, options: options, cancelToken: cancelToken);
      return response.data.toString();
      //response.data; 响应体 headers; 响应头 request; 请求体 statusCode; 状态码
    } on DioError catch (e) {
      print("请求失败-->连接超时");
      if (e != null) {
        if (e.response != null) {
          if (e.response.statusCode == 302) {
            response = await dio.get(e.response.headers['location'][0],
                // queryParameters: data,
                options: options,
                cancelToken: cancelToken);
            return response.data.toString();
          }
        }
      }
      if(e.type == DioErrorType.CONNECT_TIMEOUT){
        var re=await get(url, data: data, options: options, cancelToken: cancelToken);
        return re;
      }
      return formatError(e);

    }
  }

  /*
   * get请求,返回cookie！！！！！！！
   */
  xget(url, {data, options, cancelToken}) async {
    //dio.options.responseType = ResponseType.plain;
    Response response;
    try {
      response = await dio.get(url,
          queryParameters: data, options: options, cancelToken: cancelToken);
      return response.request.headers['cookie'].toString();
      //response.data; 响应体 headers; 响应头 request; 请求体 statusCode; 状态码
    } on DioError catch (e) {
      print("请求失败-->连接超时");
      if (e != null) {
        if (e.response != null) {
          if (e.response.statusCode == 302) {
            print(e.response.headers['location'][0]);
            response = await dio.get(e.response.headers['location'][0],
                queryParameters: data,
                options: options,
                cancelToken: cancelToken);
            return response.data.toString();
          }
        }
      }
      return response.request.headers['Cookie'][0].toString();
    }
  }

  /*
   * post请求
   */
  post(url, {data, options, cancelToken}) async {
    //dio.options.responseType = ResponseType.plain;
    Response response;
    try {
      response = await dio.post(url,
          queryParameters: data, options: options, cancelToken: cancelToken);
      return response.data.toString();
    } on DioError catch (e) {
      print("请求失败-->连接超时");
      if (e != null) {
        if (e.response != null) {
          if (e.response.statusCode == 302) {
             print(e.response.headers['location'][0]);
              // if (e.response.headers['set-cookie']!=null){
              //   options[]
              // }
            response = await dio.get(e.response.headers['location'][0],
                // queryParameters: data,
                options: options,
                cancelToken: cancelToken);
            return response.data.toString();
          }
        }
      }
      if(e.type == DioErrorType.CONNECT_TIMEOUT){
        var re=await post(url, data: data, options: options, cancelToken: cancelToken);
        return re;
      }
      return formatError(e);
    }
  }

  /*
   * post请求,用来三次跳转登录信息门户！！！
   */
  xpost(url, {data, datax, options, cancelToken}) async {
    Response response;
    try {
      response = await dio.post(url,
          data: datax,
          queryParameters: data,
          options: options,
          cancelToken: cancelToken);
      return response.data.toString();
    } on DioError catch (e) {
      print("请求失败-->连接超时");
      if (e != null) {
        if (e.response != null) {
          if (e.response.statusCode == 302) {
            print(e.response.headers['location'][0]);
            var result = await get(e.response.headers['location'][0],options: options, cancelToken: cancelToken);
            return result;
          }
        }
      }
      if(e.type == DioErrorType.CONNECT_TIMEOUT){
        var re=await xpost(url,
          datax: datax,
          data: data,
          options: options,
          cancelToken: cancelToken);
        return re;
      }
      return formatError(e);
    }
  }

  /*
   * 下载图片二进制资源
   */
  getImage(url) async {
    Response response;
    dio.options.responseType = ResponseType.bytes;
    try {
      response = await dio.get(url);
      Uint8List bytes = Uint8List.fromList(response.data);
      dio.options.responseType = ResponseType.plain;
      print("请求成功！！！！");
      return bytes;
    } on DioError catch (e) {
      print("请求失败-->连接超时");
      dio.options.responseType = ResponseType.plain;
      if(e.type == DioErrorType.CONNECT_TIMEOUT){
        var img=await getImage(url);
        return img;
      }
      return formatError(e);
    }
  }

  /*
   * 下载文件
   */
  downloadFile(urlPath, savePath) async {
    Response response;
    try {
      response = await dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        //进度 print("$count $total");
      });
      return response.data;
    } on DioError catch (e) {
      return formatError(e);
    }
  }

  /*
   * error统一处理
   */
  String formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      print("请求失败-->连接超时");
      return "请求失败-->连接超时";
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      print("请求失败-->请求超时");
      return "请求失败-->请求超时";
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      print("请求失败-->响应超时");
      return "请求失败-->响应超时";
    } else if (e.type == DioErrorType.RESPONSE) {
      print("请求失败-->应答异常");
      return "请求失败-->出现异常";
    } else if (e.type == DioErrorType.CANCEL) {
      print("请求失败-->请求取消");
      return "请求失败-->请求取消";
    } else {
      print("请求失败-->未知错误");
      return "请求失败-->未知错误";
    }
  }

  /*
   * 取消请求可选参数
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }
}
