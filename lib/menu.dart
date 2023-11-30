import 'package:flutter/material.dart';
import 'global.dart' as global;
import 'package:flutter/services.dart';
import 'online.dart';
import 'themes.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: global.thems[global.selectedThem]['bg'],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: global.thems[global.selectedThem]['text'],
          size: 30,
        ),
        backgroundColor: global.thems[global.selectedThem]['bg'],
        title: Text(
          'Menu',
          style: TextStyle(
              fontSize: 50, color: global.thems[global.selectedThem]['text']),
        ),
      ),
      body: const Center(
        child: Column(children: [
          Online(),
          Spacer(),
          Thems(),
        ]),
      ),
    );
  }
}