import 'dart:io';
import 'dart:math';
import 'package:app_chat/store/models/message.dart';
import 'package:app_chat/store/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

abstract class AbstractRepository {
  Future<AppUser> infoUser(User user);
  Future<List> getListFriend(User user);
  Future<List<RecentMessage>> getRecentFriend(User user);
  Future getAvatar(String name);
  Future<File?> getImage();
  Future uploadChatImage(var image);
  Future uploadUserAva(image, AppUser user);
  Future sendMess(String message, String sender, String receiver, String type,
      Timestamp timeSend, bool seen);
}

class Repository implements AbstractRepository {
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
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

  @override
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

  @override
  Future<List<RecentMessage>> getRecentFriend(User user) async {
    List<RecentMessage> setList = [];
    var messSnapshot =
        await firebase.collection("messages").doc(user.email).get();

    for (var i in messSnapshot.data()!.keys) {
      var textList = messSnapshot.data()![i];
      if (textList.length != 0) {
        var lastMess = textList.last['body'];
        var typeMess = textList.last['type'];
        var seen = textList.last['seen'];
        var _timeSend = textList.last['timeSend'].toDate();
        if (DateFormat.yMd().format((_timeSend)) ==
            DateFormat.yMd().format(Timestamp.now().toDate())) {
          _timeSend = DateFormat.Hm().format(_timeSend).toString();
        } else {
          _timeSend = DateFormat.yMd().format(_timeSend).toString();
        }
        var ava;
        await getAvatar(i.replaceAll('_', '.').toString())
            .then((value) => ava = value);
        var recentMess = new RecentMessage((b) => b
          ..body = lastMess
          ..type = typeMess
          ..time = _timeSend
          ..sender = i.replaceAll('_', '.')
          ..image = ava
          ..seen = seen
          ..realTime = textList.last['timeSend']);
        setList.add(recentMess);
      }
    }
    setList.sort((a, b) {
      return b.time.compareTo(a.time);
    });
    return setList;
  }

  @override
  Future getAvatar(String name) async {
    var snapshot = await firebase.collection("users").doc(name).get();
    if (snapshot.data() != null) {
      return snapshot.data()!['image'];
    }
  }

  @override
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

  @override
  Future uploadChatImage(var image) async {
    Reference firebaseRef = FirebaseStorage.instance
        .ref('chatImage')
        .child(Random().nextInt(100000).toString());
    await firebaseRef.putFile(image!);

    var url = await firebaseRef.getDownloadURL();
    return url;
  }

  @override
  Future uploadUserAva(image, AppUser user) async {
    Reference firebaseRef =
        FirebaseStorage.instance.ref('profileImage').child(user.email);
    await firebaseRef.putFile(image!);
    var url = await firebaseRef.getDownloadURL();
    await firebase.collection('users').doc(user.email).update({'image': url});
    Fluttertoast.showToast(msg: 'Profile picture uploaded');
    return url;
  }

  @override
  Future sendMess(String message, String sender, String receiver, String type,
      Timestamp timeSend, bool seen) async {
    if (message.length > 0) {
      var map = new Map<String, dynamic>();
      map['body'] = message;
      map['from'] = sender;
      map['to'] = receiver;
      map['type'] = type;
      map['timeSend'] = timeSend.toDate();
      map['seen'] = seen;

      var receiver2 = receiver.replaceAll('.', '_');
      var sender2 = sender.replaceAll('.', '_');
      await firebase.collection('messages').doc(sender).set({
        receiver2: FieldValue.arrayUnion([map]),
      }, SetOptions(merge: true));

      map['seen'] = !seen;

      await firebase.collection('messages').doc(receiver).set({
        sender2: FieldValue.arrayUnion([map]),
      }, SetOptions(merge: true));
    }
  }
}

// scrollController.animateTo(
//         scrollController.position.maxScrollExtent,
//         curve: Curves.easeOut,
//         duration: const Duration(milliseconds: 300),
//       );