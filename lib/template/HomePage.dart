import 'package:calendar_event_app/template/CalendarControl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Создать событие календаря'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: CalendarControl(),
          ),
        ),
      ),
    );
  }
}
