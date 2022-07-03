import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/storage.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

List<bool> isSelected = [false, false, false];
FocusNode focusNodeButton1 = FocusNode();
FocusNode focusNodeButton2 = FocusNode();
FocusNode focusNodeButton3 = FocusNode();
List<FocusNode>? focusToggle;



class _LanguageScreenState extends State<LanguageScreen> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    focusToggle = [focusNodeButton1, focusNodeButton2, focusNodeButton3];
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusNodeButton1.dispose();
    focusNodeButton2.dispose();
    focusNodeButton3.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    List<bool> _selections = List.generate(3, (_) => false);
    return Container(
      height: 200,
      child: Scaffold(
        appBar: AppBar(
          title: Text("language"),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 100),
          padding: EdgeInsets.all( 30),
          child: ToggleButtons(
            focusNodes: focusToggle,
            isSelected: isSelected,
            onPressed: (int index) {
              setState(() {
                for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                  if (buttonIndex == index) {
                    isSelected[buttonIndex] = true;
                  } else {
                    isSelected[buttonIndex] = false;
                  }
                }
              });
            },
            children: [
              TextButton(
                  onPressed: () {
                    myController.changeLanguage('ar', 'YE');
                  },
                  child: Text("Set to Arabic")),
              TextButton(
                  onPressed: () {
                    myController.changeLanguage('en', 'US');
                  },
                  child: Text("Set to English")),
              TextButton(
                  onPressed: () {
                    myController.changeLanguage('en', 'US');
                  },
                  child: Text("Set to English"))
            ],
          ),
        ),
      ),
    );
  }
}
