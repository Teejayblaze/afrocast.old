/// This class is expected to model our
/// incoming data structure in such a way
/// we can relate to each field and to avoid
/// unnecessary dynamic unknown value type.


import 'package:afrocast/models/afrocast_feed_itunes.dart';
import 'package:afrocast/models/afrocast_feed_enclosure.dart';

class AfrocastFeed {
  AfrocastFeed({
    this.mainTitle,
    this.episodes,
    this.title,
    this.pubDate,
    this.link,
    this.itunes,
    this.description,
    this.enclosure
  });

  final String mainTitle;
  final int episodes;
  final String title;
  final String pubDate;
  final String link;
  final AfrocastFeedItunes itunes;
  final String description;
  final AfrocastFeedEnclosure enclosure;


  factory AfrocastFeed.fromJSON(Map<String, dynamic> json) => new AfrocastFeed(
    mainTitle: json['mainTitle'],
    episodes: json['episodes'],
    title: json['title'],
    pubDate: json['pubDate'],
    link: json['link'],
    itunes: AfrocastFeedItunes.fromJSON(json['itunes']),
    description: json['description'],
    enclosure: AfrocastFeedEnclosure.fromJSON(json['enclosure'])
  );
}