class ToDoModel {
  String? id;
  String title;
  String description;
  bool isCompleted;
  String? createdAt;
  String? updatedAt;

  ToDoModel(
      {this.id,
      required this.title,
      required this.description,
      required this.isCompleted,
      this.createdAt,
      this.updatedAt});

  factory ToDoModel.fromJson(Map<String, dynamic> json) => ToDoModel(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        isCompleted: json["is_completed"],
        createdAt: json["created_at"],
        updatedAt: json['updated_at'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "is_completed": isCompleted,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
