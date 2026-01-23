import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/services/api_services/api_services.dart';
import '../../data/models/see_all_product_response_model.dart';


class SeeAllProvider with ChangeNotifier {
  final ApiService _apiService;

  SeeAllProvider(ApiService apiService) : _apiService = apiService;

  bool _isLoading = false;
  String? _errorMessage;
  SeeAllProductResponseModel? _seeAllProductResponseModel;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  SeeAllProductResponseModel? get seeAllProductResponseModel =>
      _seeAllProductResponseModel;

  List<ProductData>? get allProducts =>
      _seeAllProductResponseModel?.products?.data;

  Future<bool> getSeeAllProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.get(
        ApiEndPoints.getSeeAllProduct,
      );

      debugPrint(' See All Status: ${response.statusCode}');
      debugPrint(' See All Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;

        if (responseData is Map) {
          if (responseData.containsKey('success')) {
            if (responseData['success'] == false) {
              final message = responseData['message'];
              if (message is String) {
                _errorMessage = message;
              } else if (message is Map &&
                  message.containsKey('message')) {
                _errorMessage = message['message'];
              } else {
                _errorMessage = 'Failed to load products';
              }
              return false;
            }
          }

          if (responseData.containsKey('statusCode')) {
            final bodyStatusCode = responseData['statusCode'];
            if (bodyStatusCode != 200 && bodyStatusCode != 201) {
              final message = responseData['message'];
              if (message is String) {
                _errorMessage = message;
              } else if (message is Map &&
                  message.containsKey('message')) {
                _errorMessage = message['message'];
              } else {
                _errorMessage = 'Failed to load products';
              }
              return false;
            }
          }
        }

        _seeAllProductResponseModel =
            SeeAllProductResponseModel.fromJson(response.data);
        _errorMessage = null;
        return true;
      } else {
        final message = response.data?['message'];
        _errorMessage =
        message is String ? message : 'Failed to load products';
        return false;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData is Map) {
          final message = responseData['message'];
          if (message is String) {
            _errorMessage = message;
          } else if (message is Map &&
              message.containsKey('message')) {
            _errorMessage = message['message'];
          } else {
            _errorMessage = 'Failed to load products data';
          }
        } else {
          _errorMessage = 'Failed to load products data';
        }
      } else if (e.type == DioExceptionType.connectionTimeout) {
        _errorMessage = 'Connection timeout. Please try again';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        _errorMessage = 'Server is not responding. Please try again';
      } else if (e.type == DioExceptionType.connectionError) {
        _errorMessage =
        'Network error. Please check your connection';
      } else {
        _errorMessage =
        'Network error. Please check your connection';
      }
      return false;
    } catch (e) {
      debugPrint(' Unexpected error in SeeAll: $e');
      _errorMessage = 'An unexpected error occurred';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
      debugPrint(' See All Request completed');
    }
  }

  void setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _seeAllProductResponseModel = null;
    notifyListeners();
  }
}
