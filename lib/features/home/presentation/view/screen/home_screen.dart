import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Mobile', 'icon': 'assets/icons/jt4.png'},
    {'name': 'Gaming', 'icon': 'assets/icons/jt2.png'},
    {'name': 'Images', 'icon': 'assets/icons/jt3.png'},
    {'name': 'Vehicles', 'icon': 'assets/icons/jt4.png'},
  ];

  final List<Map<String, dynamic>> products = [
    {'name': 'Samsung Galaxy 3 in 512GB', 'price': 69, 'oldPrice': 87, 'image': 'assets/images/im1.png', 'rating': 5.0},
    {'name': 'Samsung Galaxy 3 in 512GB', 'price': 69, 'oldPrice': null, 'image': 'assets/images/image2.png', 'rating': 5.0},
    {'name': 'Samsung Galaxy 3 in 512GB', 'price': 69, 'oldPrice': 87, 'image': 'assets/images/image3.png', 'rating': 5.0},
    {'name': 'Samsung Galaxy 3 in 512GB', 'price': 69, 'oldPrice': null, 'image': 'assets/images/image4.png', 'rating': 5.0},
    {'name': 'Samsung Galaxy 3 in 512GB', 'price': 69, 'oldPrice': 87, 'image': 'assets/images/image5.png', 'rating': 5.0},
    {'name': 'Samsung Galaxy 3 in 512GB', 'price': 69, 'oldPrice': null, 'image': 'assets/images/image6.png', 'rating': 5.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: _buildSearchBar(),
              ),
              SizedBox(height: 24.h),
              _buildCategoriesSection(),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: _buildNewArrivalsSection(),
              ),
              SizedBox(height: 16.h),
            ],
          ),
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

  Widget _buildCategoriesSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                'See all',
                style: TextStyle(fontSize: 14.sp, color: Colors.blue, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: categories.map((category) {
              return _buildCategoryItem(category['name'], category['icon']);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String name, String iconPath) {
    return Column(
      children: [
        Container(
          width: 65.w,
          height: 65.w,
          padding: EdgeInsets.all(18.w),
          decoration: const BoxDecoration(color: Color(0xFFFFF5EB), shape: BoxShape.circle),
          child: Image.asset(
            iconPath,
            fit: BoxFit.contain,
            cacheWidth: 100,
          ),
        ),
        SizedBox(height: 8.h),
        Text(name, style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade800, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildNewArrivalsSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('New Arrivals', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black)),
            Icon(Icons.tune, color: Colors.grey.shade600, size: 22.sp),
          ],
        ),
        SizedBox(height: 16.h),
        GridView.builder(
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
            return _buildProductCard(products[index]);
          },
        ),
      ],
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
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
    );
  }
}