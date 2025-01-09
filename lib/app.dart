
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'common/theme/colors.dart';

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
          children: <Widget>[Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: Container(color: Colors.deepOrange)),
              Expanded(child: Container(color: Colors.blueAccent)),
            ],
          ),Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                getButtonUI("选择图片",(){

                }),
                const SizedBox(
                  width: 16,
                ),
                getButtonUI("待定",(){

                }),
              ],
            ),
          )],
        ),
      ),
    ));
  }



  /// ------------------------------------------------------------------------
  /// Get Button UI
  /// ------------------------------------------------------------------------
  Widget getButtonUI(String buttonText,void Function()? tapEvent) {
    String txt = buttonText;
    return Wrap(
      children: [Container(
        decoration: BoxDecoration(
            color: nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: nearlyBlue)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: tapEvent,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: nearlyBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      )],
    );
  }
}