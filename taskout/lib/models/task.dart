import 'package:flutter/material.dart';

class CustomTask {
  String from;
  String to;
  String title;
  String description;
  List<String> tags;
  DateTime date;
  TimeOfDay time;
  int priority;
  DateTime created;
  List<Map<String, dynamic>> updates;

  CustomTask(
    this.from,
    this.to,
    this.title,
    this.description, {
    this.tags,
    this.date,
    this.time,
    this.priority,
    this.created,
    this.updates,
  });

  String _formatDate(DateTime toFormat) {
    String day = toFormat.day.toString();
    String month = toFormat.month.toString();
    String year = toFormat.year.toString();
    day = day.length == 1 ? "0" + day : day;
    month = month.length == 1 ? "0" + month : month;
    return year + "-" + month + "-" + day;
  }

  String _formatTime(TimeOfDay toFormat) {
    int hoursInt = toFormat.hour;
    String minutes = toFormat.minute.toString();
    if (toFormat.toString().contains("PM")) {
      hoursInt = hoursInt + 12;
    }
    String hours = hoursInt.toString();
    hours = hours.length == 1 ? "0" + hours : hours;
    minutes = minutes.length == 1 ? "0" + minutes : minutes;
    return hours + ":" + minutes + ":00.000";
  }

  Map<String, dynamic> get taskData {
    Map<String, dynamic> data = {
      "from": from,
      "to": to,
      "title": title,
      "description": description,
    };
    if (tags != null && tags.length > 0) {
      data["tags"] = tags;
    }
    if (date != null) {
      DateTime deadlineToPut;
      if (time == null) {
        deadlineToPut = DateTime.parse(_formatDate(date) + " 00:00:00.000");
      } else {
        deadlineToPut =
            DateTime.parse(_formatDate(date) + " " + _formatTime(time));
      }
      data["deadline"] = deadlineToPut.millisecondsSinceEpoch;
    }
    if (priority != null) {
      data["priority"] = priority;
    }
    if (created != null) {
      data["created"] = created.millisecondsSinceEpoch;
    }
    if (updates != null) {
      data["updates"] = updates;
    }
    return data;
  }
}
