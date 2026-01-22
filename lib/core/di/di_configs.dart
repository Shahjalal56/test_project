import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/parent/viewmodel/ParentScreenProvider.dart';
import '../services/api_services/api_services.dart';

final GetIt getIt = GetIt.instance;

Future<void> diConfig() async {
  // Core Services
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  // ViewModels
 // getIt.registerFactory<HomeProvider>(() => HomeProvider(getIt<ApiService>()));
  getIt.registerFactory<ParentScreenProvider>(() => ParentScreenProvider());
}
