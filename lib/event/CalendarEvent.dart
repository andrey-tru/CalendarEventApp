import 'package:equatable/equatable.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class CalendarRequested extends CalendarEvent {
  final String eventText;
  final DateTime startDate;
  final DateTime completionDate;

  const CalendarRequested({this.eventText, this.startDate, this.completionDate});

  List<Object> get props => [eventText, startDate, completionDate];
}