import 'package:driver/data/local/services/hive.dart';
import 'package:driver/data/remote/services/dummy_service.dart';
import 'package:driver/domain/entities/dummny.dart';
import 'package:driver/domain/repositories/dummy_repository.dart';

class DummyRepositoryImp extends DummyRepository {

  DummyRepositoryImp._privateConstructor();

  static final DummyRepository instance = DummyRepositoryImp._privateConstructor();

  final HiveService hiveService = HiveService.instance;
  final DummyService dummyService = DummyService.create();

  @override
  Future<List<Dummy>> fetchListDummy() {
    return dummyService.getListDummy(0, 10).then((value) => value.body!.map((e) => Dummy(dummy: e.dummy)).toList());
  }
}
