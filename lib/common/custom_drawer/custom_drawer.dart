/*
    Author: Tiago Henrique Iwamoto
    email: tiago.iwamoto@gmail.com
    github: https://tiagoiwamoto.github.io
    linkedin: https://www.linkedin.com/in/tiago-iwamoto/
    Created at: 17/04/2021 - 10:07
*/

import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerTile(iconData: Icons.home, title: 'Início', page: 0),
          DrawerTile(iconData: Icons.list, title: 'Produtos', page: 1),
          DrawerTile(iconData: Icons.playlist_add_check, title: 'Meus Pedidos', page: 2),
          DrawerTile(iconData: Icons.location_on, title: 'Lojas', page: 3)
        ],
      ),
    );
  }
}