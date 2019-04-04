import 'package:http/http.dart' as http;

class AfrocastNetwork {
  final String url = 'http://feeds.soundcloud.com/users/soundcloud:users:209573711/sounds.rss';


  Future getNetworkFeeds () async {
    http.Client client = http.Client();
    return await client.get(url);
  }
}