import 'package:flutter/material.dart';
import 'global.dart' as global;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert';

import 'models/user.dart';


class Online extends StatefulWidget {
  final Map theme;
  const Online({super.key, required this.theme});

  @override
  State<Online> createState() => _OnlineState();
}

class _OnlineState extends State<Online> {
  final formKey = GlobalKey<FormState>();
  String? state = '';
  bool? isValidForm;
  late String name;
  int? userPlace;
  List<User>? users;

  List leaderTextStyles = const [
   TextStyle(color: Colors.yellow, fontWeight: FontWeight.w600),
   TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
   TextStyle(color: Colors.amber, fontWeight: FontWeight.w600),
  ];

  Future<void> registration(String name) async {
    try{
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
      });
      await getAll();
      
    }else{
      // String source = const Utf8Decoder().convert(response.bodyBytes);
      setState(() {
        state = 'no_internet';
      });
    }
    }catch(e){
      print('req: $e');
      setState(() {
        state = 'no_internet';
      });
    }
    
  }

  Future<void> getAll() async{
      http.Response response = await http.get(Uri.https(
      'script.google.com',
      '/macros/s/AKfycbxC9XgKgEi-hlv59HZxmdXO1VwK2054wauOFuQMSi7wYylewjjenFxJ9gCdM_8TPHAG/exec',
      {
        "type": "get",
      }
    ));

    if (response.statusCode == 200) {
      String source = const Utf8Decoder().convert(response.bodyBytes);
      List data = jsonDecode(source);
      print(data);
      users = data.map((e)=>User.fromJson(e)).toList();
      users!.sort((a, b)=>b.score.compareTo(a.score));
      
      userPlace = users!.indexOf(User(id: global.prefs.getInt('id')!, name: global.prefs.getString('name')!, score: global.prefs.getInt('score')!)) + 1;   
      setState(() {
        state = 'table';
      });
      
    }else{
      setState(() {
        state = 'no_internet';
      });
    }
    // }catch(e){
    //   print(e);
    //   setState(() {
    //     state = 'no_internet';
    //   });
    // }
    

  }

  @override
  void initState() {

    if (global.prefs.getString('name') == null || global.prefs.getInt('id') == null) {
      state = 'reg';
    } else {
      getAll();
      if(users == null){
        state = 'loading';
      }else{
        state = 'table';
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case 'reg':
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
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
                    fillColor: global.thems[global.selectedThem]['add'].withOpacity(0.4),
                    // prefixIconColor: global.thems[global.selectedThem]['bg'],
                    // suffixIconColor: global.thems[global.selectedThem]['bg'],
                    // hoverColor: global.thems[global.selectedThem]['bg'],
                    filled: true,
                    hintText: "имя",
                    hintStyle: TextStyle(
                        color: global.thems[global.selectedThem]['bg'],
                    ),
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
                        setState(() {
                          state = 'loading';
                        });
                        registration(name);
                      }
        
                    },
                    elevation: 0,
                    backgroundColor: global.thems[global.selectedThem]['add'].withOpacity(0.4),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      // weight: 700,
                      color: global.thems[global.selectedThem]['bg'],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      
      case 'table':
        return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: DataTable(
                dataTextStyle: TextStyle(color: global.thems[global.selectedThem]['text'], fontWeight: FontWeight.w600),
                dataRowHeight: 35,
                columns:  [
                  DataColumn(
                    label: Text('№', style: TextStyle(color: global.thems[global.selectedThem]['text']))
                  ),
                  DataColumn(
                    label: Text('Name', style: TextStyle(color: global.thems[global.selectedThem]['text']))
                  ),
                  DataColumn(
                    label: Text('Score', style: TextStyle(color: global.thems[global.selectedThem]['text']))
                  ),
                ],
                rows:  [
                  for(int i = 0;i<=4;i++)
                    if(i <= 2)
                      DataRow(cells:[
                        DataCell(Text((i + 1).toString(), style: leaderTextStyles[i],)),
                        DataCell(Text(users![i].name.toString(), style: leaderTextStyles[i],)),
                        DataCell(Text(users![i].score.toString(), style: leaderTextStyles[i],)),
                      ])
                    else
                      DataRow(cells:[
                        DataCell(Text((i + 1).toString())),
                        DataCell(Text(users![i].name.toString())),
                        DataCell(Text(users![i].score.toString())),
                      ]),

                ]
              ),
            ),
        );
      case "loading":
        return Padding(
          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 5),
          child: Center(
            child: CircularProgressIndicator(
              color: global.thems[global.selectedThem]['btn'],
            ),
          ),
        );
      case "no_internet":
        return Padding(
          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 5),
          child: Center(
            child: Text(
              'NO INTERNET :(', 
              style: TextStyle(
                color: global.thems[global.selectedThem]['text'],
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),)
          ),
        );
      default:
        return Padding(
          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 5),
          child: Center(
            child: CircularProgressIndicator(
              color: global.thems[global.selectedThem]['btn'],
            ),
          ),
        );
    }
  }
}