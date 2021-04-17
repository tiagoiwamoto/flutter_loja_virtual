/*
    Author: Tiago Henrique Iwamoto
    email: tiago.iwamoto@gmail.com
    github: https://tiagoiwamoto.github.io
    linkedin: https://www.linkedin.com/in/tiago-iwamoto/
    Created at: 17/04/2021 - 11:19
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/helpers/firebase_errors.dart';
import 'package:loja_virtual/models/user.dart';

class UserManager {

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signIn({User user, Function onFail, Function onSuccess}) async{
    try{
      final AuthResult result = await auth.signInWithEmailAndPassword(email: user.email, password: user.password);
      onSuccess();
    }on PlatformException catch(e){
      onFail(getErrorString(e.code));
    }


  }



}