class CustomUser {
  final String uid;

  final String houseName;

  CustomUser({this.uid, this.houseName});
}

class UserData {
  final String uid;

  final String userName;

  String hid;

  String houseName;

  UserData({this.uid, this.userName, this.hid = '',this.houseName = ''});
}
