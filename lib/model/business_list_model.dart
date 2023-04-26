// To parse this JSON data, do
//
//     final businessListModel = businessListModelFromJson(jsonString);

import 'dart:convert';

BusinessListModel businessListModelFromJson(String str) => BusinessListModel.fromJson(json.decode(str));

String businessListModelToJson(BusinessListModel data) => json.encode(data.toJson());

class BusinessListModel {
  BusinessListModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory BusinessListModel.fromJson(Map<String, dynamic> json) => BusinessListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
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
    this.coverResizeUrl,
    this.idItemGallery,
    this.socialMedia,
    this.isFavourite,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? bio;
  String? website;
  String? logoUrl;
  String? idCountry;
  String? address;
  double? latitude;
  double? longitude;
  String? openingHours;
  String? phoneNumber;
  String? category;
  String? coverUrl;
  String? coverResizeUrl;
  List<int>? idItemGallery;
  String? socialMedia;
  bool? isFavourite;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    bio: json["bio"],
    website: json["website"],
    logoUrl: json["logo_url"],
    idCountry: json["id_country"],
    address: json["address"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    openingHours: json["opening_hours"],
    phoneNumber: json["phone_number"],
    category: json["category"],
    coverUrl: json["cover_url"],
    coverResizeUrl: json["cover_resize_url"],
    idItemGallery: json["id_item_gallery"] == null ? [] : List<int>.from(json["id_item_gallery"]!.map((x) => x)),
    socialMedia: json["social_media"],
    isFavourite: json["isFavourite"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "bio": bio,
    "website": website,
    "logo_url": logoUrl,
    "id_country": idCountry,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "opening_hours": openingHours,
    "phone_number": phoneNumber,
    "category": category,
    "cover_url": coverUrl,
    "cover_resize_url": coverResizeUrl,
    "id_item_gallery": idItemGallery == null ? [] : List<dynamic>.from(idItemGallery!.map((x) => x)),
    "social_media": socialMedia,
    "isFavourite": isFavourite,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
