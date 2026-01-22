import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../home/presentation/view/screen/home_screen.dart';
import '../viewmodel/ParentScreenProvider.dart';


class ParentScreen extends StatelessWidget {
  const ParentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeScreen(),
      const HomeScreen(),
      const HomeScreen(),
      const HomeScreen(),

    ];

    final provider = Provider.of<ParentScreenProvider>(context);
    final currentIndex = provider.currentIndex;

    return Scaffold(
      backgroundColor: Colors.white,
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        height: 80.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15.r,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) => provider.setIndex(index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFFFF6B00),
            unselectedItemColor: Colors.grey.shade500,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle:  TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/icon1.png',
                  width: 25.w,
                  height: 25.h,
                ),
                activeIcon: Image.asset(
                  'assets/icons/icon1.png',
                  width: 25.w,
                  height: 25.h,
                  color: const Color(0xFFFF6B00),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/icon2.png',
                  width: 25.w,
                  height: 25.h,
                ),
                activeIcon: Image.asset(
                  'assets/icons/icon2.png',
                  width: 25.w,
                  height: 25.h,
                  color: const Color(0xFFFF6B00),
                ),
                label: 'Message',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/icon3.png',
                  width: 25.w,
                  height: 25.h,
                ),
                activeIcon: Image.asset(
                  'assets/icons/icon3.png',
                  width: 25.w,
                  height: 25.h,
                  color: const Color(0xFFFF6B00),
                ),
                label: 'Order',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/icon4.png',
                  width: 25.w,
                  height: 25.h,
                ),
                activeIcon: Image.asset(
                  'assets/icons/icon4.png',
                  width: 25.w,
                  height: 25.h,
                  color: const Color(0xFFFF6B00),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}