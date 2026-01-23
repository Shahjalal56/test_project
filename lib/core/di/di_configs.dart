import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/home/presentation/view_model/category_products_provider.dart';
import '../../features/home/presentation/view_model/home_provider.dart';
import '../../features/home/presentation/view_model/product_details_provider.dart';
import '../../features/home/presentation/view_model/see_all_product_provider.dart';
import '../../features/parent/viewmodel/ParentScreenProvider.dart';
import '../services/api_services/api_services.dart';

final GetIt getIt = GetIt.instance;

Future<void> diConfig() async {
  // Core Services
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  // ViewModels
 getIt.registerFactory<HomeProvider>(() => HomeProvider(getIt<ApiService>()));
 getIt.registerFactory<SeeAllProvider>(() => SeeAllProvider(getIt<ApiService>()));
 getIt.registerFactory<CategoryProductsProvider>(() => CategoryProductsProvider(getIt<ApiService>()));
 getIt.registerFactory<ProductDetailsProvider>(() => ProductDetailsProvider(getIt<ApiService>()));
 getIt.registerFactory<ParentScreenProvider>(() => ParentScreenProvider());

}
