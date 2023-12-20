import 'package:flutter/material.dart';
import 'global.dart' as global;
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
              fontSize: 50, color: global.thems[global.selectedThem]['text'],
              fontWeight: FontWeight.w500
          ),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            Online(theme: global.thems[global.selectedThem],),
            // const Spacer(),
            Thems(stater: setState),
        ]),
      ),
    );
  }
}
