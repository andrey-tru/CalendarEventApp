import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart';
import 'package:url_launcher/url_launcher.dart';

class ApiCalendar {
  String _apiKey =
      "your clientId";
  static const _scopes = const [CalendarApi.calendarScope];

  Future getCalendar(eventText, startDate, completeDate) async{
    ClientId _clientId = new ClientId(_apiKey, "");
    clientViaUserConsent(_clientId, _scopes, launchUrl)
        .then((AuthClient client) {
      var calendar = CalendarApi(client);
      calendar.calendarList.list();

      String calendarId = "primary";
      Event event = Event();

      event.summary = eventText;

      EventDateTime start = new EventDateTime();
      start.dateTime = startDate;
      start.timeZone = "GMT+03:00";
      event.start = start;

      EventDateTime end = new EventDateTime();
      end.timeZone = "GMT+03:00";
      end.dateTime = completeDate;
      event.end = end;
      try {
        calendar.events.insert(event, calendarId);
      } catch (e) {
        print('$e');
      }
    });
  }

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
