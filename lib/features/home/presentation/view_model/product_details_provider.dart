import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/services/api_services/api_services.dart';
import '../../data/models/product_details_response_model.dart';

class ProductDetailsProvider with ChangeNotifier {
  final ApiService _apiService;

  ProductDetailsProvider(ApiService apiService) : _apiService = apiService;

  bool _isLoading = false;
  String? _errorMessage;
  ProductDetailsResponseModel? _detailsModel;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  ProductDetailsResponseModel? get detailsModel => _detailsModel;

  Product? get product => _detailsModel?.product;
  List<Gallery>? get gallery => _detailsModel?.gallery;
  List<RelatedProduct>? get relatedProducts => _detailsModel?.relatedProducts;

  Future<bool> getProductDetails(String slug) async {
    _isLoading = true;
    _errorMessage = null;
    _detailsModel = null;
    notifyListeners();

    try {
      final response = await _apiService.get(ApiEndPoints.productDetails(slug));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;

        if (responseData is Map) {
          if (responseData.containsKey('success') && responseData['success'] == false) {
            _errorMessage = _parseErrorMessage(responseData['message']) ?? 'Product not found';
            return false;
          }

          if (responseData.containsKey('statusCode')) {
            final bodyStatusCode = responseData['statusCode'];
            if (bodyStatusCode != 200 && bodyStatusCode != 201) {
              _errorMessage = _parseErrorMessage(responseData['message']) ?? 'Error loading details';
              return false;
            }
          }
        }

        _detailsModel = ProductDetailsResponseModel.fromJson(response.data);
        _errorMessage = null;
        return true;
      } else {
        _errorMessage = _parseErrorMessage(response.data?['message']) ?? 'Failed to load product details';
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
      _errorMessage = 'An unexpected error occurred';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
    _detailsModel = null;
    notifyListeners();
  }
}
