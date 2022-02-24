
// To parse this JSON data, do
//
//     final entriesModel = entriesModelFromJson(jsonString);

import 'dart:convert';

EntriesModel entriesModelFromJson(String str) => EntriesModel.fromJson(json.decode(str));

String entriesModelToJson(EntriesModel data) => json.encode(data.toJson());

class EntriesModel {
    EntriesModel({
        this.id,
        this.year = 0,
        this.month = 0,
        this.day = 0,
        this.comment = '',
        this.entries = 0.0,
    });

    int? id;
    int year;
    int month;
    int day;
    String comment;
    double entries;

    factory EntriesModel.fromJson(Map<String, dynamic> json) => EntriesModel(
        id: json["id"],
        year: json["year"],
        month: json["month"],
        day: json["day"],
        comment: json["comment"],
        entries: json["entries"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "year": year,
        "month": month,
        "day": day,
        "comment": comment,
        "entries": entries,
    };
}
