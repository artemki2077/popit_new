import 'dart:convert';

import "package:http/http.dart" as http;
import '../global.dart' as global;


Future<void> updateData() async{
  try{
    if(global.prefs.getString('name') != null){
      http.Response response = await http.get(Uri.https(
      'script.google.com',
      '/macros/s/AKfycbxC9XgKgEi-hlv59HZxmdXO1VwK2054wauOFuQMSi7wYylewjjenFxJ9gCdM_8TPHAG/exec',
      {
        "type": "update",
        "id": global.prefs.getInt('id')!.toString(),
        "name": global.prefs.getString('name')!.toString(),
        "score": global.prefs.getInt('score')!.toString()
      }
      ));
      if (response.statusCode == 200) {
        String source = const Utf8Decoder().convert(response.bodyBytes);
        var data = jsonDecode(source);
        print(data);
      }else{
        print("error");
        print(response.body);
      }
    }
    
  // ignore: empty_catches
  }catch(e){
    print(e);
  }
    
  }