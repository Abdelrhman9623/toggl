// To parse this JSON data, do
//
//     final timeEntries = timeEntriesFromMap(jsonString);

import 'dart:convert';

TimeEntries timeEntriesFromMap(String str) =>
    TimeEntries.fromMap(json.decode(str));

String timeEntriesToMap(TimeEntries data) => json.encode(data.toMap());

class TimeEntries {
  TimeEntries({
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

  final int id;
  final String guid;
  final int wid;
  final int pid;
  final bool billable;
  final DateTime start;
  final DateTime stop;
  final int duration;
  final String description;
  final bool duronly;
  final DateTime at;
  final int uid;

  factory TimeEntries.fromMap(Map<String, dynamic> json) => TimeEntries(
        id: json["id"] == null ? null : json["id"],
        guid: json["guid"] == null ? null : json["guid"],
        wid: json["wid"] == null ? null : json["wid"],
        pid: json["pid"] == null ? null : json["pid"],
        billable: json["billable"] == null ? null : json["billable"],
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        stop: json["stop"] == null ? null : DateTime.parse(json["stop"]),
        duration: json["duration"] == null ? null : json["duration"],
        description: json["description"] == null ? null : json["description"],
        duronly: json["duronly"] == null ? null : json["duronly"],
        at: json["at"] == null ? null : DateTime.parse(json["at"]),
        uid: json["uid"] == null ? null : json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "guid": guid == null ? null : guid,
        "wid": wid == null ? null : wid,
        "pid": pid == null ? null : pid,
        "billable": billable == null ? null : billable,
        "start": start == null ? null : start.toIso8601String(),
        "stop": stop == null ? null : stop.toIso8601String(),
        "duration": duration == null ? null : duration,
        "description": description == null ? null : description,
        "duronly": duronly == null ? null : duronly,
        "at": at == null ? null : at.toIso8601String(),
        "uid": uid == null ? null : uid,
      };
}
