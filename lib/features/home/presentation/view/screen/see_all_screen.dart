import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/routes/route_names.dart';

class SeeAllScreen extends StatelessWidget {
  SeeAllScreen({super.key});

  final List<Map<String, dynamic>> products = [
    {'name': 'Samsung Galaxy 3 in 512GB', 'price': 69, 'oldPrice': 87, 'image': 'assets/images/im1.png', 'rating': 5.0},
    {'name': 'Samsung Galaxy 3 in 512GB', 'price': 69, 'oldPrice': null, 'image': 'assets/images/image2.png', 'rating': 5.0},
    {'name': 'Samsung Galaxy 3 in 512GB', 'price': 69, 'oldPrice': 87, 'image': 'assets/images/image3.png', 'rating': 5.0},
    {'name': 'Samsung Galaxy 3 in 512GB', 'price': 69, 'oldPrice': null, 'image': 'assets/images/image4.png', 'rating': 5.0},
    {'name': 'Samsung Galaxy 3 in 512GB', 'price': 69, 'oldPrice': 87, 'image': 'assets/images/image5.png', 'rating': 5.0},
    {'name': 'Samsung Galaxy 3 in 512GB', 'price': 69, 'oldPrice': null, 'image': 'assets/images/image6.png', 'rating': 5.0},
    {'name': 'Samsung Galaxy 3 in 512GB', 'price': 69, 'oldPrice': 87, 'image': 'assets/images/im1.png', 'rating': 5.0},
    {'name': 'Samsung Galaxy 3 in 512GB', 'price': 69, 'oldPrice': null, 'image': 'assets/images/image2.png', 'rating': 5.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40.w,
                      width: 40.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFfebb38),
                        shape: BoxShape.circle,
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
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      _buildSearchBar(),
                      SizedBox(height: 20.h),
                      _buildNewArrivalsSection(),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade400, size: 22.sp),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
        ),
      ),
    );
  }

  Widget _buildNewArrivalsSection() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14.w,
        mainAxisSpacing: 14.h,
        childAspectRatio: 0.68,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductCard(context,products[index]);
      },
    );
  }

  Widget _buildProductCard(BuildContext context,Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: ()=>Navigator.pushNamed(context, RouteNames.popularSellsScreen),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                    ),
                    child: ClipRRect(
                      child: Image.asset(
                        product['image'],
                        fit: BoxFit.contain,
                        cacheHeight: 250,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(color: Color(0xFFF8F9FA), shape: BoxShape.circle),
                      child: Icon(Icons.favorite_border, size: 16.sp, color: Colors.grey.shade400),
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
                  Row(
                    children: List.generate(5, (index) => Icon(Icons.star, size: 12.sp, color: Colors.amber.shade600)),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    product['name'],
                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.black87),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Text(
                        '\$${product['price']}',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.redAccent),
                      ),
                      if (product['oldPrice'] != null) ...[
                        SizedBox(width: 5.w),
                        Text(
                          '\$${product['oldPrice']}',
                          style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade400, decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}