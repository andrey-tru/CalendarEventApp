import 'package:calendar_event_app/api/ApiCalendar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calendar_event_app/event/CalendarEvent.dart';
import 'package:calendar_event_app/states/CalendarState.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  // final String eventText;
  // final String startDate;
  // final String completionData;

  CalendarBloc() : super(null) {
    CalendarSaveSuccess();
  }

  @override
  Stream<CalendarState> mapEventToState(CalendarEvent event) async* {
    if (event is CalendarRequested) {
      yield CalendarSaveInProgress();
      try {
        await ApiCalendar().getCalendar(
            event.eventText, event.startDate, event.completionDate);
        yield CalendarSaveSuccess();
      } catch (_) {
        yield CalendarSaveFailure();
      }
    }
  }
}
