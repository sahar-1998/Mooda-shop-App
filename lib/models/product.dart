import 'package:Modda_shop/models/slider.dart';
import 'package:Modda_shop/models/sub_category.dart';

class Product {
  late int id;
  late String nameEn;
  late String nameAr;
  late String infoEn;
  late String infoAr;
  late int price;
  late int quantity;
  late int overalRate;
  late int subCategoryId;
  late int productRate;
  late int? offerPrice;
  late bool isFavorite;
  late String imageUrl;

  late List<SliderModel> images;
  late SubCategory subCategory;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    infoEn = json['info_en'];
    infoAr = json['info_ar'];
    price = json['price'];
    quantity = json['quantity'];
    overalRate = json['overal_rate'];
    subCategoryId = json['sub_category_id'];
    productRate = json['product_rate'];
    offerPrice = json['offer_price'];
    isFavorite = json['is_favorite'];
    imageUrl = json['image_url'];

    if (json.containsKey('images') && json['images'] != null) {
      images = <SliderModel>[];
      json['images'].forEach((v) {
        images.add(SliderModel.fromJson(v));
      });
    }

    if (json.containsKey('sub_category') && json['sub_category'] != null) {
      subCategory = SubCategory.fromJson(json['sub_category']);
    }
  }
}
