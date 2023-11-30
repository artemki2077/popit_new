import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'global.dart' as global;

class Thems extends StatefulWidget {
  final stater;
  const Thems({super.key, required this.stater});

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
        stater: widget.stater,
      ));
    });
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: generateThems(),
      ),
    );
  }
}

class Them extends StatefulWidget {
  final name;
  final index;
  final stater;
  const Them({super.key, required this.name, required this.index, required this.stater});

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
                    
                    widget.stater((){
                        global.selectedThem = name;
                      global.prefs.setString("selectedThem", global.selectedThem!);
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
              color: global.thems[global.selectedThem]['text'],
            ),
          ),
        ],
      ),
    );
  }
}
