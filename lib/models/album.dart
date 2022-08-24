class Album {
  String? id;
  String? title;
  String? link;
  String? cover;
  String? coverSmall;
  String? coverMedium;
  String? coverBig;
  String? coverXl;
  String? md5Image;
  String? releaseDate;
  String? tracklist;
  String? type;

  Album(
      {this.id,
      this.title,
      this.link,
      this.cover,
      this.coverSmall,
      this.coverMedium,
      this.coverBig,
      this.coverXl,
      this.md5Image,
      this.releaseDate,
      this.tracklist,
      this.type});

  Album.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'];
    link = json['link'];
    cover = json['cover'];
    coverSmall = json['cover_small'];
    coverMedium = json['cover_medium'];
    coverBig = json['cover_big'];
    coverXl = json['cover_xl'];
    md5Image = json['md5_image'];
    releaseDate = json['release_date'];
    tracklist = json['tracklist'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['link'] = link;
    data['cover'] = cover;
    data['cover_small'] = coverSmall;
    data['cover_medium'] = coverMedium;
    data['cover_big'] = coverBig;
    data['cover_xl'] = coverXl;
    data['md5_image'] = md5Image;
    data['release_date'] = releaseDate;
    data['tracklist'] = tracklist;
    data['type'] = type;
    return data;
  }
}
