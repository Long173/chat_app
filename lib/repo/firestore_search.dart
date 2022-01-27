import 'package:cloud_firestore/cloud_firestore.dart';

class DataModel {
  final String? name;
  final String? email;
  final String? image;

  DataModel({this.name, this.email, this.image});

  List<DataModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;
      return DataModel(
        name: dataMap['name'],
        email: dataMap['email'],
        image: dataMap['image'],
      );
    }).toList();
  }
}
