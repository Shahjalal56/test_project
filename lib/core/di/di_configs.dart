import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';


final GetIt getIt = GetIt.instance;

Future<void> diConfig() async {
  // Core Services
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiService>(() => ApiService());




  // ViewModels
  getIt.registerFactory<HomeProvider>(
        () => HomeProvider(getIt<ApiService>()),
  );



}