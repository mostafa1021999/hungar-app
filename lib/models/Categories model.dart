class Categories {
  String? id;
  String? name;
  String? image;
  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
}}