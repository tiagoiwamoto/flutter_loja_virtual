/*
    Author: Tiago Henrique Iwamoto
    email: tiago.iwamoto@gmail.com
    github: https://tiagoiwamoto.github.io
    linkedin: https://www.linkedin.com/in/tiago-iwamoto/
    Created at: 19/04/2021 - 06:49
*/

class ItemSize {

  String name;
  num price;
  int stock;

  ItemSize({this.name, this.price, this.stock});

  ItemSize.fromMap(Map<String, dynamic> map){
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }

  bool get hasStock => stock > 0;

  @override
  String toString() {
    return 'ItemSize{name: $name, price: $price, stock: $stock}';
  }
}