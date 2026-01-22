import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../core/di/di_configs.dart';
import '../../features/parent/viewmodel/ParentScreenProvider.dart';

class AppViewModels {
  static final List<SingleChildWidget> viewmodels = [
    // ChangeNotifierProvider<HomeProvider>(
    //   create: (_) => getIt<HomeProvider>(),
    // ),
    ChangeNotifierProvider<ParentScreenProvider>(
      create: (_) => getIt<ParentScreenProvider>(),
    ),

  ];
}