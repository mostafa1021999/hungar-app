class ProviderItemsMenu {
  String? id;
  String? providerName;
  ProviderLocation? providerLocation;
  String? providerImage;
  String? providerCover;
  String? description;
  List reviews = [];
  List<ItemsCategory>? CategoriesItemsData;

  ProviderItemsMenu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerName = json['provider_name'];
    providerLocation = json['provider_location'] != null && json['provider_location'] is Map<String, dynamic>
        ? ProviderLocation.fromJson(json['provider_location'])
        : null;
    providerImage = json['provider_image'];
    providerCover = json['provider_cover'];
    description = json['description'];
    reviews = json['reviews'] ?? [];
    if (json['items'] != null) {
      CategoriesItemsData = <ItemsCategory>[];
      json['items'].forEach((v) {
        CategoriesItemsData!.add(new ItemsCategory.fromJson(v));
      });
    }
  }
}

class ProviderLocation {
  String? type;
  List<double>? coordinates;

  ProviderLocation({this.type, this.coordinates});

  ProviderLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'] != null && json['coordinates'] is List
        ? json['coordinates'].cast<double>()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class CategoriesItems {
  String? name;
  String? id;
  List<Items>? items;

  CategoriesItems.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
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
  List<Null>? categories;
  List<ExtraItems>? extraItems;
  List<Null>? orderItems;

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    calories = json['calories'];
    price = json['price'];
    discount = json['discount'];
    topItem = json['top_item'];
    image = json['image'];
    description = json['description'];

    if (json['extraItems'] != null) {
      extraItems = <ExtraItems>[];
      json['extraItems'].forEach((v) {
        extraItems!.add(new ExtraItems.fromJson(v));
      });
    }
  }
}
class ItemsCategory {
  String? name;
  String? id;
  List<Items>? items;

  ItemsCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }
}
class ExtraItems {
  String? id;
  String? name;
  int? price;
  String? image;

  ExtraItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
  }
}
class OrderItem {
  String? id;
  String? name;
  int? quantity;

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
  }
}
