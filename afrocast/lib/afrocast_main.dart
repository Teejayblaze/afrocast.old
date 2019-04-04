import 'package:flutter/material.dart';
import 'package:afrocast/screens/afrocast_home.dart';
import 'package:afrocast/providers/afrocast_bloc_provider.dart';
import 'package:afrocast/blocs/afrocast_stream_feed.dart';
import 'package:afrocast/models/afrocast_feed.dart';
import 'package:afrocast/themes/afrocast_theme.dart';
import 'package:afrocast/models/afrocast_user.dart';
import 'package:audioplayer/audioplayer.dart';


class AfrocastMain extends StatelessWidget {

  AudioPlayer audioPlayer;
  AfrocastUser defaultUser;
  AfrocastStreamFeed<AfrocastFeed> afrocastFeedBloc;

  @override
  Widget build(BuildContext context) {

    afrocastFeedBloc = new AfrocastStreamFeed<AfrocastFeed>();

    defaultUser = new AfrocastUser(
      userName: 'Afrocast App',
      userEmail: 'anonymous@afrocastapp.com',
      userPics: null,
      isLoggedIn: false
    );

    this.audioPlayer = new AudioPlayer();

    return AfrocastBlocProvider(
      afrocastBloc: this.afrocastFeedBloc,
      appTheme: appTheme,
      user: this.defaultUser,
      audioPlayer: this.audioPlayer,
      child: MaterialApp(
        theme: ThemeData(primarySwatch: appTheme, accentColor: Colors.white),
        home: AfrocastHome(),
        debugShowCheckedModeBanner: false,
      )
    );
  }
}
