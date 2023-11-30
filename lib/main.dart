import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'global.dart' as global;
import 'menu.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  global.prefs = await SharedPreferences.getInstance();
  global.selectedThem = global.prefs.getString('selectedThem');
  global.score = global.prefs.getInt('score') ?? 0;
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool init = true;

  double generatePosTop(BuildContext context) {
    return (Random().nextDouble() *
        (MediaQuery.of(context).size.height - 180 - 75));
  }

  double generatePosLeft(BuildContext context) {
    return (Random().nextDouble() * (MediaQuery.of(context).size.width - 75));
  }

  @override
  void initState() {
    global.selectedThem ??= 'Cobalt';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double top = generatePosTop(context);
    double left = generatePosLeft(context);

    return Scaffold(
        backgroundColor: global.thems[global.selectedThem]['bg'],
        appBar: AppBar(
            toolbarHeight: 120,
            backgroundColor: global.thems[global.selectedThem]['bg'],
            title: Text(
              '${global.score}',
              style: TextStyle(
                  fontSize: 100,
                  color: global.thems[global.selectedThem]['text']),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  HapticFeedback.lightImpact();
                  await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Menu()),
                              );
                  HapticFeedback.lightImpact();
                }, 
                icon: Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 50),
                  child: Icon(
                    Icons.menu_rounded,
                    size: 45,
                    color: global.thems[global.selectedThem]['text'],
                  ),
                )
              )
            ]),
        body: SizedBox(
          key: UniqueKey(),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
            margin: EdgeInsets.only(
              top: top,
              left: left,
              right: MediaQuery.of(context).size.width - left - 75,
              bottom: MediaQuery.of(context).size.height - top - 75 - 180,
            ),
            key: UniqueKey(),
            child: SizedBox(
              width: 75,
              height: 75,
              child: FloatingActionButton(
                  onPressed: () async {
                    HapticFeedback.heavyImpact();
                    setState(() {
                      global.score ++;
                    });
                    global.prefs.setInt('score', global.score);
                  },
                  elevation: 0,
                  backgroundColor: global.thems[global.selectedThem]['btn'],
                  shape: const CircleBorder()),
            ),
          ),
        ));
  }
}
