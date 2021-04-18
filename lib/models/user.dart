/*
    Author: Tiago Henrique Iwamoto
    email: tiago.iwamoto@gmail.com
    github: https://tiagoiwamoto.github.io
    linkedin: https://www.linkedin.com/in/tiago-iwamoto/
    Created at: 17/04/2021 - 11:20
*/

import 'package:cloud_firestore/cloud_firestore.dart';

class User{

  String id;
  String name;
  String email;
  String password;
  String confirmPassword;

  DocumentReference get firestoreRef => Firestore.instance.document('users/$id');

  User({this.email, this.password, this.name, this.id});

  User.fromDocument(DocumentSnapshot documentSnapshot){
    id = documentSnapshot.data['id'] as String;
    name = documentSnapshot.data['name'] as String;
    email = documentSnapshot.data['email'] as String;
  }

  Map<String, dynamic> toMap(){
    return {
      'name': this.name,
      'email': this.email
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, password: $password, confirmPassword: $confirmPassword}';
  }
}