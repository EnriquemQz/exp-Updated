import 'dart:convert';

ExpensesModel featuresModelFromJson(String str) => ExpensesModel.fromJson(json.decode(str));

String featuresModelToJson(ExpensesModel data) => json.encode(data.toJson());

class ExpensesModel {
    ExpensesModel({
        this.id,
        this.link,
        this.year = 0,
        this.month = 0,
        this.day = 0,
        this.comment = '',
        this.expense = 0.0,
    });

    int? id;
    int? link;
    int year;
    int month;
    int day;
    String comment;
    double expense;

    factory ExpensesModel.fromJson(Map<String, dynamic> json) => ExpensesModel(
        id: json["id"],
        link: json["link"],
        year: json["year"],
        month: json["month"],
        day: json["day"],
        comment: json["comment"],
        expense: json["expense"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "year": year,
        "month": month,
        "day": day,
        "comment": comment,
        "expense": expense,
    };
}
