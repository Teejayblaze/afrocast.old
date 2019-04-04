/// This class is expected to model our
/// incoming data structure in such a way
/// we can relate to each field and to avoid
/// unnecessary dynamic unknown value type.


class AfrocastFeedEnclosure {
  AfrocastFeedEnclosure({
    this.type,
    this.url,
    this.length,
  });

  final String type;
  final String url;
  final int length;


  factory AfrocastFeedEnclosure.fromJSON(Map<String, dynamic> json) => new AfrocastFeedEnclosure(
    type: json['type'],
    url: json['url'],
    length: json['length'],
  );
}