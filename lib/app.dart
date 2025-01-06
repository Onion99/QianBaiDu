
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class App extends StatefulWidget {

  const App({super.key});

  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}
class AppState extends State<App>{
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: MaterialApp(
      home: Scaffold(
        body: Stack(
          textDirection: TextDirection.rtl,
          fit: StackFit.loose,
          alignment: Alignment.center,
          // overflow: Overflow.clip, // 1.22.0 被去除
          children: <Widget>[Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(color: Colors.deepOrange,),
              Container(color: Colors.blueAccent,),
            ],
          )],
        ),
      ),
    ));
  }

}