

import 'package:auth/src/features/authentication/screens/login/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

signUpUser(String userName, String userEmail, String userPassword)async{
  User? userid = FirebaseAuth.instance.currentUser;
  try{
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userid!.uid)
        .set({
      'userEmail': userEmail,
      'userPassword': userPassword,
      'createdAt': DateTime.now(),
      'userId': userid.uid,
    }).then((value) =>{
      FirebaseAuth.instance.signOut(),
      Get.to(() => LoginScreen())
    });
  }on FirebaseAuthException catch(e){
    print("error $e");
  }

}
// SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());

//this code will store in collection instead of authentication
/*
*                   var userName = userNameController.text.trim();
*                   var userEmail = userEmailController.text.trim();
*                   var userPassword = userPasswordController.text.trim();
*                   FirebaseAuth.instance.createUserWithEmailAndPassword(
* email: userEmail, password:userPassword).then((value) =>{ log("usercreated"),
* FirebaseFirestore.instance.collection("users").doc().set({
* 'username': userNmae,
* 'userEmail': userEmail,
* 'userPassword':userPassword, }),
* });
*
*
* */
// final user = UserModel(fullName: controller.fullname.text.trim(),
//     email: controller.email.text.trim(),
//     password: controller.password.text.trim()
// );
// SignUpController.instance.createUser(user);