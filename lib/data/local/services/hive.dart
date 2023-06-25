import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  final String _prefBox = "CyHomeCache";

  HiveService._privateConstructor();

  static final HiveService instance = HiveService._privateConstructor();

  // please call first
  Future initialize() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    await Hive.openBox(_prefBox);
  }
}
