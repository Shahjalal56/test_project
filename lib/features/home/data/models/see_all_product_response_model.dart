import '../../../../core/constants/api_endpoints.dart';

class SeeAllProductResponseModel {
  Products? products;

  SeeAllProductResponseModel({this.products});

  SeeAllProductResponseModel.fromJson(Map<String, dynamic> json) {
    products =
    json['products'] != null ? Products.fromJson(json['products']) : null;
  }
}

class Products {
  int? currentPage;
  List<ProductData>? data;
  int? lastPage;
  int? total;

  Products({this.currentPage, this.data, this.lastPage, this.total});

  Products.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ProductData>[];
      json['data'].forEach((v) {
        data!.add(ProductData.fromJson(v));
      });
    }
    lastPage = json['last_page'];
    total = json['total'];
  }
}

class ProductData {
  int? id;
  String? name;
  String? thumbImage;
  double? price;
  double? offerPrice;
  String? averageRating;

  ProductData({
    this.id,
    this.name,
    this.thumbImage,
    this.price,
    this.offerPrice,
    this.averageRating,
  });

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

    String rawImage = json['thumb_image'] ?? '';
    thumbImage = (rawImage.isNotEmpty && !rawImage.startsWith('http'))
        ? "${ApiEndPoints.imageBaseUrl}$rawImage"
        : rawImage;

    price =
    json['price'] != null ? (json['price'] as num).toDouble() : 0.0;
    offerPrice = json['offer_price'] != null
        ? (json['offer_price'] as num).toDouble()
        : 0.0;

    averageRating = json['averageRating']?.toString();
  }
}
