class CategoryProviderModel {
  String? id;
  String? name;
  String? image;
  List<CategoryProvidersModelData>? providers;

  CategoryProviderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['providers'] != null) {
      providers = <CategoryProvidersModelData>[];
      json['providers'].forEach((v) {
        providers!.add(CategoryProvidersModelData.fromJson(v));
      });
    }
  }
}

class CategoryProvidersModelData {
  String? id;
  String? providerName;
  ProviderLocations? providerLocation;
  String? providerImage;
  String? providerCover;
  String? description;

  CategoryProvidersModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerName = json['provider_name'];
    providerLocation = json['provider_location'] != null
        ? ProviderLocations.fromJson(json['provider_location'])
        : null;
    providerImage = json['provider_image'];
    providerCover = json['provider_cover'];
    description = json['description'];
  }
}
class ProviderLocations {
  String? type;
  List<int>? coordinates;

  ProviderLocations.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<int>();
  }
}