// To parse this JSON data, do
//
//     final viewBusinessModel = viewBusinessModelFromJson(jsonString);

import 'dart:convert';

ViewBusinessModel viewBusinessModelFromJson(String str) => ViewBusinessModel.fromJson(json.decode(str));

String viewBusinessModelToJson(ViewBusinessModel data) => json.encode(data.toJson());

class ViewBusinessModel {
  ViewBusinessModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory ViewBusinessModel.fromJson(Map<String, dynamic> json) => ViewBusinessModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.name,
    this.bio,
    this.website,
    this.logoUrl,
    this.idCountry,
    this.address,
    this.latitude,
    this.longitude,
    this.openingHours,
    this.phoneNumber,
    this.category,
    this.coverUrl,
    this.galleryList,
    this.socialMedia,
    this.createdAt,
    this.updatedAt,
  });

  String? name;
  String? bio;
  String? website;
  String? logoUrl;
  String? idCountry;
  String? address;
  double? latitude;
  double? longitude;
  List<String>? openingHours;
  String? phoneNumber;
  String? category;
  String? coverUrl;
  List<String>? galleryList;
  String? socialMedia;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    bio: json["bio"],
    website: json["website"],
    logoUrl: json["logo_url"],
    idCountry: json["id_country"],
    address: json["address"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    openingHours: json["opening_hours"] == null ? [] : List<String>.from(json["opening_hours"]!.map((x) => x)),
    phoneNumber: json["phone_number"],
    category: json["category"],
    coverUrl: json["cover_url"],
    galleryList: json["gallery_list"] == null ? [] : List<String>.from(json["gallery_list"]!.map((x) => x)),
    socialMedia: json["social_media"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "bio": bio,
    "website": website,
    "logo_url": logoUrl,
    "id_country": idCountry,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "opening_hours": openingHours == null ? [] : List<dynamic>.from(openingHours!.map((x) => x)),
    "phone_number": phoneNumber,
    "category": category,
    "cover_url": coverUrl,
    "gallery_list": galleryList == null ? [] : List<dynamic>.from(galleryList!.map((x) => x)),
    "social_media": socialMedia,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
