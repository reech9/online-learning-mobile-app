import 'dart:convert';

class Category {
  Category({
    this.id,
    this.categoryName,
    this.categoryShortDesc,
    this.categoryDesc,
    this.categorySlug,
    this.subCategories,
    this.parentCategory,
    this.image
  });

  String? id;
  List<String> ? image;
  String? categoryName;
  String? categoryShortDesc;
  String? categoryDesc;
  String? categorySlug;
  List<Category>? subCategories;
  String? parentCategory;


  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        image: json["image"] == null ? null : List<String>.from(json["image"].map((x) => x)),
        categoryName: json["categoryName"],
        categoryShortDesc: json["categoryShortDesc"],
        categoryDesc: json["categoryDesc"],
        categorySlug: json["categorySlug"],
        subCategories: json["subCategories"] == null
            ? null
            : List<Category>.from(
                json["subCategories"].map((x) => Category.fromJson(x))),
        parentCategory:
            json["parentCategory"] == null ? null : json["parentCategory"],
      );

  static Map<String, dynamic> toJson(Category category) => {
        "_id": category.id,
        "image":category.image! == null ? null : List<dynamic>.from(category.image!.map((x) => x)),
        "categoryName": category.categoryName,
        "categoryShortDesc": category.categoryShortDesc,
        "categoryDesc": category.categoryDesc,
        "categorySlug": category.categorySlug,
        "subCategories": category.subCategories == null
            ? null
            : List<dynamic>.from(category.subCategories!.map((x) => Category.toJson(category))),
        "parentCategory": category.parentCategory == null ? null : category.parentCategory,
      };


  static String encode(List<Category> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => Category.toJson(music))
        .toList(),
  );

  static List<Category> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<Category>((item) => Category.fromJson(item))
          .toList();
}
