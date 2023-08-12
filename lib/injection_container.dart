import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injection_container.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> init() => getIt.init();



@module
abstract class RegisterInternetConnectionChecker{
  @lazySingleton
  InternetConnectionChecker get checker => InternetConnectionChecker.createInstance();
}

@module
abstract class RegisterHttpClient {
  @lazySingleton
  http.Client get client => http.Client();
}

@module
abstract class RegisterSharedPreferences {
  @lazySingleton
  @preResolve
  Future<SharedPreferences> get sh => SharedPreferences.getInstance();
}