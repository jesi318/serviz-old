class User {
  String? uid;
  String? email;
  String? name;
  String? reg_no;
  String? classname;

  User({this.uid, this.email, this.name, this.reg_no, this.classname});

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'name': name,
        'reg_no': reg_no,
        'classname': classname
      };

  static User fromJson(Map<String, dynamic> json) => User(
        email: json['email'],
        classname: json['classname'],
        name: json['name'],
        reg_no: json['reg_no'],
        uid: json['uid'],
      );
}
