import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../app/routes/route_names.dart';
import '../../view_model/see_all_product_provider.dart';

class SeeAllScreen extends StatefulWidget {
  const SeeAllScreen({super.key});

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SeeAllProvider>().getSeeAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Consumer<SeeAllProvider>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading &&
                viewModel.seeAllProductResponseModel == null) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFFfebb38)),
              );
            }

            if (viewModel.errorMessage != null &&
                viewModel.seeAllProductResponseModel == null) {
              return _buildErrorWidget(viewModel);
            }

            return Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => viewModel.getSeeAllProducts(),
                    color: const Color(0xFFfebb38),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            SizedBox(height: 16.h),
                            _buildSearchBar(),
                            SizedBox(height: 20.h),
                            _buildProductGrid(viewModel),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 40.w,
              width: 40.w,
              decoration: const BoxDecoration(
                color: Color(0xFFfebb38),
                borderRadius: BorderRadius.zero,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 18,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            'All Products',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.zero,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search products',
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15.sp),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey.shade400,
            size: 22.sp,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
        ),
      ),
    );
  }

  Widget _buildProductGrid(SeeAllProvider viewModel) {
    final products = viewModel.allProducts ?? [];

    if (products.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 100.h),
          child: Text(
            'No products found',
            style: TextStyle(fontSize: 16.sp, color: Colors.grey),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14.w,
        mainAxisSpacing: 14.h,
        childAspectRatio: 0.65,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductCard(products[index]);
      },
    );
  }

  Widget _buildProductCard(product) {
    final hasDiscount =
        product.offerPrice != null &&
        product.offerPrice! > 0 &&
        product.offerPrice! < (product.price ?? 0);
    final displayPrice = hasDiscount ? product.offerPrice! : product.price ?? 0;
    final rating = double.tryParse(product.averageRating ?? '0') ?? 0.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.zero,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, RouteNames.popularSellsScreen),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10.w),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Image.network(
                      product.thumbImage ?? '',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.zero,
                      ),
                      child: Icon(
                        Icons.favorite_border,
                        size: 16.sp,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < rating.floor()
                              ? Icons.star
                              : Icons.star_border,
                          size: 12.sp,
                          color: Colors.amber.shade600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    product.name ?? '',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      children: [
                        Text(
                          '\$${displayPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                        if (hasDiscount) ...[
                          SizedBox(width: 5.w),
                          Text(
                            '\$${product.price!.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.grey.shade400,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(SeeAllProvider viewModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
          SizedBox(height: 16.h),
          Text(
            viewModel.errorMessage!,
            style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade600),
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: () => viewModel.getSeeAllProducts(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFfebb38),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: const Text('Retry', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
