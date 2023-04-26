import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String email;
  final String firstName;
  final String lastName;
  final String uid;
  final String phone;


  UserModel(
      {required this.email,
        required this.firstName,
        required this.lastName,
        required this.uid,
        required this.phone,

       });

  Map<String, dynamic> toJson() => {
    "email": email,
    "uid": uid,
    "firstName": firstName,
    "lastName": lastName,
    "phone": phone,

  };

  static UserModel? fromSnap (DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(

      uid: snapshot['uid'],
      firstName: snapshot['firstName'],
      email: snapshot['email'],
      lastName: snapshot['lastName'],
      phone: snapshot['phone'],
    );
  }
}