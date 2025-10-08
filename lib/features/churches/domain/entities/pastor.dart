class Pastor {
  final String id;
  final String name;
  final String title;
  final String imageUrl;
  final String? tenure; // e.g., "1969-2025", "2012-Present"

  const Pastor({
    required this.id,
    required this.name,
    required this.title,
    required this.imageUrl,
    this.tenure,
  });

  Pastor copyWith({
    String? id,
    String? name,
    String? title,
    String? imageUrl,
    String? tenure,
  }) {
    return Pastor(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      tenure: tenure ?? this.tenure,
    );
  }
}
