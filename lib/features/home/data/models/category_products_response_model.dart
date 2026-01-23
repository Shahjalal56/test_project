import '../../../../core/constants/api_endpoints.dart';

class CategoryProductsResponseModel {
  Category? category;
  List<CategoryProduct>? products;

  CategoryProductsResponseModel({this.category, this.products});

  CategoryProductsResponseModel.fromJson(Map<String, dynamic> json) {
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['products'] != null) {
      products = <CategoryProduct>[];
      json['products'].forEach((v) {
        products!.add(CategoryProduct.fromJson(v));
      });
    }
  }
}

class Category {
  int? id;
  String? name;
  String? slug;
  String? icon;
  String? image;

  Category({this.id, this.name, this.slug, this.icon, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    icon = json['icon'];
    String rawImage = json['image'] ?? '';
    image = (rawImage.isNotEmpty && !rawImage.startsWith('http'))
        ? "${ApiEndPoints.imageBaseUrl}$rawImage"
        : rawImage;
  }
}

class CategoryProduct {
  int? id;
  String? name;
  String? shortName;
  String? slug;
  String? thumbImage;
  int? qty;
  int? soldQty;
  double? price;
  double? offerPrice;
  int? isUndefine;
  int? isFeatured;
  int? newProduct;
  int? isTop;
  int? isBest;
  int? categoryId;
  int? subCategoryId;
  int? childCategoryId;
  int? brandId;
  String? averageRating;
  String? totalSold;
  List<ActiveVariants>? activeVariants;

  CategoryProduct({
    this.id,
    this.name,
    this.shortName,
    this.slug,
    this.thumbImage,
    this.qty,
    this.soldQty,
    this.price,
    this.offerPrice,
    this.isUndefine,
    this.isFeatured,
    this.newProduct,
    this.isTop,
    this.isBest,
    this.categoryId,
    this.subCategoryId,
    this.childCategoryId,
    this.brandId,
    this.averageRating,
    this.totalSold,
    this.activeVariants,
  });

  CategoryProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['short_name'];
    slug = json['slug'];

    String rawImage = json['thumb_image'] ?? '';
    thumbImage = (rawImage.isNotEmpty && !rawImage.startsWith('http'))
        ? "${ApiEndPoints.imageBaseUrl}$rawImage"
        : rawImage;

    qty = json['qty'];
    soldQty = json['sold_qty'];

    if (json['price'] != null) {
      price = (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : json['price'] as double?;
    }

    if (json['offer_price'] != null) {
      offerPrice = (json['offer_price'] is int)
          ? (json['offer_price'] as int).toDouble()
          : json['offer_price'] as double?;
    }

    isUndefine = json['is_undefine'];
    isFeatured = json['is_featured'];
    newProduct = json['new_product'];
    isTop = json['is_top'];
    isBest = json['is_best'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    childCategoryId = json['child_category_id'];
    brandId = json['brand_id'];
    averageRating = json['averageRating']?.toString();
    totalSold = json['totalSold']?.toString();

    if (json['active_variants'] != null) {
      activeVariants = <ActiveVariants>[];
      json['active_variants'].forEach((v) {
        activeVariants!.add(ActiveVariants.fromJson(v));
      });
    }
  }
}

class ActiveVariants {
  int? id;
  String? name;
  int? productId;
  List<ActiveVariantItems>? activeVariantItems;

  ActiveVariants({this.id, this.name, this.productId, this.activeVariantItems});

  ActiveVariants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    productId = json['product_id'];
    if (json['active_variant_items'] != null) {
      activeVariantItems = <ActiveVariantItems>[];
      json['active_variant_items'].forEach((v) {
        activeVariantItems!.add(ActiveVariantItems.fromJson(v));
      });
    }
  }
}

class ActiveVariantItems {
  int? productVariantId;
  String? name;
  double? price;
  int? id;

  ActiveVariantItems({this.productVariantId, this.name, this.price, this.id});

  ActiveVariantItems.fromJson(Map<String, dynamic> json) {
    productVariantId = json['product_variant_id'];
    name = json['name'];

    if (json['price'] != null) {
      price = (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : json['price'] as double?;
    }

    id = json['id'];
  }
}