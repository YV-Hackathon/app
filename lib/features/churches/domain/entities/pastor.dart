class Pastor {
  final String id;
  final String name;
  final String title;
  final String imageUrl;
  final String? tenure; // e.g., "1969-2025", "2012-Present"
  final String description;
  final List<String> attributes;

  const Pastor({
    required this.id,
    required this.name,
    required this.title,
    required this.imageUrl,
    this.tenure,
    required this.description,
    required this.attributes,
  });

  Pastor copyWith({
    String? id,
    String? name,
    String? title,
    String? imageUrl,
    String? tenure,
    String? description,
    List<String>? attributes,
  }) {
    return Pastor(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      tenure: tenure ?? this.tenure,
      description: description ?? this.description,
      attributes: attributes ?? this.attributes,
    );
  }
}
