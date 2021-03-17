// To parse this JSON data, do
//
//     final projectDetails = projectDetailsFromMap(jsonString);

import 'dart:convert';

ProjectDetails projectDetailsFromMap(String str) =>
    ProjectDetails.fromMap(json.decode(str));

String projectDetailsToMap(ProjectDetails data) => json.encode(data.toMap());

class ProjectDetails {
  ProjectDetails({
    this.id,
    this.wid,
    this.name,
    this.billable,
    this.isPrivate,
    this.active,
    this.template,
    this.at,
    this.createdAt,
    this.color,
    this.autoEstimates,
    this.actualHours,
    this.hexColor,
  });

  final int id;
  final int wid;
  final String name;
  final bool billable;
  final bool isPrivate;
  final bool active;
  final bool template;
  final DateTime at;
  final DateTime createdAt;
  final String color;
  final bool autoEstimates;
  final int actualHours;
  final String hexColor;

  factory ProjectDetails.fromMap(Map<String, dynamic> json) => ProjectDetails(
        id: json["id"] == null ? null : json["id"],
        wid: json["wid"] == null ? null : json["wid"],
        name: json["name"] == null ? null : json["name"],
        billable: json["billable"] == null ? null : json["billable"],
        isPrivate: json["is_private"] == null ? null : json["is_private"],
        active: json["active"] == null ? null : json["active"],
        template: json["template"] == null ? null : json["template"],
        at: json["at"] == null ? null : DateTime.parse(json["at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        color: json["color"] == null ? null : json["color"],
        autoEstimates:
            json["auto_estimates"] == null ? null : json["auto_estimates"],
        actualHours: json["actual_hours"] == null ? null : json["actual_hours"],
        hexColor: json["hex_color"] == null ? null : json["hex_color"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "wid": wid == null ? null : wid,
        "name": name == null ? null : name,
        "billable": billable == null ? null : billable,
        "is_private": isPrivate == null ? null : isPrivate,
        "active": active == null ? null : active,
        "template": template == null ? null : template,
        "at": at == null ? null : at.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "color": color == null ? null : color,
        "auto_estimates": autoEstimates == null ? null : autoEstimates,
        "actual_hours": actualHours == null ? null : actualHours,
        "hex_color": hexColor == null ? null : hexColor,
      };
}
