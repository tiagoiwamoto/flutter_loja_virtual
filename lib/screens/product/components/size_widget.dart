/*
    Author: Tiago Henrique Iwamoto
    email: tiago.iwamoto@gmail.com
    github: https://tiagoiwamoto.github.io
    linkedin: https://www.linkedin.com/in/tiago-iwamoto/
    Created at: 19/04/2021 - 07:03
*/

import 'package:flutter/material.dart';
import 'package:loja_virtual/models/item_size.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:provider/provider.dart';

class SizeWidget extends StatelessWidget {

  final ItemSize itemSize;

  SizeWidget({this.itemSize});

  @override
  Widget build(BuildContext context) {

    final product = context.watch<Product>();
    final selected = itemSize == product.selectedSize;

    Color color;
    if(!itemSize.hasStock){
      color = Colors.red.withAlpha(50);
    }else if(selected){
      color = Theme.of(context).primaryColor;
    }else{
      color = Colors.grey;
    }

    return GestureDetector(
      onTap: (){
        if(itemSize.hasStock){
          product.selectedSize = itemSize;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: color
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                color: color,
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                itemSize.name,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'R\$ ${itemSize.price.toStringAsFixed(2)}',
                style: TextStyle(
                  color: color,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
