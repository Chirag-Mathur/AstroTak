import 'dart:convert';

Question questionFromJson(String str) => Question.fromJson(json.decode(str));

String questionToJson(Question data) => json.encode(data.toJson());

class Question {
    Question({
        required this.id,
        required this.name,
        required this.description,
        required this.price,
        required this.suggestions,
    });

    int id;
    String name;
    String description;
    int price;
    List<String> suggestions;

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        suggestions: List<String>.from(json["suggestions"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "suggestions": List<dynamic>.from(suggestions.map((x) => x)),
    };
}