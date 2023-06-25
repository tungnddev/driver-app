
import 'package:driver/app/app.dart';

import 'env/environment.dart';

void main(){
  Environment.setEnvironment(EnvironmentType.DEV);
  mainDelegate();
}