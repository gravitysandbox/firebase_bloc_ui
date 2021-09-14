class ArrayItem {
  final String id, title, subtitle;

  ArrayItem({
    required this.id,
    required this.title,
    required this.subtitle,
  });

  ArrayItem copyWith({String? title, String? subtitle}) {
    return ArrayItem(
      id: id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
    );
  }

  ArrayItem.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          title: json['title'] as String,
          subtitle: json['subtitle'] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
    };
  }
}
