import 'package:flutter/material.dart';
import 'package:afrocast/blocs/afrocast_stream_feed.dart';
import 'package:afrocast/models/afrocast_feed.dart';
import 'package:afrocast/models/afrocast_user.dart';
import 'package:audioplayer/audioplayer.dart';

class AfrocastBlocProvider extends InheritedWidget {
  const AfrocastBlocProvider({
    Key key,
    @required Widget child,
    @required this.afrocastBloc,
    @required this.appTheme,
    @required this.user,
    @required this.audioPlayer,
  })
      : assert(child != null),
        super(key: key, child: child);

  final AfrocastStreamFeed<AfrocastFeed> afrocastBloc;
  final MaterialColor appTheme;
  final AfrocastUser user;
  final AudioPlayer audioPlayer;

  static AfrocastBlocProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(
        AfrocastBlocProvider) as AfrocastBlocProvider;
  }

  @override
  bool updateShouldNotify(AfrocastBlocProvider old) => true;
}