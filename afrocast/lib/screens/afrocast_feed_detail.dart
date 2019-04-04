import 'package:flutter/material.dart';
import 'package:afrocast/providers/afrocast_bloc_provider.dart';
import 'package:afrocast/models/afrocast_feed.dart';
import 'package:afrocast/screens/afrocast_feed_player.dart';

class AfrocastFeedDetail extends StatefulWidget {

  AfrocastFeedDetail({this.rssFeed});

  final AfrocastFeed rssFeed;

  @override
  _AfrocastFeedDetailState createState() => _AfrocastFeedDetailState();
}

class _AfrocastFeedDetailState extends State<AfrocastFeedDetail> {

  AfrocastBlocProvider provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = AfrocastBlocProvider.of(context);
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[

          SliverAppBar(
            elevation: 10.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Image.network(widget.rssFeed.itunes.image, fit: BoxFit.cover,),
              title: Text(widget.rssFeed.mainTitle,
                style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            expandedHeight: 320.0,
            pinned: true,
            floating: false,
          ),

          StreamBuilder<List<AfrocastFeed>>(
            stream: this.provider.afrocastBloc.outputStreamFeed,
            initialData: null,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) => Container(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) => AfrocastFeedPlayer(rssFeed: snapshot.data[index], currentIndex: index,),
                              )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Padding(
                                      child: Text("${index+1}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0),),
                                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                                    ),
                                    Expanded(
                                      child: Text(snapshot.data[index].title, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0)),
                                    ),
                                    IconButton(icon: Icon(Icons.more_vert), onPressed: (){})
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      childCount: snapshot.data.length,
                    ),
                );
              }
              return SliverList(
                delegate: SliverChildListDelegate([Center(child: CircularProgressIndicator(),)]),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
