import 'dart:convert';
import 'package:football_fields_system/services/ReservedHoursModule.dart';
import 'package:football_fields_system/services/database_methods.dart';
import 'package:flutter/material.dart';
import 'package:football_fields_system/widget&constants/constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart'as http;

class FieldTable extends StatefulWidget {

  final int playgroundID;
  FieldTable({this.playgroundID});

  @override
  _FieldTableState createState() => new _FieldTableState();
}

class _FieldTableState extends State<FieldTable> {

  List resHours = [] ;
  List<Meeting> meetings = [];
  CalendarTapDetails selectedTapDetails;
  ReservedHour reservedHour = ReservedHour();
  DatabaseMethods databaseMethods = DatabaseMethods();

  Future<dynamic> getListOfReservedHours()async{
    final apiUrl = 'https://fbrs.herokuapp.com/fb/playgrounds/${widget.playgroundID}';
   try{
     http.Response response = await http.get(Uri.parse(apiUrl));
     if(response.statusCode == 200){
       var bigClass = ReservedHours.fromJson(jsonDecode(response.body));
       for(var hour in bigClass.reservedHour){
         DateTime parseDt = DateTime.parse(hour.reservedHour);
         meetings.add(
           Meeting(hour.player.toString(), parseDt, parseDt.add(const Duration(hours: 1)), Colors.teal, false)
         );
       }
     }else{
       return null ;
     }
   }catch(e){
     print(e);
   }
    return meetings ;
  }

  @override
  void initState() {
    super.initState();
    print(widget.playgroundID);
    getListOfReservedHours().then((value) {
      setState(() {
        meetings = value ;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Field schedule"),
        flexibleSpace: appBarStyle,
        actions: [IconButton(icon: Icon(Icons.refresh), onPressed: (){setState(() {
        });})],
      ),
      body: SfCalendar(
        view: CalendarView.week,
        dataSource: meetings.isEmpty? null : MeetingDataSource(meetings),
        showNavigationArrow: true,
        showDatePickerButton: true,
        allowViewNavigation: true,
        onTap: (tapDetails){
           selectedTapDetails= tapDetails;
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.payment),
        onPressed: ()async{
          DateTime time = _getDataSource(selectedTapDetails);
          print(time);
          await databaseMethods.reserveHour(context,time,widget.playgroundID).then((value) => print(value));
          setState(() {
            getListOfReservedHours();
          });
          print(time.hour.runtimeType);
        },
      ),
    );
  }
}

DateTime _getDataSource( CalendarTapDetails selectedTapDetails){

  final DateTime startTime =
  DateTime(selectedTapDetails.date.year, selectedTapDetails.date.month, selectedTapDetails.date.day, selectedTapDetails.date.hour);
  final DateTime endTime = startTime.add(const Duration(hours: 1));
  return startTime;
}


class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}