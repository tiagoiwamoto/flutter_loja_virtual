/*
    Author: Tiago Henrique Iwamoto
    email: tiago.iwamoto@gmail.com
    github: https://tiagoiwamoto.github.io
    linkedin: https://www.linkedin.com/in/tiago-iwamoto/
    Created at: 18/04/2021 - 15:29
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/item_size.dart';

class Product extends ChangeNotifier{

  String id;
  String name;
  String description;
  List<String> images;
  List<ItemSize> sizes;
  ItemSize _selectedSize;

  Product.fromDocument(DocumentSnapshot documentSnapshot){
    id = documentSnapshot.documentID;
    name = documentSnapshot['name'] as String;
    description = documentSnapshot['description'] as String;
    images = List<String>.from(documentSnapshot.data['images'] as List<dynamic>);
    sizes = (documentSnapshot.data['sizes'] as List<dynamic> ?? []).map((itemSize) => ItemSize.fromMap(itemSize)).toList();
  }

  ItemSize get selectedSize => _selectedSize;
  set selectedSize(ItemSize itemSize){
    this._selectedSize = itemSize;
    notifyListeners();
  }

  @override
  String toString() {
    return 'Product{description: $description, images: $images}';
  }
  

}