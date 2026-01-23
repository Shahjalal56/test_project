import '../../../../core/constants/api_endpoints.dart';

class ProductDetailsResponseModel {
  Product? product;
  List<Gallery>? gallery;
  List<RelatedProduct>? relatedProducts;

  ProductDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    if (json['gellery'] != null) {
      gallery = <Gallery>[];
      json['gellery'].forEach((v) => gallery!.add(Gallery.fromJson(v)));
    }
    if (json['relatedProducts'] != null) {
      relatedProducts = <RelatedProduct>[];
      json['relatedProducts'].forEach((v) => relatedProducts!.add(RelatedProduct.fromJson(v)));
    }
  }
}

class Product {
  int? id;
  String? name;
  String? thumbImage;
  String? slug;
  double? price;
  double? offerPrice;
  String? shortDescription;
  String? longDescription;
  String? averageRating;
  Category? category;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    averageRating = json['averageRating']?.toString();
    String rawImage = json['thumb_image'] ?? '';
    thumbImage = (rawImage.isNotEmpty && !rawImage.startsWith('http'))
        ? "${ApiEndPoints.imageBaseUrl}$rawImage" : rawImage;
    price = json['price'] != null ? (json['price'] as num).toDouble() : 0.0;
    offerPrice = json['offer_price'] != null ? (json['offer_price'] as num).toDouble() : 0.0;
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
  }
}

class Category {
  String? name;
  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}

class Gallery {
  String? image;
  Gallery.fromJson(Map<String, dynamic> json) {
    String rawImg = json['image'] ?? '';
    image = (rawImg.isNotEmpty && !rawImg.startsWith('http'))
        ? "${ApiEndPoints.imageBaseUrl}$rawImg" : rawImg;
  }
}

class RelatedProduct {
  int? id;
  String? name;
  String? thumbImage;
  double? price;
  RelatedProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    String rawImg = json['thumb_image'] ?? '';
    thumbImage = (rawImg.isNotEmpty && !rawImg.startsWith('http'))
        ? "${ApiEndPoints.imageBaseUrl}$rawImg" : rawImg;
    price = json['price'] != null ? (json['price'] as num).toDouble() : 0.0;
  }
}
