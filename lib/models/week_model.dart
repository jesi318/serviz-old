import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class WeekFetcher {
  final CollectionReference weekList = FirebaseFirestore.instance
      .collection('group')
      .doc('g1')
      .collection('week');

  // for submit weekly report (later)
  Future<void> CreateWeek() async {}

  Future fetchWeek() async {
    List itemList = [];
    try {
      await weekList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemList.add(element.data);
        });
      });
      return itemList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
