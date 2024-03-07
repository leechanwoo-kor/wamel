import 'dart:convert';

class Level {
  late String image;
  late double radius;

  // Default constructor is not changed but is here for clarity.
  Level(this.radius, this.image);

  Level.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    radius = json['radius'].toDouble(); // Ensure this is a double.
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['radius'] = radius;
    return data;
  }

  static List<Level> fromJsonList(List<dynamic> list) { // Specify type for list.
    return list.map((item) => Level.fromJson(item as Map<String, dynamic>)).toList();
  }

  static String toJsons(List<Level> levels) =>
      levels.map((e) => jsonEncode(e.toJson())).join('|');

  static List<Level> fromJsons(String result) {
    return result.split('|').map((e) => Level.fromJson(jsonDecode(e) as Map<String, dynamic>)).toList();
  }
}
