// To parse this JSON data, do
//
//     final featuresModel = featuresModelFromJson(jsonString);

import 'dart:convert';

FeaturesModel featuresModelFromJson(String str) => FeaturesModel.fromJson(json.decode(str));

String featuresModelToJson(FeaturesModel data) => json.encode(data.toJson());

class FeaturesModel {
    FeaturesModel({
        this.id,
        this.category = '',
        this.color = '#baf748',
        this.icon = 'adb_rounded',
    });

    int? id;
    String category;
    String color;
    String icon;

    factory FeaturesModel.fromJson(Map<String, dynamic> json) => FeaturesModel(
        id: json["id"],
        category: json["category"],
        color: json["color"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "color": color,
        "icon": icon,
    };
}
