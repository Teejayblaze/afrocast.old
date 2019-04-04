import 'dart:convert';

import 'package:afrocast/network/afrocast_network.dart';
import 'package:xml2json/xml2json.dart';
import 'package:afrocast/models/afrocast_feed.dart';
import 'package:flutter/material.dart';
import 'package:afrocast/providers/afrocast_bloc_provider.dart';
import 'package:afrocast/utils/afrocast_podcast_types.dart';

class AfrocastFeedRepository {
  AfrocastNetwork network;
  Xml2Json xml2json;
  final List<AfrocastFeed> feeds = new List<AfrocastFeed>();
  Map<String, dynamic> singleFeed;
  AfrocastBlocProvider provider;


  AfrocastFeedRepository({this.provider}) {
    this.network = new AfrocastNetwork();
    this.xml2json = new Xml2Json();
  }


  getRSSFeeds({PodcastType type}) async {

    var response = await this.network.getNetworkFeeds();

    if (response.statusCode == 200) {

      xml2json.parse(response.body);

      String jsonStr = xml2json.toBadgerfish();

      var jsonObj = json.decode(jsonStr);

      var mainTitle = jsonObj['rss']['channel']['title']['\$'];

      var item = jsonObj['rss']['channel']['item'];

      int itemLen = item.length;

      if (PodcastType.Single == type) {
        this.singleFeed = this._parseRSSFeed(mainTitle: mainTitle, itemLen: itemLen, rssFeed: item[0]);
        this.provider.afrocastBloc.singleInputStreamFeed.add([AfrocastFeed.fromJSON(this.singleFeed)]);
      }
      else if (PodcastType.All == type) {
        for(int i = 0; i < itemLen; i++) {
          this.singleFeed = this._parseRSSFeed(mainTitle: mainTitle, itemLen: itemLen, rssFeed: item[i]);
          this.feeds.add(AfrocastFeed.fromJSON(this.singleFeed));
          this.provider.afrocastBloc.inputStreamFeed.add(this.feeds);
        }
      }
    }
  }


  Map<String, dynamic> _parseRSSFeed({@required mainTitle, @required itemLen, @required rssFeed}) {
    String pubDate = rssFeed['pubDate']['\$'].toString();
    return {
      'mainTitle': mainTitle,
      'episodes': itemLen,
      'title': rssFeed['title']['\$'].toString().replaceAll(new RegExp(r'\\'), ''),
      'pubDate': pubDate.substring(0,(pubDate.indexOf(':')-2)),
      'link': rssFeed['link']['\$'],
      'itunes': {
        'duration': rssFeed['itunes:duration']['\$'],
        'author': rssFeed['itunes:author']['\$'],
        'explicit': rssFeed['itunes:explicit']['\$'],
        'summary': rssFeed['itunes:summary']['\$'],
        'subtitle': rssFeed['itunes:subtitle']['\$'],
        'image': rssFeed['itunes:image']['@href']
      },
      'description': rssFeed['description']['\$'].toString().replaceAll(new RegExp(r'\\'), ''),
      'enclosure': {
        'type': rssFeed['enclosure']['@type'],
        'url': rssFeed['enclosure']['@url'],
        'length': int.parse(rssFeed['enclosure']['@length']),
      }
    };
  }

}