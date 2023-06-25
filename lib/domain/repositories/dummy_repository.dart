import 'package:driver/domain/entities/dummny.dart';

abstract class DummyRepository {
  Future<List<Dummy>> fetchListDummy();
}
