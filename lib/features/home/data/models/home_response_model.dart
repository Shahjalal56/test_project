import '../../../../core/constants/api_endpoints.dart';

class HomeResponseModel {
  List<HomepageCategories>? homepageCategories;
  List<NewArrivalProducts>? newArrivalProducts;

  HomeResponseModel({this.homepageCategories, this.newArrivalProducts});

  HomeResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['homepage_categories'] != null) {
      homepageCategories = <HomepageCategories>[];
      json['homepage_categories'].forEach((v) {
        homepageCategories!.add(HomepageCategories.fromJson(v));
      });
    }
    if (json['newArrivalProducts'] != null) {
      newArrivalProducts = <NewArrivalProducts>[];
      json['newArrivalProducts'].forEach((v) {
        newArrivalProducts!.add(NewArrivalProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (homepageCategories != null) {
      data['homepage_categories'] =
          homepageCategories!.map((v) => v.toJson()).toList();
    }
    if (newArrivalProducts != null) {
      data['newArrivalProducts'] =
          newArrivalProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomepageCategories {
  int? id;
  String? name;
  String? slug;
  String? icon;
  String? image;

  HomepageCategories({this.id, this.name, this.slug, this.icon, this.image});

  HomepageCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];


    icon = json['icon'];
    // String rawIcon = json['icon'] ?? '';
    String rawImage = json['image'] ?? '';

    // icon = (rawIcon.isNotEmpty && !rawIcon.startsWith('http'))
    //     ? "${ApiEndPoints.imageBaseUrl}$rawIcon"
    //     : rawIcon;

    image = (rawImage.isNotEmpty && !rawImage.startsWith('http'))
        ? "${ApiEndPoints.imageBaseUrl}$rawImage"
        : rawImage;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['icon'] = icon;
    data['image'] = image;
    return data;
  }
}

class NewArrivalProducts {
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

  NewArrivalProducts(
      {this.id,
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
        averageRating,
        totalSold,
        this.activeVariants});

  NewArrivalProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['short_name'];
    slug = json['slug'];

    String rawThumb = json['thumb_image'] ?? '';
    thumbImage = (rawThumb.isNotEmpty && !rawThumb.startsWith('http'))
        ? "${ApiEndPoints.imageBaseUrl}$rawThumb"
        : rawThumb;

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['short_name'] = shortName;
    data['slug'] = slug;
    data['thumb_image'] = thumbImage;
    data['qty'] = qty;
    data['sold_qty'] = soldQty;
    data['price'] = price;
    data['offer_price'] = offerPrice;
    data['is_undefine'] = isUndefine;
    data['is_featured'] = isFeatured;
    data['new_product'] = newProduct;
    data['is_top'] = isTop;
    data['is_best'] = isBest;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['child_category_id'] = childCategoryId;
    data['brand_id'] = brandId;
    data['averageRating'] = averageRating;
    data['totalSold'] = totalSold;
    if (activeVariants != null) {
      data['active_variants'] = activeVariants!.map((v) => v.toJson()).toList();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['product_id'] = productId;
    if (activeVariantItems != null) {
      data['active_variant_items'] =
          activeVariantItems!.map((v) => v.toJson()).toList();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_variant_id'] = productVariantId;
    data['name'] = name;
    data['price'] = price;
    data['id'] = id;
    return data;
  }
}