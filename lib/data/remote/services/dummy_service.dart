import 'package:chopper/chopper.dart';
import 'package:driver/data/models/dummy_model.dart';
import 'package:driver/data/remote/client/remote_client.dart';

part 'dummy_service.chopper.dart';
@ChopperApi()
abstract class DummyService extends ChopperService {

  DummyService();

  factory DummyService.create() {
    return _$DummyService(RemoteClient.instanceClient);
  }

  @Get(path: '/api/dummy')
  Future<Response<List<DummyModel>>> getListDummy(
      @Query() int page, @Query() int limit);
}
