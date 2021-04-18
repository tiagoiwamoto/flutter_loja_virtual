/*
    Author: Tiago Henrique Iwamoto
    email: tiago.iwamoto@gmail.com
    github: https://tiagoiwamoto.github.io
    linkedin: https://www.linkedin.com/in/tiago-iwamoto/
    Created at: 17/04/2021 - 11:19
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/helpers/firebase_errors.dart';
import 'package:loja_virtual/models/user.dart';

class UserManager extends ChangeNotifier{

  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;
  User user;
  bool _loading = false;

  UserManager(){
    _loadCurrentUser();
  }

  bool get isLoggedIn => user != null;

  Future<void> signIn({User user, Function onFail, Function onSuccess}) async{
    loading = true;
    Future.delayed(Duration(seconds: 4));
    try{
      final AuthResult result = await auth.signInWithEmailAndPassword(email: user.email, password: user.password);

      await _loadCurrentUser(firebaseUser: result.user);

      onSuccess();
    }on PlatformException catch(e){
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({FirebaseUser firebaseUser}) async {
    FirebaseUser currentUser = firebaseUser ?? await auth.currentUser();
    if(currentUser != null){
      final DocumentSnapshot documentSnapshot = await firestore.collection('users').document(currentUser.uid).get();
      this.user = User.fromDocument(documentSnapshot);
      print(this.user.toString());
      notifyListeners();
    }
  }
  
  Future<void> signUp({User user, Function onFail, Function onSuccess}) async {
    loading = true;
    try{
      final AuthResult result = await auth.createUserWithEmailAndPassword(email: user.email, password: user.password);
      user.id = result.user.uid;
      this.user = user;
      await this.saveUser(user: user);
      onSuccess();
    }on PlatformException catch(e){
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> saveUser({User user}) async {
    user.firestoreRef.setData(user.toMap());
  }

  void signOut(){
    auth.signOut();
    user = null;
    notifyListeners();
  }
}