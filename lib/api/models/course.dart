class Course {
  Course({
    this.courseTitle,
    this.courseDesc,
    this.duration,
    this.weeklyStudy,
    this.learnType,
    this.price,
    this.discount,
    this.image,
    this.category,
    this.tags,
    this.lecturers,
    this.learners,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.courseSlug,
    this.v,
  });

  String? courseTitle;
  String? courseDesc;
  int? duration;
  int? weeklyStudy;
  String? learnType;
  int? price;
  int? discount;
  String? image;
  Category? category;
  List<String>? tags;
  List<Lecturer>? lecturers;
  List<Learner>? learners;
  double? rating;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? courseSlug;
  int? v;

  factory Course.fromJson(Map<String, dynamic> json) {
    List<Learner> learners = [];
    List<Lecturer> lecturers = [];
    var categories = null;
    try {
      learners = json["learners"] == null
          ? []
          : List<Learner>.from(
              json["learners"].map((x) => Learner.fromJson(x)));
    } catch (e) {}
    try {
      lecturers = json["lecturers"] == null
          ? []
          : List<Lecturer>.from(
              json["lecturers"].map((x) => Lecturer.fromJson(x)));
    } catch (e) {}
    try {
      categories =
          json["category"] == null ? null : Category.fromJson(json["category"]);
    } catch (e) {}

    return Course(
      courseTitle: json["courseTitle"],
      courseDesc: json["courseDesc"],
      duration: json["duration"],
      weeklyStudy: json["weekly_study"],
      learnType: json["learn_type"],
      price: json["price"] == null ? null : json["price"],
      discount: json["discount"] == null ? null : json["discount"],
      image: json["image"] == null ? null : json["image"],
      category: categories,
      tags: json["tags"] == null
          ? null
          : List<String>.from(json["tags"].map((x) => x)),
      lecturers: lecturers,
      learners: learners,
      rating: json["rating"] == null ? null : json["rating"].toDouble(),
      createdAt:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      updatedAt:
          json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      courseSlug: json["courseSlug"] == null ? null : json["courseSlug"],
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "courseTitle": courseTitle,
        "courseDesc": courseDesc,
        "duration": duration,
        "weekly_study": weeklyStudy,
        "learn_type": learnType,
        "price": price == null ? null : price,
        "discount": discount == null ? null : discount,
        "image": image == null ? null : image,
        "category": category == null ? null : category?.toJson(),
        "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x)),
        "lecturers": List<dynamic>.from(lecturers!.map((x) => x.toJson())),
        "learners": List<dynamic>.from(learners!.map((x) => x.toJson())),
        "rating": rating == null ? null : rating,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "courseSlug": courseSlug == null ? null : courseSlug,
        "__v": v,
      };
}

class Category {
  Category({
    this.categoryName,
    this.categorySlug,
  });

  String? categoryName;
  String? categorySlug;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryName: json["categoryName"],
        categorySlug: json["categorySlug"],
      );

  Map<String, dynamic> toJson() => {
        "categoryName": categoryName,
        "categorySlug": categorySlug,
      };
}

class Learner {
  Learner({
    this.firstname,
    this.lastname,
    this.email,
  });

  String? firstname;
  String? lastname;
  String? email;

  factory Learner.fromJson(Map<String, dynamic> json) {
    return Learner(
      firstname: json["firstname"],
      lastname: json["lastname"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
      };
}

class Lecturer {
  Lecturer({
    this.id,
    this.user,
    this.joinDate,
  });

  String? id;
  Learner? user;
  DateTime? joinDate;

  factory Lecturer.fromJson(Map<String, dynamic> json) => Lecturer(
        id: json["_id"],
        user: Learner.fromJson(json["user"]),
        joinDate: DateTime.parse(json["joinDate"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user?.toJson(),
        "joinDate": joinDate?.toIso8601String(),
      };
}
