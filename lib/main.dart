import 'package:flutter/material.dart';

import 'package:work_nigeria/Screens/SearchPage.dart';

void main() {
  runApp(WorkNigeria());
}

class WorkNigeria extends StatefulWidget {
  @override
  _WorkNigeriaState createState() => _WorkNigeriaState();
}

class _WorkNigeriaState extends State<WorkNigeria> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchPage(),
    );
  }
}
