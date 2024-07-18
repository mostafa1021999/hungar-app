class Provider {
  List<Data>? data;
  int? count;

  Provider.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    count = json['count'];
  }
}

class Data {
  String? id;
  String? providerName;
  String? providerImage;
  String? providerCover;
  String? description;
  String? createdAt;
  String? updatedAt;
  List<ProviderCategories>? categories;
  List<Branches>? branches;
  List<Items>? items;
  int? itemCount;
  int? categoryCount;
  int? branchesCount;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerName = json['provider_name'];
    providerImage = json['provider_image'];
    providerCover = json['provider_cover'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['categories'] != null) {
      categories = <ProviderCategories>[];
      json['categories'].forEach((v) {
        categories!.add(new ProviderCategories.fromJson(v));
      });
    }
    if (json['branches'] != null) {
      branches = <Branches>[];
      json['branches'].forEach((v) {
        branches!.add(new Branches.fromJson(v));
      });
    }
    itemCount = json['itemCount'];
    categoryCount = json['categoryCount'];
    branchesCount = json['branchesCount'];
  }
}
class ProviderCategories {
  String? id;
  String? name;
  String? image;

  ProviderCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
class Items {
  String? id;
  String? name;
  int? calories;
  int? price;
  int? discount;
  bool? topItem;
  String? image;
  String? description;

  Items(
      {this.id,
        this.name,
        this.calories,
        this.price,
        this.discount,
        this.topItem,
        this.image,
        this.description});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    calories = json['calories'];
    price = json['price'];
    discount = json['discount'];
    topItem = json['top_item'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['calories'] = this.calories;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['top_item'] = this.topItem;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }
}
class Branches {
  String? id;
  String? branchName;
  Location? location;
  String? description;

  Branches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchName = json['branch_name'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    description = json['description'];
  }

}

class Location {
  String? type;
  List<int>? coordinates;

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<int>();
  }
}