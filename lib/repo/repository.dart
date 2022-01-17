import 'dart:io';
import 'dart:math';
import 'package:app_chat/store/models/message.dart';
import 'package:app_chat/store/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Repository {
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<AppUser> infoUser(User user) async {
    final result = await firebase.collection('users').doc(user.email).get();
    final data = result.data();
    var appUser = new AppUser((b) => b
      ..dateCreate = data!['dateCreate']
      ..email = data['email']
      ..image = data['image']
      ..name = data['name']);

    return appUser;
  }

  Future<List> getListFriend(User user) async {
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

  Future<List> getRecentFriend(User user) async {
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

  Future getAvatar(var name) async {
    var snapshot = await firebase.collection("users").doc(name).get();
    if (snapshot.data() != null) {
      return snapshot.data()!['image'];
    }
  }

  Future<List<RecentMessage>> getRecentMess(User user, List list) async {
    List<RecentMessage> list1 = [];
    for (var i in list) {
      var messSnapshot =
          await firebase.collection("messages").doc(i.toString()).get();
      var textList = messSnapshot.data()!['text'];
      if (textList != []) {
        for (var j = textList.length - 1; j >= 0; j--) {
          if ((textList[j]['from'] == user.email ||
                  textList[j]['from'] == i.toString()) &
              (textList[j]['to'] == user.email ||
                  textList[j]['to'] == i.toString())) {
            var lastMess = textList[j]['body'];
            var typeMess = textList[j]['type'];
            var _timeSend = textList[j]['timeSend'].toDate();
            if (DateFormat.yMd().format((_timeSend)) ==
                DateFormat.yMd().format(Timestamp.now().toDate())) {
              _timeSend = DateFormat.Hm().format(_timeSend).toString();
            } else {
              _timeSend = DateFormat.yMd().format(_timeSend).toString();
            }
            var ava;
            await getAvatar(i.toString()).then((value) => ava = value);
            var recentMess = new RecentMessage((b) => b
              ..body = lastMess
              ..type = typeMess
              ..time = _timeSend
              ..sender = i
              ..image = ava);
            list1.add(recentMess);
            break;
          }
        }
      }
    }
    return list1;
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

  Future uploadUserAva(image, AppUser user) async {
    Reference firebaseRef =
        FirebaseStorage.instance.ref('profileImage').child(user.email);
    await firebaseRef.putFile(image!);
    var url = await firebaseRef.getDownloadURL();
    await firebase.collection('users').doc(user.email).update({'image': url});
    Fluttertoast.showToast(msg: 'Profile picture uploaded');
    AppUser.update(
        newImage: url,
        newName: user.name,
        newDateCreate: user.dateCreate,
        newEmail: user.email);
  }

  Future sendMess(String message, String sender, String receiver, String type,
      Timestamp timeSend, ScrollController scrollController) async {
    if (message.length > 0) {
      var map = new Map<String, dynamic>();
      map['body'] = message;
      map['from'] = sender;
      map['to'] = receiver;
      map['type'] = type;
      map['timeSend'] = timeSend.toDate();

      await firebase.collection('messages').doc(sender).set({
        'text': FieldValue.arrayUnion([map]),
      }, SetOptions(merge: true));

      await firebase.collection('messages').doc(receiver).set({
        'text': FieldValue.arrayUnion([map]),
      }, SetOptions(merge: true));

      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }
}
