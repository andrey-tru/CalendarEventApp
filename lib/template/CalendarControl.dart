import 'package:calendar_event_app/bloc/CalendarBloc.dart';
import 'package:calendar_event_app/event/CalendarEvent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CalendarControl extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalendarControl();
  }
}

class _CalendarControl extends State<CalendarControl> {
  String startDate, startTime, completionDate, completionTime;
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateCompletionController = TextEditingController();
  TextEditingController timeCompletionController = TextEditingController();
  TextEditingController eventText = TextEditingController();

  DateTime eventStartDate, eventCompletionDate;
  DateTime date = DateTime.now();
  DateTime dateEnd = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  TimeOfDay timeEnd = TimeOfDay.now();

  String dateFormat, timeFormat;

  @override
  void initState() {
    dateFormat = DateFormat('dd-MM-yyyy').format(DateTime.now());
    timeFormat =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    dateController.text = dateFormat;
    timeController.text = timeFormat;
    dateCompletionController.text = dateFormat;
    timeCompletionController.text = timeFormat;

    startDate = dateController.text;
    startTime = timeController.text;
    completionDate = dateCompletionController.text;
    completionTime = timeCompletionController.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2024),
            ).then(
              (value) => setState(() {
                startDate = DateFormat('dd-MM-yyyy').format(value);
                dateController.text = startDate;
                date = value;
              }),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Дата начала события'),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: TextFormField(
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                  enabled: false,
                  keyboardType: TextInputType.text,
                  controller: dateController,
                  onSaved: (String arg) {
                    startDate = arg;
                  },
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            showTimePicker(
              initialTime: TimeOfDay.now(),
              context: context,
            ).then(
              (value) => setState(() {
                startTime =
                    '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
                timeController.text = startTime;
                time = value;
              }),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: TextFormField(
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                  enabled: false,
                  keyboardType: TextInputType.text,
                  controller: timeController,
                  onSaved: (String arg) {
                    startTime = arg;
                  },
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2024),
            ).then(
              (value) => setState(() {
                completionDate = DateFormat('dd-MM-yyyy').format(value);
                dateCompletionController.text = completionDate;
                dateEnd = value;
              }),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Дата завершения события'),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: TextFormField(
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                  enabled: false,
                  keyboardType: TextInputType.text,
                  controller: dateCompletionController,
                  onSaved: (String arg) {
                    completionDate = arg;
                  },
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            showTimePicker(
              initialTime: TimeOfDay.now(),
              context: context,
            ).then(
              (value) => setState(() {
                completionTime =
                    '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
                timeCompletionController.text = completionTime;
                timeEnd = value;
              }),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: TextFormField(
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                  enabled: false,
                  keyboardType: TextInputType.text,
                  controller: timeCompletionController,
                  onSaved: (String arg) {
                    completionTime = arg;
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.text,
            controller: eventText,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Введите событие",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.indigo,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          child: Text(
            'Создать событие',
            style: TextStyle(
              fontSize: 20,
              color: Colors.indigo,
            ),
          ),
          onPressed: () {
            eventStartDate = DateTime(
                date.year, date.month, date.day, time.hour, time.minute);
            eventCompletionDate = DateTime(dateEnd.year, dateEnd.month,
                dateEnd.day, timeEnd.hour, timeEnd.minute);
            BlocProvider.of<CalendarBloc>(context).add(CalendarRequested(
                eventText: eventText.text,
                startDate: eventStartDate,
                completionDate: eventCompletionDate));
          },
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.indigo),
          ),
        ),
      ],
    );
  }
}
