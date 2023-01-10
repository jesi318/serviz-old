import 'package:firebase_auth/firebase_auth.dart';

class UserModelGid {
  String? grp_id;

  UserModelGid({this.grp_id});

  // data from server
  factory UserModelGid.fromMap(map) {
    return UserModelGid(grp_id: map['grp_id']);
  }

  // sending data to server
  Map<String, dynamic> toMap() {
    return {'grp_id': grp_id};
  }
}
