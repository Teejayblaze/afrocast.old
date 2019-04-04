import 'package:flutter/material.dart';
import 'package:afrocast/providers/afrocast_bloc_provider.dart';
import 'package:afrocast/models/afrocast_feed.dart';
import 'package:audioplayer/audioplayer.dart';


enum AudioPlayerMode {
  isPlaying,
  isPaused,
  isStopped
}

class AfrocastFeedPlayer extends StatefulWidget {

  AfrocastFeedPlayer({this.rssFeed, this.currentIndex});

  final AfrocastFeed rssFeed;
  int currentIndex;

  @override
  _AfrocastFeedPlayerState createState() => _AfrocastFeedPlayerState();
}

class _AfrocastFeedPlayerState extends State<AfrocastFeedPlayer> {

  AfrocastBlocProvider provider;
  AudioPlayer _audioPlayer;
  double _pValue = 0.0;
  String _pDuration = "00:00";
  AudioPlayerMode playerMode = AudioPlayerMode.isPlaying;
  int playerCurrIndex = 0;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    this.provider = AfrocastBlocProvider.of(context);

    print("widget.rssFeed.enclosure.url = ${widget.rssFeed.enclosure.url}");

    this._audioPlayer = this.provider.audioPlayer;
    await this._audioPlayer.stop();
    await this._audioPlayer.play(widget.rssFeed.enclosure.url, isLocal: false);

    setState(() {
      playerMode = AudioPlayerMode.isPlaying;
    });

    this._audioPlayer.onPlayerStateChanged.listen((pState) {
        if (pState == AudioPlayerState.PLAYING) {
          setState(() {
            _pDuration =  '${this._audioPlayer.duration.inMinutes}:${this._audioPlayer.duration.inSeconds.ceil()}';
          });
        } else if (pState == AudioPlayerState.STOPPED) {

        }
    }, onError: (err){
        setState(() {
          playerMode = AudioPlayerMode.isStopped;
          _pDuration = "00:00";
          _pValue = 0.0;
        });
    });

    this.playerCurrIndex = widget.currentIndex;
  }
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: this.provider.appTheme[900],
      ),
      body: this._buildPlayerBody(size),
    );
  }


  Column _buildPlayerBody(Size size) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        height: (size.height - (size.height/2)),
        width: size.width,
        child: Image.network(widget.rssFeed.itunes.image, fit: BoxFit.cover,),
      ),
      Container(
        padding: EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(widget.rssFeed.title),
            Container(
              margin: EdgeInsets.only(top: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: Slider(
                      value: this._pValue,
                      onChanged: this._onChanged,
                      activeColor: this.provider.appTheme[100],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("00:00"),
                        Text(this._pDuration),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.skip_previous), onPressed: (){},),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200.0),
                            color: this.provider.appTheme[100],
                          ),
                          child: IconButton(
                            icon: playerMode == AudioPlayerMode.isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                            onPressed: this._playPause,
                          ),
                        ),

                        IconButton(icon: Icon(Icons.skip_next), onPressed: this._nextAudio),
                      ],
                    ),
                  )
                ],
              )
            )
          ],
        ),
      )
    ],
  );


  void _onChanged(double value) => setState((){this._pValue = value;});

  Future<void> _playPause() async {
    if (playerMode == AudioPlayerMode.isPlaying) {
      await this._audioPlayer.pause();
      setState(() {
        playerMode = AudioPlayerMode.isPaused;
      });
    } else if (playerMode == AudioPlayerMode.isPaused) {
      await this._audioPlayer.play(widget.rssFeed.enclosure.url, isLocal: false);
      setState(() {
        playerMode = AudioPlayerMode.isPlaying;
      });
    }
  }
  
  Future<void> _nextAudio() async {
    this.playerCurrIndex += 1;
    AfrocastFeed nextFeed = null;

    print("this.playerCurrIndex =  ${this.playerCurrIndex}");

    // TODO Would have to implement this. though i had limited deliverable time.

//    this.provider.afrocastBloc.outputStreamFeed.listen((streams){
//      if ((streams.length-1) == this.playerCurrIndex) this.playerCurrIndex = (streams.length-1);
////      nextFeed = streams[this.playerCurrIndex];
//      print('this.playerCurrIndex = ${this.playerCurrIndex}, nextFeed = ${nextFeed} , streams = $streams');
//    });

//    this._audioPlayer.stop();
//    this._audioPlayer.play(nextFeed.enclosure.url, isLocal: false);
  }
}
