class Meal {
  final String id;
  final String name;
  final int calories;

  Meal({required this.id, required this.name, required this.calories});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'].toString(),
      name: json['name'],
      calories: json['calories'],
    );
  }
}
