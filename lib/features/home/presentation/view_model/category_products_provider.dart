import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/services/api_services/api_services.dart';
import '../../data/models/category_products_response_model.dart';

class CategoryProductsProvider with ChangeNotifier {
  final ApiService _apiService;

  CategoryProductsProvider(ApiService apiService) : _apiService = apiService;

  bool _isLoading = false;
  String? _errorMessage;
  CategoryProductsResponseModel? _categoryProductsModel;
  List<CategoryProduct>? _filteredProducts;
  String _searchQuery = '';

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  CategoryProductsResponseModel? get categoryProductsModel => _categoryProductsModel;
  Category? get category => _categoryProductsModel?.category;
  List<CategoryProduct>? get products => _searchQuery.isEmpty
      ? _categoryProductsModel?.products
      : _filteredProducts;
  String get searchQuery => _searchQuery;

  /// Get products by category ID
  Future<bool> getProductsByCategory(int categoryId) async {
    _isLoading = true;
    _errorMessage = null;
    _categoryProductsModel = null;
    _filteredProducts = null;
    _searchQuery = '';
    notifyListeners();

    try {
      final response = await _apiService.get(
        ApiEndPoints.productsByCategory(categoryId),
      );

      debugPrint('📥 Category Products Status: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;

        if (responseData is Map) {
          if (responseData.containsKey('success') && responseData['success'] == false) {
            _errorMessage = _parseErrorMessage(responseData['message']) ?? 'Failed to load products';
            return false;
          }

          if (responseData.containsKey('statusCode')) {
            final bodyStatusCode = responseData['statusCode'];
            if (bodyStatusCode != 200 && bodyStatusCode != 201) {
              _errorMessage = _parseErrorMessage(responseData['message']) ?? 'Failed to load products';
              return false;
            }
          }
        }

        _categoryProductsModel = CategoryProductsResponseModel.fromJson(response.data);
        _errorMessage = null;

        debugPrint(' Category: ${category?.name}');
        debugPrint(' Products count: ${products?.length ?? 0}');

        return true;
      } else {
        _errorMessage = _parseErrorMessage(response.data?['message']) ?? 'Failed to load products';
        return false;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        _errorMessage = _parseErrorMessage(responseData is Map ? responseData['message'] : null) ?? 'Server error';
      } else {
        switch (e.type) {
          case DioExceptionType.connectionTimeout:
            _errorMessage = 'Connection timeout. Please try again';
            break;
          case DioExceptionType.receiveTimeout:
            _errorMessage = 'Server is not responding';
            break;
          case DioExceptionType.connectionError:
            _errorMessage = 'Network error. Please check your connection';
            break;
          default:
            _errorMessage = 'Network error. Please check your connection';
        }
      }
      return false;
    } catch (e) {
      debugPrint(' Unexpected error: $e');
      _errorMessage = 'An unexpected error occurred';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Search products by query
  void searchProducts(String query) {
    _searchQuery = query.toLowerCase().trim();

    if (_searchQuery.isEmpty) {
      _filteredProducts = null;
    } else {
      _filteredProducts = _categoryProductsModel?.products?.where((product) {
        final name = product.name?.toLowerCase() ?? '';
        final shortName = product.shortName?.toLowerCase() ?? '';
        return name.contains(_searchQuery) || shortName.contains(_searchQuery);
      }).toList();
    }

    notifyListeners();
    debugPrint('🔍 Search: "$_searchQuery" - Found: ${_filteredProducts?.length ?? products?.length ?? 0} products');
  }

  /// Clear search
  void clearSearch() {
    _searchQuery = '';
    _filteredProducts = null;
    notifyListeners();
  }

  String? _parseErrorMessage(dynamic message) {
    if (message is String) return message;
    if (message is Map && message.containsKey('message')) return message['message'];
    return null;
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _categoryProductsModel = null;
    _filteredProducts = null;
    _searchQuery = '';
    notifyListeners();
  }
}