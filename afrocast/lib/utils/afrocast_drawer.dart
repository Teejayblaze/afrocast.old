import 'package:flutter/material.dart';
import 'package:afrocast/providers/afrocast_bloc_provider.dart';
import 'package:afrocast/utils/afrocast_custom_clipper.dart';
import 'package:afrocast/models/afrocast_user.dart';

class AfrocastDrawer extends StatelessWidget {

  List<Map<String, dynamic>> menuList = new List<Map<String, dynamic>>();

  @override
  Widget build(BuildContext context) {
    AfrocastBlocProvider appContext = AfrocastBlocProvider.of(context);
    this.menuList = this._populateMenu();

    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          this._buildUserAccountProfileHeader(appContext.appTheme, appContext.user),
          this._buildDrawerBody()
        ]
      ),
    );
  }

  Expanded _buildUserAccountProfileHeader(MaterialColor appTheme, AfrocastUser user) => Expanded(
    flex: 1,
    child: ClipPath(
      clipper: AfrocastCustomClipper(),
      child: Container(
        color: appTheme[100],
        padding: EdgeInsets.only(top: 50.0, left: 30.0),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.transparent,
                backgroundImage: user.userPics != null ? NetworkImage(user.userPics) : AssetImage('images/account_user2.jpg'),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(user.userName, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(user.userEmail),
            ),
          ],
        ),
      ),
    ),
  );

  Expanded _buildDrawerBody() => Expanded(
    flex: 2,
    child: ListView.builder(
      padding: EdgeInsets.only(top: 1.0),
      physics: BouncingScrollPhysics(),
      itemCount: this.menuList.length,
      itemBuilder: (BuildContext context, int index) {

        if (index == 3) { // we want to create our divider on the sidemenu.
          return Padding(
            padding: EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child:Text(this.menuList[index]['title']),
                ),
              ],
            ),
          );
        }

        return ListTile(
          leading: Icon(this.menuList[index]['icon']),
          title: Text(this.menuList[index]['title']),
        );
      }
    )
  );


  List<Map<String, dynamic>> _populateMenu() {

    List<Map<String, dynamic>> menus = [
      {'title': 'Featured Podcasts', 'icon': Icons.home},
      {'title': 'All Podcasts', 'icon': Icons.mic},
      {'title': 'About', 'icon': Icons.settings},
      {'title': 'Communicate'},
      {'title': 'Share', 'icon': Icons.share},
      {'title': 'Feedback', 'icon': Icons.message},
    ];
    return menus;
  }
}
