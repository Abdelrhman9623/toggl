// To parse this JSON data, do
//
//     final timeEntries = timeEntriesFromMap(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

class TimeEntries {
  TimeEntries({
    this.key,
    this.id,
    this.guid,
    this.wid,
    this.pid,
    this.billable,
    this.start,
    this.stop,
    this.duration,
    this.description,
    this.duronly,
    this.at,
    this.uid,
  });
  final dynamic key;
  final int id;
  final String guid;
  final int wid;
  final int pid;
  final bool billable;
  final String start;
  final String stop;
  final int duration;
  final String description;
  final bool duronly;
  final DateTime at;
  final int uid;

  factory TimeEntries.fromJson(String str) =>
      TimeEntries.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TimeEntries.fromMap(Map<String, dynamic> json) => TimeEntries(
        key: json["key"] == null ? null : json["key"],
        id: json["id"] == null ? null : json["id"],
        guid: json["guid"] == null ? null : json["guid"],
        wid: json["wid"] == null ? null : json["wid"],
        pid: json["pid"] == null ? null : json["pid"],
        billable: json["billable"] == null ? null : json["billable"],
        start: json["start"] == null
            ? null
            : DateFormat('yyyy-MM-dd hh:mm')
                .format(DateTime.parse(json["start"])),
        stop: json["stop"] == null
            ? null
            : DateFormat('yyyy-MM-dd hh:mm')
                .format(DateTime.parse(json["stop"])),
        duration: json["duration"] == null ? null : json["duration"],
        description: json["description"] == null ? null : json["description"],
        duronly: json["duronly"] == null ? null : json["duronly"],
        at: json["at"] == null ? null : DateTime.parse(json["at"]),
        uid: json["uid"] == null ? null : json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "key": key,
        "id": id == null ? null : id,
        "guid": guid == null ? null : guid,
        "wid": wid == null ? null : wid,
        "pid": pid == null ? null : pid,
        "billable": billable == null ? null : billable,
        "start": start == null ? null : start,
        "stop": stop == null ? null : stop,
        "duration": duration == null ? null : duration,
        "description": description == null ? null : description,
        "duronly": duronly == null ? null : duronly,
        "at": at == null ? null : at.toIso8601String(),
        "uid": uid == null ? null : uid,
      };
}
