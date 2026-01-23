import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/services/api_services/api_services.dart';
import '../../data/models/home_response_model.dart';

class HomeProvider with ChangeNotifier {
  final ApiService _apiService;

  HomeProvider(ApiService apiService) : _apiService = apiService;

  // API related state
  bool _isLoading = false;
  String? _errorMessage;
  HomeResponseModel? _homeResponseModel;

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  HomeResponseModel? get homeResponseModel => _homeResponseModel;

  // Convenient getters for specific data
  List<HomepageCategories>? get categories => _homeResponseModel?.homepageCategories;
  List<NewArrivalProducts>? get newArrivalProducts => _homeResponseModel?.newArrivalProducts;

  // Get home screen data
  Future<bool> getHomeScreenData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.get(
        ApiEndPoints.getHomeScreen,
      );

      debugPrint(' Response Status: ${response.statusCode}');
      debugPrint(' Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;

        if (responseData is Map) {
          // Check for success = false
          if (responseData.containsKey('success')) {
            if (responseData['success'] == false) {
              final message = responseData['message'];
              if (message is String) {
                _errorMessage = message;
              } else if (message is Map && message.containsKey('message')) {
                _errorMessage = message['message'];
              } else {
                _errorMessage = 'Failed to load home screen data';
              }
              return false;
            }
          }

          // Check for statusCode in body
          if (responseData.containsKey('statusCode')) {
            final bodyStatusCode = responseData['statusCode'];
            if (bodyStatusCode != 200 && bodyStatusCode != 201) {
              final message = responseData['message'];
              if (message is String) {
                _errorMessage = message;
              } else if (message is Map && message.containsKey('message')) {
                _errorMessage = message['message'];
              } else {
                _errorMessage = 'Failed to load home screen data';
              }
              return false;
            }
          }
        }

        _homeResponseModel = HomeResponseModel.fromJson(response.data);
        _errorMessage = null;
        return true;
      } else {
        final message = response.data?['message'];
        _errorMessage = message is String ? message : 'Failed to load home screen data';
        return false;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData is Map) {
          final message = responseData['message'];
          if (message is String) {
            _errorMessage = message;
          } else if (message is Map && message.containsKey('message')) {
            _errorMessage = message['message'];
          } else {
            _errorMessage = 'Failed to load home screen data';
          }
        } else {
          _errorMessage = 'Failed to load home screen data';
        }
      } else if (e.type == DioExceptionType.connectionTimeout) {
        _errorMessage = 'Connection timeout. Please try again';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        _errorMessage = 'Server is not responding. Please try again';
      } else if (e.type == DioExceptionType.connectionError) {
        _errorMessage = 'Network error. Please check your connection';
      } else {
        _errorMessage = 'Network error. Please check your connection';
      }
      return false;
    } catch (e) {
      debugPrint(' Unexpected error: $e');
      _errorMessage = 'An unexpected error occurred';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
      debugPrint(' Request completed, flags reset');
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
    _homeResponseModel = null;
    notifyListeners();
  }
}