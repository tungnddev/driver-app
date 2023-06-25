// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dummy_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$DummyService extends DummyService {
  _$DummyService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = DummyService;

  @override
  Future<Response<List<DummyModel>>> getListDummy(int page, int limit) {
    final $url = '/api/dummy';
    final $params = <String, dynamic>{'page': page, 'limit': limit};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<DummyModel>, DummyModel>($request);
  }
}
