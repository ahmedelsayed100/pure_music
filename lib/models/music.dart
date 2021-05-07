class Music {
  final String id;
  final String name;
  final String album;

  const Music({
    this.id,
    this.name,
    this.album,
  });

  factory Music.fromJson(Map<String, dynamic> json) => Music(
        id: json['id'],
        name: json['name'],
        album: json['album'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'album': album,
      };
}
