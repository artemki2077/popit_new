import 'package:flutter/material.dart';
import 'global.dart' as global;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert';

import 'models/User.dart';


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
  late List<User> users;

  Future<bool?> registration(String name) async {
    print('start');
    http.Response response = await http.get(Uri.https(
      'script.google.com',
      '/macros/s/AKfycbxC9XgKgEi-hlv59HZxmdXO1VwK2054wauOFuQMSi7wYylewjjenFxJ9gCdM_8TPHAG/exec',
      {
        "type": "registration",
        'name': name,
        "score": global.score.toString(),
      }
    ));
    if (response.statusCode == 200) {
      String source = const Utf8Decoder().convert(response.bodyBytes);
      Map<String, dynamic> data = jsonDecode(source);
      setState(() {
        global.prefs.setInt('id', data['id']);
        global.prefs.setString('name', data['name']);

        state = 'table';
      });
      
    }else{
      String source = const Utf8Decoder().convert(response.bodyBytes);
      print(source);
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
      case 'table':
        return const Expanded(
          flex: 3, 
          child: Center(
            child: Text("data"),
          )
        );
      default:
        return Expanded(
          flex: 3,
          child: Center(
            child: CircularProgressIndicator(
              color: global.thems[global.selectedThem]['btn'],
            ),
          ),
        );
    }
  }
}