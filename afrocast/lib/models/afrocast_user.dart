
class AfrocastUser {
  AfrocastUser({this.userName, this.userEmail, this.userPics, this.isLoggedIn});

  final String userName;
  final String userEmail;
  final String userPics;
  final bool isLoggedIn;

  factory AfrocastUser.fromJSON(Map<String, dynamic> json) => new AfrocastUser(
    userName:  json['username'],
    userEmail:  json['user_email'],
    userPics:  json['user_pics'],
    isLoggedIn:  json['is_logged_in'],
  );
}