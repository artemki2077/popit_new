import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'global.dart' as global;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert';

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
          Thems(),
        ]),
      ),
    );
  }
}

class Them extends StatefulWidget {
  final name;
  final index;
  const Them({super.key, required this.name, required this.index});

  @override
  State<Them> createState() => _ThemState();
}

class _ThemState extends State<Them> {
  @override
  Widget build(BuildContext context) {
    String name = widget.name;
    int index = widget.index;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100))),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    global.selectedThem = name;
                    setState(() {
                      global.prefs
                          .setString("selectedThem", global.selectedThem!);
                    });
                  },
                  child: Container(
                      width: 150,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: global.thems[name]['bg'],
                          border: Border.all(color: Colors.black)),
                      child: Column(children: [
                        Container(
                          height: 30,
                        ),
                        Text(
                          "${index + 1}",
                          style: TextStyle(
                              fontSize: 40, color: global.thems[name]['text']),
                        ),
                        Container(
                          height: 20,
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: global.thems[name]['btn'],
                            shape: BoxShape.circle,
                          ),
                        )
                      ])))),
          Text(
            name,
            style: TextStyle(
              color: global.thems[name]['text'],
            ),
          ),
        ],
      ),
    );
  }
}

class Thems extends StatefulWidget {
  const Thems({super.key});

  @override
  State<Thems> createState() => _ThemsState();
}

class _ThemsState extends State<Thems> {
  List<Widget> generateThems() {
    List<Widget> res = <Widget>[];
    int i = 0;
    global.thems.forEach((key, value) {
      res.add(Them(
        name: key,
        index: i,
      ));
    });
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: generateThems(),
        ),
      ),
    );
  }
}

class Online extends StatefulWidget {
  const Online({super.key});

  @override
  State<Online> createState() => _OnlineState();
}

class _OnlineState extends State<Online> {
  final formKey = GlobalKey<FormState>();
  String? state = '';
  bool? isValidForm;
  late String name;

  Future<bool?> registration(String name) async {
    print('start');
    http.Response response = await http.post(Uri.parse('https://script.google.com/macros/s/AKfycbxC9XgKgEi-hlv59HZxmdXO1VwK2054wauOFuQMSi7wYylewjjenFxJ9gCdM_8TPHAG/exec?type=reg&name=${name}&score=${global.score}'));
    if (response.statusCode == 302 || response.statusCode == 200) {
      String source = const Utf8Decoder().convert(response.bodyBytes);
      final data = jsonDecode(source);
      print(data);
    }else{
      print('status code');
      print(response.statusCode);
    }
    return null;
  }

  @override
  void initState() {

    if (global.prefs.getString('name') == null || global.prefs.getInt('id') == null) {
      state = 'reg';
    } else {
      state = 'table';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case 'reg':
        return Expanded(
          flex: 5,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    autocorrect: false,
                    style: TextStyle(
                        color: global.thems[global.selectedThem]['text']
                    ),
                    onChanged: (val){
                      name = val;
                    },
                    validator: (val) => val!.isEmpty || val.length > 10  ? "ник должно быть короче 10 символов" : null,
                    decoration: InputDecoration(
                      fillColor: global.thems[global.selectedThem]['add']
                          .withOpacity(0.2),
                      filled: true,
                      hintText: "имя",
                      hintStyle: TextStyle(
                          color: global.thems[global.selectedThem]['bg']),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20.0)),
                      prefixIcon: Icon(
                        Icons.person,
                        color: global.thems[global.selectedThem]['bg'],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: FloatingActionButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        if(formKey.currentState!.validate()){
                          registration(name);
                        }

                      },
                      elevation: 0,
                      backgroundColor: global.thems[global.selectedThem]['add'].withOpacity(0.2),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: global.thems[global.selectedThem]['text'],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      default:
        return Expanded(
          child: Center(
            child: CircularProgressIndicator(
              color: global.thems[global.selectedThem]['btn'],
            ),
          ),
        );
    }
    ;
  }
}
