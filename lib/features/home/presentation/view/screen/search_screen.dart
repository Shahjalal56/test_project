import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../app/routes/route_names.dart';
import '../../../../../core/constants/api_endpoints.dart';
import '../../../data/models/home_response_model.dart';
import '../../view_model/home_provider.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late HomeProvider _homeProvider;
  List<NewArrivalProducts> _searchResults = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeProvider = context.read<HomeProvider>();
    });
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    final allProducts = _homeProvider.newArrivalProducts ?? [];
    final queryLower = query.toLowerCase();

    final results = allProducts.where((product) {
      final name = product.name?.toLowerCase() ?? '';
      final shortName = product.shortName?.toLowerCase() ?? '';
      return name.contains(queryLower) || shortName.contains(queryLower);
    }).toList();

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey.shade400),
          ),
          onChanged: _performSearch,
          onSubmitted: (value) {
            _performSearch(value);
          },
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.grey),
              onPressed: () {
                _searchController.clear();
                _performSearch('');
              },
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isSearching) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFFfebb38)),
      );
    }

    if (_searchController.text.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 60.sp, color: Colors.grey.shade300),
            SizedBox(height: 16.h),
            Text(
              'Search for products',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 60.sp, color: Colors.grey.shade300),
            SizedBox(height: 16.h),
            Text(
              'No products found for "${_searchController.text}"',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        return _buildProductItem(_searchResults[index]);
      },
    );
  }

  Widget _buildProductItem(NewArrivalProducts product) {
    return ListTile(
      leading: Container(
        width: 50.w,
        height: 50.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.white,
        ),
        child: product.thumbImage != null
            ? Image.network(
          product.thumbImage!.startsWith('http')
              ? product.thumbImage!
              : '${ApiEndPoints.imageBaseUrl}${product.thumbImage}',
          fit: BoxFit.cover,
        )
            : Icon(Icons.image, color: Colors.grey.shade300),
      ),
      title: Text(
        product.name ?? 'Unknown Product',
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
        style: TextStyle(
          fontSize: 13.sp,
          color: const Color(0xFFfebb38),
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteNames.popularSellsScreen,
          arguments: product.slug ?? '',
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}