import 'package:flutter/material.dart';
import 'package:afrocast/models/afrocast_feed.dart';
import 'package:afrocast/providers/afrocast_bloc_provider.dart';
import 'package:afrocast/network/afrocast_feed_repo.dart';
import 'package:afrocast/utils/afrocast_podcast_types.dart';
import 'package:afrocast/screens/afrocast_feed_detail.dart';

class AfrocastHomeBody extends StatefulWidget {
  @override
  _AfrocastHomeBodyState createState() => _AfrocastHomeBodyState();
}

class _AfrocastHomeBodyState extends State<AfrocastHomeBody> {

  AfrocastBlocProvider provider;
  AfrocastFeedRepository repository;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.provider = AfrocastBlocProvider.of(context);
    this.repository = new AfrocastFeedRepository(provider: this.provider);

//    We approach the server once and cache the data received from the server so as to optimise
//    the application performance and limit resource usage e.g (Memory, Battery life, data) etc.
    this.repository.getRSSFeeds(type: PodcastType.Single);
    this.repository.getRSSFeeds(type: PodcastType.All);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AfrocastFeed>>(
      stream: this.provider.afrocastBloc.singleOutputStreamFeed,
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
          if ( snapshot.hasData ) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) => _buildContentBody(snapshot.data[index]),
            );
          }

          return Center(child: CircularProgressIndicator(),);
      },
    );
  }


  _buildContentBody(AfrocastFeed rssFeed) => Material(
    elevation: 20.0,
    child: GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => AfrocastFeedDetail(rssFeed: rssFeed,))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 300.0,
            child: Image.network(rssFeed.itunes.image, fit: BoxFit.cover,),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(rssFeed.mainTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                      FlatButton(onPressed: (){}, child: Text("MORE INFO", style: TextStyle(fontWeight: FontWeight.bold),))
                    ],
                  ),
                ),
                Padding( child: Text(rssFeed.title, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),), padding: EdgeInsets.symmetric(vertical: 5.0),),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Airdate: ${rssFeed.pubDate}",),
                      rssFeed.episodes > 1 ? Text("(${rssFeed.episodes} episodes)",) : Text("(${rssFeed.episodes} episode)",),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ) ,
  );


  @override
  void dispose() {
//    this.provider.afrocastBloc.dispose();
    super.dispose();
  }
}
