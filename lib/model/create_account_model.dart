// To parse this JSON data, do
//
//     final createAccountModel = createAccountModelFromJson(jsonString);

import 'dart:convert';

CreateAccountModel createAccountModelFromJson(String str) => CreateAccountModel.fromJson(json.decode(str));

String createAccountModelToJson(CreateAccountModel data) => json.encode(data.toJson());

class CreateAccountModel {
  CreateAccountModel({
    this.status,
    this.message,
    this.token,
    this.data,
  });

  bool? status;
  String? message;
  String? token;
  Data? data;

  factory CreateAccountModel.fromJson(Map<String, dynamic> json) => CreateAccountModel(
    status: json["status"],
    message: json["message"],
    token: json["token"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "token": token,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.idSocial,
    this.firstName,
    this.lastName,
    this.email,
    this.intersted,
    this.mobileNo,
    this.createdAt,
    this.updatedAt,
    this.role,
    this.status,
  });

  int? id;
  String? idSocial;
  String? firstName;
  String? lastName;
  String? email;
  String? intersted;
  String? mobileNo;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? role;
  String? status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    idSocial: json["id_social"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    intersted: json["intersted"],
    mobileNo: json["mobile_no"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    role: json["role"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_social": idSocial,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "intersted": intersted,
    "mobile_no": mobileNo,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "role": role,
    "status": status,
  };
}
