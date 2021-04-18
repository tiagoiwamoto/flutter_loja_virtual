/*
    Author: Tiago Henrique Iwamoto
    email: tiago.iwamoto@gmail.com
    github: https://tiagoiwamoto.github.io
    linkedin: https://www.linkedin.com/in/tiago-iwamoto/
    Created at: 18/04/2021 - 15:29
*/

import 'package:cloud_firestore/cloud_firestore.dart';

class Product{

  String id;
  String name;
  String description;
  List<String> images;

  Product.fromDocument(DocumentSnapshot documentSnapshot){
    id = documentSnapshot.documentID;
    name = documentSnapshot['name'] as String;
    description = documentSnapshot['description'] as String;
    images = List<String>.from(documentSnapshot.data['images'] as List<dynamic>);
  }

  @override
  String toString() {
    return 'Product{description: $description, images: $images}';
  }

}