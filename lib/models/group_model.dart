class GroupModel {
  String? faculty_name;
  List? members;

  GroupModel({this.faculty_name, this.members});

  // data from server
  factory GroupModel.fromMap(map) {
    return GroupModel(
        faculty_name: map['faculty_name'], members: map['members']);
  }

  // sending data to server
  Map<String, dynamic> toMap() {
    return {'faculty_name': faculty_name, 'members': members};
  }
}
