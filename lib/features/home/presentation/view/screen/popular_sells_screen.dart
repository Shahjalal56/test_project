import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../view_model/product_details_provider.dart';

class PopularSellsScreen extends StatefulWidget {
  final String productSlug;
  const PopularSellsScreen({super.key, required this.productSlug});

  @override
  State<PopularSellsScreen> createState() => _PopularSellsScreenState();
}

class _PopularSellsScreenState extends State<PopularSellsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductDetailsProvider>().getProductDetails(widget.productSlug);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Consumer<ProductDetailsProvider>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.detailsModel == null) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFfebb38)),
            );
          }

          if (viewModel.errorMessage != null && viewModel.detailsModel == null) {
            return _buildErrorWidget(viewModel);
          }

          final product = viewModel.product;
          final gallery = viewModel.gallery ?? [];

          if (product == null) {
            return const Center(child: Text("Product details not found"));
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 400.h,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFFFFF),
                            ),
                            child: Image.network(
                              product.thumbImage ?? '',
                              fit: BoxFit.scaleDown,
                              errorBuilder: (context, error, stackTrace) =>
                              const Center(
                                child: Icon(Icons.phone_android, size: 100),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 34.h,
                            left: 14.w,
                            right: 16.w,
                            child: _buildHeader(context, product.name),
                          ),
                          Positioned(
                            bottom: -32.h,
                            left: 16.w,
                            right: 16.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                gallery.length > 4 ? 4 : gallery.length,
                                    (index) => _buildGalleryItem(
                                  gallery[index].image,
                                  index == 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 50.h),
                            _buildPriceSection(product),
                            SizedBox(height: 8.h),
                            Text(
                              product.category?.name?.toUpperCase() ?? 'CATEGORY',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              product.name ?? '',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            _buildRatingSection(product),
                            SizedBox(height: 16.h),
                            Text(
                              product.shortDescription ?? '',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey.shade600,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              product.longDescription ?? '',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey.shade600,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 100.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildBottomAction(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String? name) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: 40.w,
            width: 40.w,
            decoration: const BoxDecoration(
              color: Color(0xFFfebb38),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 18,
            ),
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: Text(
            name ?? 'Popular Sells',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const Icon(Icons.favorite, color: Colors.red, size: 24),
      ],
    );
  }

  Widget _buildGalleryItem(String? imageUrl, bool isSelected) {
    return Container(
      height: 60.h,
      width: 70.w,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.zero,
        border: Border.all(
          color: isSelected ? const Color(0xFFfebb38) : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Image.network(
        imageUrl ?? '',
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
        const Icon(Icons.image, color: Colors.grey),
      ),
    );
  }

  Widget _buildPriceSection(product) {
    if (product == null) return const SizedBox.shrink();

    final hasDiscount = product.offerPrice != null && product.offerPrice! > 0;
    final displayPrice = hasDiscount ? product.offerPrice! : (product.price ?? 0);

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        children: [
          Text(
            '\$${displayPrice.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          if (hasDiscount) ...[
            SizedBox(width: 8.w),
            Text(
              '\$${(product.price ?? 0).toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRatingSection(product) {
    if (product == null) return const SizedBox.shrink();

    final rating = double.tryParse(product.averageRating ?? '0') ?? 0.0;
    return Row(
      children: [
        ...List.generate(
          5,
              (index) => Icon(
            index < rating.floor() ? Icons.star : Icons.star_border,
            color: const Color(0xFFfebb38),
            size: 20.sp,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          '${product.averageRating ?? 0} Reviews',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Icon(Icons.shopping_cart_outlined),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Container(
              height: 50.h,
              decoration: const BoxDecoration(
                color: Color(0xFFfebb38),
              ),
              child: const Center(
                child: Text(
                  'Add To Cart',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(ProductDetailsProvider viewModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
          SizedBox(height: 16.h),
          Text(
            viewModel.errorMessage!,
            style: const TextStyle(color: Colors.grey),
          ),
          TextButton(
            onPressed: () => viewModel.getProductDetails(widget.productSlug),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
