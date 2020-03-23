class IgMedia {
  final String id;
  final String mediaType;
  final String mediaUrl;

  IgMedia({this.id, this.mediaType, this.mediaUrl});

  factory IgMedia.fromJson(Map<String, dynamic> json) {
    return IgMedia(
      id: json['id'],
      mediaType: json['media_type'],
      mediaUrl: json['media_url'] ?? "",
    );
  }
}
