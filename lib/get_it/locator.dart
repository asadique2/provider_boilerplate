import 'package:get_it/get_it.dart';
import 'package:provide_boiler_plate/net/api_service_config.dart';
import 'package:provide_boiler_plate/services/login_service_imp.dart';

final locator = GetIt.instance;
var config = ApiServiceConfig.instance;
Future<void> setupLocator()async
{
  locator.registerLazySingleton(() => LoginServiceImp(config?.dio));
}
