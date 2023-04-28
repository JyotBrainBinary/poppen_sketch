// To parse this JSON data, do
//
//     final favouriteListModel = favouriteListModelFromJson(jsonString);

import 'dart:convert';

FavouriteListModel favouriteListModelFromJson(String str) => FavouriteListModel.fromJson(json.decode(str));

String favouriteListModelToJson(FavouriteListModel data) => json.encode(data.toJson());

class FavouriteListModel {
  FavouriteListModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory FavouriteListModel.fromJson(Map<String, dynamic> json) => FavouriteListModel(
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
  String? openingHours;
  String? phoneNumber;
  String? category;
  String? coverUrl;
  String? coverResizeUrl;
  String? idItemGallery;
  String? socialMedia;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    idItemGallery: json["id_item_gallery"],
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
    "opening_hours": openingHours,
    "phone_number": phoneNumber,
    "category": category,
    "cover_url": coverUrl,
    "cover_resize_url": coverResizeUrl,
    "id_item_gallery": idItemGallery,
    "social_media": socialMedia,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
