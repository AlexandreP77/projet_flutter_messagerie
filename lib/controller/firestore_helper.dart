import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ipssi2023montevrain/model/music.dart';
import 'package:ipssi2023montevrain/model/utilisateur.dart';

class FirestoreHelper {
  //attributs
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final cloudUsers = FirebaseFirestore.instance.collection("UTILISATEURS");
  final cloudMusics = FirebaseFirestore.instance.collection("MUSIQUES");
  List <MyMusic>Musics = [
    MyMusic.build(title: "Best Mucis", artist: "moi", uid: "djwxfhdkjhkjdfsgfg", file: "https://firebasestorage.googleapis.com/v0/b/ipssi072023montevrain.appspot.com/o/MUSIQUES%2F21.%20I%20Wasn't%20Thinking.mp3?alt=media&token=ff6535c0-0e75-4e91-8920-164c44670f9f"),
    MyMusic.build(title: "Yes", artist: "moi", uid: "djfglfgjdflkgjdlsk", file: "https://firebasestorage.googleapis.com/v0/b/ipssi072023montevrain.appspot.com/o/MUSIQUES%2F23.%20Perhaps.mp3?alt=media&token=7c79d88b-1848-45b6-a0fc-d96a0047ef1f"),
    MyMusic.build(title: "Iphone", artist: "My name is", uid: "djwxfdgfdfdsgfhdkjhkjdfsgfg", file: "https://firebasestorage.googleapis.com/v0/b/ipssi072023montevrain.appspot.com/o/MUSIQUES%2F24.%20The%20Cost%20of%20Love.mp3?alt=media&token=4604946a-85ae-4466-8732-c15dc2434fc8"),
    MyMusic.build(title: "Lose Yourself", artist: "Eminem", uid: "djwxfhdddgfdfdgdkjhkjdfsgfg", file: "https://firebasestorage.googleapis.com/v0/b/ipssi072023montevrain.appspot.com/o/MUSIQUES%2F25.%20Death%20on%20the%20Nile.mp3?alt=media&token=8d6b6f9a-199c-4ae2-8e9a-4acb93f14d9f"),
  ];



  initMusic(){

    for(MyMusic music in Musics){
      Map<String,dynamic> map = {
        "TITLE": music.title,
        "ARTIST":music.artist,
        "FILE":music.file,
      };
      addMusic(music.uid, map);
    }

  }


  addMusic(String uid, Map<String,dynamic> data){
    cloudMusics.doc(uid).set(data);
}



  Future<MyUser>inscription(String email,String firstName, String  nickName,String lastName, String password) async{
    UserCredential credential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    String uid = credential.user?.uid ?? "";
    Map<String,dynamic> map = {
      "NOM":lastName,
      "PRENOM":firstName,
      "PSEUDO":nickName,
      "EMAIL":email,
      "FAVORIS":[]
    };

    addUser(uid,map);
    return getUser(uid);

  }

  updateUser(String uid , Map<String,dynamic> data){
    cloudUsers.doc(uid).update(data);

  }

  Future<MyUser>getUser(String uid) async {
    DocumentSnapshot documentSnapshot = await cloudUsers.doc(uid).get();
    return MyUser.dataBase(documentSnapshot);
  }


  Future<MyUser>connect(String email, String password) async{
    UserCredential credential = await auth.signInWithEmailAndPassword(email: email, password: password);
    String uid = credential.user?.uid ?? "";
    return getUser(uid);
  }

  addUser(String uid, Map<String,dynamic> data){
    cloudUsers.doc(uid).set(data);
  }

  Future<String>stockageFiles(String destination,String uidUser,String nameImage,Uint8List bytes) async {
    String url = "";
     TaskSnapshot snapshot = await storage.ref("$destination/$uidUser/$nameImage").putData(bytes);
     url = await snapshot.ref.getDownloadURL();
     return  url;
  }



  //méthode




}