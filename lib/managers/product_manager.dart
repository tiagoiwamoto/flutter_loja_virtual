/*
    Author: Tiago Henrique Iwamoto
    email: tiago.iwamoto@gmail.com
    github: https://tiagoiwamoto.github.io
    linkedin: https://www.linkedin.com/in/tiago-iwamoto/
    Created at: 18/04/2021 - 15:17
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/product.dart';

class ProductManager extends ChangeNotifier{

  final Firestore firestore = Firestore.instance;
  List<Product> allProducts = [];

  String _search = '';

  String get search => _search;
  set search(String value){
    _search = value;
    notifyListeners();
  }

  ProductManager(){
    _loadAllProducts();
  }

  Future<void> _loadAllProducts() async{
    final QuerySnapshot snapProducts = await firestore.collection('products').getDocuments();
    allProducts = snapProducts.documents.map((document) => Product.fromDocument(document)).toList();
    notifyListeners();
  }

  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];
    if(search.isEmpty){
      filteredProducts.addAll(allProducts);
    }else{
      filteredProducts.addAll(allProducts.where((product) => product.name.toLowerCase().contains(search.toLowerCase())));
    }

    return filteredProducts;
  }

}