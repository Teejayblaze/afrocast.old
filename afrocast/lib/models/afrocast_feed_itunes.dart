/// This class is expected to model our
/// incoming data structure in such a way
/// we can relate to each field and to avoid
/// unnecessary dynamic unknown value type.


class AfrocastFeedItunes {
  AfrocastFeedItunes({
    this.duration,
    this.author,
    this.explicit,
    this.summary,
    this.subtitle,
    this.image,
  });

  final String duration;
  final String author;
  final String explicit;
  final String summary;
  final String subtitle;
  final String image;


  factory AfrocastFeedItunes.fromJSON(Map<String, dynamic> json) => new AfrocastFeedItunes(
    duration: json['duration'],
    author: json['author'],
    explicit: json['explicit'],
    summary: json['summary'],
    subtitle: json['subtitle'],
    image: json['image'],
  );
}