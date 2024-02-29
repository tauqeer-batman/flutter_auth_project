import 'package:flutter_auth_project/services/auth_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> initServices() async {
  await locator.reset();
  locator.registerLazySingleton(() => AuthService());
}
