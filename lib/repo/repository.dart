import 'dart:io';
import 'dart:math';
import 'package:app_chat/store/models/message.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Repository {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  Future<BuiltList<RecentMessage>> getAllRecentMess(User user) async {
    var messSnapshot =
        await firebase.collection("messages").doc(user.email).get();
    var list = BuiltList<RecentMessage>([]);

    if (messSnapshot.data()!['text'] != []) {
      for (var i in messSnapshot.data()!['text']) {
        if (i['to'] != user.email) {
          var recentMess = i['to'];
          list = list.rebuild((p0) => p0.add(recentMess));
        } else if (i['from'] != user.email) {
          var recentMess = i['from'];
          list = list.rebuild((p0) => p0.add(recentMess));
        }
      }
    }
    list = list.rebuild((p0) => p0.reverse());
    return list;
  }

  Future<List> listFriend(User user) async {
    List list = [];
    final result = firebase.collection('messages');
    await result.get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        if (doc.id != user.email) {
          list.add(doc.id);
        }
      });
    });
    return list;
  }

  Future<List> listDoc(User user) async {
    List setList = [];
    var messSnapshot =
        await firebase.collection("messages").doc(user.email).get();
    if (messSnapshot.data()!['text'] != []) {
      for (var i in messSnapshot.data()!['text']) {
        if (i['to'] != user.email)
          setList.add(i['to']);
        else if (i['from'] != user.email) setList.add(i['from']);
      }
    }
    setList = List.from(setList.reversed).toSet().toList();
    return setList;
  }

  Future<File?> getImage() async {
    File? image;
    final ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        image = File(xFile.path);
      }
    });
    return image;
  }

  Future uploadChatImage(var image) async {
    Reference firebaseRef = FirebaseStorage.instance
        .ref('chatImage')
        .child(Random().nextInt(100000).toString());
    await firebaseRef.putFile(image!);

    var url = await firebaseRef.getDownloadURL();
    return url;
  }

  Future uploadUserAva(image, User user) async {
    Reference firebaseRef =
        FirebaseStorage.instance.ref('profileImage').child(user.email!);
    await firebaseRef.putFile(image!);
    var url = await firebaseRef.getDownloadURL();
    await firebase.collection('users').doc(user.email).update({'image': url});
    Fluttertoast.showToast(msg: 'Profile picture uploaded');
  }
}
