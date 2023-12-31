import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/user.dart';

late SharedPreferences prefs;
Uri urlToDb = Uri.parse('https://script.google.com/macros/s/AKfycbxC9XgKgEi-hlv59HZxmdXO1VwK2054wauOFuQMSi7wYylewjjenFxJ9gCdM_8TPHAG/exec');
late int score;

// List<Map> THEMS = <Map>[
//   // текста                задний фон                кнопка                         тень       название     хз что    платность
//   [CupertinoColors.white, CupertinoColors.link, CupertinoColors.destructiveRed, Colors.purple, "Cobalt", Colors.black, false, false, "", 0], // 0
//   [CupertinoColors.black, CupertinoColors.systemOrange, Colors.deepPurple, Colors.indigo, "Kari", Colors.black, false, false, "", 0], // 1
//   [CupertinoColors.white, CupertinoColors.systemPurple, Colors.greenAccent, Colors.white10, "Stas", Colors.white, false, false, "", 0], // 2
//   [CupertinoColors.white, Colors.brown, CupertinoColors.activeGreen, Colors.green, "Forest", Colors.black, false, false, "", 50], // 3
//   [CupertinoColors.white, Colors.pinkAccent, Colors.lightBlueAccent, Colors.green, "Barbie", Colors.black, false, false, "", 50], // 4
//   [CupertinoColors.black, CupertinoColors.white, CupertinoColors.black, Colors.black12, "Minimalism", Colors.black, false, false, "", 50], // 5

//   [CupertinoColors.white, CupertinoColors.black, CupertinoColors.white, Colors.white10, "Monochrome", Colors.white, false, false, "", 50], // 6
//   [CupertinoColors.white, Colors.redAccent, Colors.blue, Colors.lightBlueAccent, "Monochrome", Colors.white, false, false, "", 50], // 7
// ];


String? selectedThem = "Cobalt";
Map thems = {
  "Cobalt": {"text": CupertinoColors.white, "bg": CupertinoColors.link,         "btn": CupertinoColors.destructiveRed, 'add': Colors.black},
  "Kari":   {"text": CupertinoColors.black, "bg": CupertinoColors.systemOrange, "btn": Colors.deepPurple,              "add": Colors.black},
  "Stas": {"text": CupertinoColors.white, "bg": CupertinoColors.systemPurple, "btn": Colors.greenAccent, "add": Colors.white},
  "Forest": {"text": CupertinoColors.white, "bg": Colors.brown, "btn": CupertinoColors.activeGreen, "add": Colors.black},
  "Barbie": {"text": CupertinoColors.white, "bg": Colors.pinkAccent, "btn": Colors.lightBlueAccent, "add": Colors.black},
  "Minimalism": {"text": CupertinoColors.black, "bg": CupertinoColors.white, "btn": CupertinoColors.black, "add": Colors.black},
  "Maximalism": {"text": CupertinoColors.white, "bg": CupertinoColors.black, "btn": CupertinoColors.white, "add": Colors.white},
  "Duck": {"text": CupertinoColors.white, "bg": Colors.redAccent, "btn": Colors.blue, "add": Colors.white},
  // "name": {"text": '', "bg": "", "btn": "", "add": ""},
  // "name": {"text": '', "bg": "", "btn": "", "add": ""},
  // "name": {"text": '', "bg": "", "btn": "", "add": ""},
};