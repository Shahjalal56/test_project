import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularSellsScreen extends StatelessWidget {
  const PopularSellsScreen({super.key});

  Widget _buildFeature(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 2.h),
            height: 6.w,
            width: 6.w,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
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
                          color: Color(0xFFF5E6D3),
                          borderRadius: BorderRadius.zero,
                        ),
                        child: Image.asset(
                          'assets/images/ihopne1.png',
                          fit: BoxFit.scaleDown,
                          cacheHeight: 360,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.phone_android, size: 100),
                            );
                          },
                        ),
                      ),

                      // Custom AppBar
                      Positioned(
                        top: 34.h,
                        left: 14.w,
                        right: 16.w,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
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
                            SizedBox(width: 60.w),
                            Text(
                              'Popular Sells',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 24,
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        bottom: -32.h,
                        left: 16.w,
                        right: 16.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(4, (index) {
                            return Container(
                              height: 60.h,
                              width: 70.w,
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.zero,
                                border: Border.all(
                                  color: index == 0
                                      ? const Color(0xFFfebb38)
                                      : Colors.grey.shade300,
                                  width: index == 0 ? 2 : 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  )
                                ],
                              ),
                              child: Image.asset(
                                'assets/images/iphoe2.png',
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.phone_android,
                                    size: 24.sp,
                                    color: Colors.grey,
                                  );
                                },
                              ),
                            );
                          }),
                        ),
                      ),

                    ],
                  ),

                  // Product Details Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50.h),

                        // Price Section
                        Row(
                          children: [
                            Text(
                              '\$6.99',
                              style: TextStyle(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              '\$9.99',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'MOBILE PHONES',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Samsung Galaxy Z Fold3 5G\n3 colors in 512GB',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 1.3,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            ...List.generate(5, (index) => Icon(
                              Icons.star,
                              color: const Color(0xFFfebb38),
                              size: 20.sp,
                            )),
                            SizedBox(width: 8.w),
                            Text(
                              '6 Reviews',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'It is a long established fact that a reader will be distracted by the readable.',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade600,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          'Introduction',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry...',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          'Features :',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        _buildFeature('slim body with metal cover'),
                        _buildFeature('latest Intel Core i5-1135G7 processor'),
                        _buildFeature('8GB DDR4 RAM and fast 512GB PCIe SSD'),
                        _buildFeature('NVIDIA GeForce MX350 2GB GDDR5 graphics'),
                        SizedBox(height: 100.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Add to Cart Section
          Container(
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
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.zero,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.black,
                      ),
                    ),
                    Positioned(
                      top: -5,
                      right: -5,
                      child: Container(
                        height: 22.w,
                        width: 22.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFFfebb38),
                          borderRadius: BorderRadius.zero,
                        ),
                        child: Center(
                          child: Text(
                            '3',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 50.h,
                      decoration: const BoxDecoration(
                        color: Color(0xFFfebb38),
                        borderRadius: BorderRadius.zero,
                      ),
                      child: Center(
                        child: Text(
                          'Add To Cart',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}