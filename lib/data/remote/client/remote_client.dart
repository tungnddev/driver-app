import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:driver/data/models/dummy_model.dart';
import 'package:driver/env/environment.dart';
import 'package:http/io_client.dart' as http;

import 'interceptor.dart';
import 'json_convert.dart';

class RemoteClient {
  static final ChopperClient? _instance = null;

  static ChopperClient get instanceClient {
    if (_instance != null) return _instance!;
    final converter = JsonSerializableConverter({
      DummyModel : DummyModel.fromJsonFactory
    });
    return ChopperClient(
      baseUrl: Environment.baseUrl,
      // bind your object factories here
      client: http.IOClient(HttpClient()),
      converter: converter,
      errorConverter: converter,
      /* ResponseInterceptorFunc | RequestInterceptorFunc | ResponseInterceptor | RequestInterceptor */
      interceptors: [
        AuthInterceptor(),
        ValidateInterceptor(),
      ],
    );
  }
}
