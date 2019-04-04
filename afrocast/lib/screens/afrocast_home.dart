import 'package:flutter/material.dart';
import 'package:afrocast/utils/afrocast_drawer.dart';
import 'package:afrocast/providers/afrocast_bloc_provider.dart';
import 'package:afrocast/utils/afrocast_homebody.dart';

class AfrocastHome extends StatefulWidget {
  @override
  _AfrocastHomeState createState() => _AfrocastHomeState();
}

class _AfrocastHomeState extends State<AfrocastHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AfrocastBlocProvider.of(context).appTheme[900],
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Afrocast"),
        actions: <Widget>[ IconButton(icon: Icon(Icons.more_vert), onPressed: (){}),],
      ),
      body: AfrocastHomeBody(),
      drawer: AfrocastDrawer(),
    );
  }
}
