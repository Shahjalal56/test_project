import 'package:job_test/features/home/presentation/view_model/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../core/di/di_configs.dart';
import '../../features/home/presentation/view_model/category_products_provider.dart';
import '../../features/home/presentation/view_model/product_details_provider.dart';
import '../../features/home/presentation/view_model/see_all_product_provider.dart';
import '../../features/parent/viewmodel/ParentScreenProvider.dart';

class AppViewModels {
  static final List<SingleChildWidget> viewmodels = [
    ChangeNotifierProvider<HomeProvider>(
      create: (_) => getIt<HomeProvider>(),
    ),
    ChangeNotifierProvider<ParentScreenProvider>(
      create: (_) => getIt<ParentScreenProvider>(),
    ),

    ChangeNotifierProvider<SeeAllProvider>(
      create: (_) => getIt<SeeAllProvider>(),
    ),
    ChangeNotifierProvider<ProductDetailsProvider>(
      create: (_) => getIt<ProductDetailsProvider>(),
    ),
    ChangeNotifierProvider<CategoryProductsProvider>(
      create: (_) => getIt<CategoryProductsProvider>(),
    ),




  ];
}