import 'package:equatable/equatable.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object> get props => []; 
}

class CalendarInitial extends CalendarState {}

class CalendarSaveInProgress extends CalendarState {}

class CalendarSaveSuccess extends CalendarState {}

class CalendarSaveFailure extends CalendarState {}