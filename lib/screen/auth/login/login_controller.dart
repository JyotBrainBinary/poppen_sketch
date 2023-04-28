import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sketch/api_call/login_api.dart';
import 'package:sketch/chat/chat_room_service.dart';
import 'package:sketch/chat/firebase_message_service.dart';
import 'package:sketch/common/popup.dart';
import 'package:sketch/screen/dashbord_screen/dashbord.dart';
import 'package:sketch/services/pref_service.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/pref_key.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  RxBool loading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void validateForm() {
    if (emailController.text.isEmpty) {
      errorToast(StringRes.emailValidation);
    } else if (!emailController.text.isEmail) {
      errorToast(StringRes.invalidEmailValidation);
    } else if (passController.text.isEmpty) {
      errorToast(StringRes.passwordValidation);
    } else {
      logInUser().then((value) {
        if(value == "done")
          {
             Get.to(() => DashBoardScreen());
            // callLoginApi();
          }
      });

    }
  }

  void callLoginApi() {
    try {
      loading.value = true;
      LoginApi.loginApi(
              email: emailController.text, password: passController.text)
          .then((value) {
        if (value != null) {
          loading.value = false;
          flutterToast("Login Successfully.");
          Get.to(() => DashBoardScreen());
        } else {
          loading.value = false;
          errorToast(StringRes.errText);
        }
      });
    } catch (e) {
      loading.value = false;
      errorToast(e.toString());
    }
  }


  Future<String> logInUser({
    String? email,
    String? password,
  }) async {
    String result = 'Some error occurred';
    try {
      loading.value = true;

      UserCredential user=  await _auth.signInWithEmailAndPassword(
            email: emailController.text, password: passController.text);
          await PrefService.setValue(PrefKeys.uid,
            _auth.currentUser!.uid.toString());
        result = 'done';

intializeFirebase(emailController.text,_auth.currentUser!.uid.toString(),user);

    } catch (err) {
      loading.value = false;
      errorToast(StringRes.errText);
    }
    return result;
  }


}
intializeFirebase(String email, String uid,UserCredential user) async {
    DocumentSnapshot doc;
    String? fcmToken = await MessageService().getFcmToken();
    try {

      print(user.user?.uid);
      final FirebaseAuth auth = FirebaseAuth.instance;
      print(auth.currentUser);


      if (user.user?.uid != null) {
        doc = await ChatRoomservice().isRoomAvailable(uid);
        if (doc.exists) {
          DocumentSnapshot docs = await FirebaseFirestore.instance
              .collection("chatroom")
              .doc(uid)
              .get();
          Map data = doc.data() as Map;
          if (data["isManager"].toString() == "true") {
            await FirebaseFirestore.instance.collection("chatroom").doc(uid).update({"fcmToken":fcmToken});
           await PrefService.setValue(PrefKeys.isManager, "true");


            // isManager = "true";
          } else {
            await FirebaseFirestore.instance.collection("chatroom").doc(uid).update({"fcmToken":fcmToken});
           await PrefService.setValue(PrefKeys.isManager, "flase");

          }
        } else {
        await PrefService.setValue(PrefKeys.isManager, "flase");
        }
       DocumentSnapshot docs1 = await FirebaseFirestore.instance
              .collection("users")
              .doc(uid)
              .get();

       if (docs1.exists) {
         Map data01 = docs1.data() as Map;
         PrefService.setValue(PrefKeys.fullName, "${data01['firstName']} ${data01['lastName']}");
       }       
      var getManagesId = await FirebaseFirestore.instance.collection("chatroom").get();
     for (var i = 0; i <  getManagesId.docs.length; i++) {
       print(getManagesId.docs[i]['isManager']);
       if (getManagesId.docs[i]['isManager'] == 'true') {
       await  PrefService.setValue(PrefKeys.managerID, getManagesId.docs[i]['id']);
        print(getManagesId.docs[i]['id']);

         break;
       } 
     }

      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        UserCredential user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: "123456");
        print(user.user?.uid);
      }
    }
  }