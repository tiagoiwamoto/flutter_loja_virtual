import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/screens/base/base_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
  // Firestore.instance
  //     .document('pedidos/#0001')
  //     .updateData({'usuario': 'Tiago Iwamoto'});
  // Firestore.instance.collection("pedidos").document("#0001").snapshots().listen((document) {
  //   print(document.data);
  // QuerySnapshot querySnapshot = await Firestore.instance.collection('pedidos').getDocuments();
  // querySnapshot.documents.forEach((element) {
  //   print(element.data);
  // });
  // Firestore.instance.collection('pedidos').snapshots().listen((event) {
  //   event.documents.forEach((element) {
  //     print(element.data);
  //   });
  // });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => UserManager(),
      child: MaterialApp(
        title: 'Loja do Tiago',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: Color.fromARGB(255, 4, 125, 141),
          appBarTheme: AppBarTheme(
            elevation: 0
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BaseScreen(),
      ),
    );
  }
}
