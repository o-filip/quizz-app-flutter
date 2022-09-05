import 'package:get_it/get_it.dart';

import 'module/core_di_module.dart';
import 'module/data_di_module.dart';
import 'module/domain_di_module.dart';
import 'module/ui_di_module.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  CoreDiModule.register();
  DataDiModule.register();
  DomainDiModule.register();
  UiDiModule.register();
}
