import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationController extends GetxController {
  var isLoading = false.obs;

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(accessToken: googleAuth!.accessToken, idToken: googleAuth.idToken);
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;
      if(user != null){
        checkGoogleAccountIsAvailable(
          email: user.email,
          name: user.displayName,
          urlProfile: user.photoURL,
        );
      }
    } catch (e) {
      debugPrint('Error signing in with Google: ${e.toString()}');
    }
  }

/*
  1 = wes terdaftar dan langsung login
  2 = belum terdaftar dan diarahkan ke stepper
*/
// checkGoogleAccountIsAvailable API
  checkGoogleAccountIsAvailable({String? email, String? name, String? urlProfile}) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse("https://gifx-wxgcod-api.techcrm.net/login-google")!, 
        headers: {
          'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
          'Content-Type': 'application/x-www-form-urlencoded'
        }, 
        body: {
          'display_name': name,
          'display_picture': urlProfile,
          'email': email,
        },
      );
      var result = jsonDecode(response.body);
      // print("ini result checkGoogleAccountIsAvailable() $result");
      if (response.statusCode == 200) {
        // isLoading(false);
        // if (result['status'] == "true") {
        //   if(result['message'] == "Pendaftaran dengan google berhasil"){
        //     accountsModels.value = AccountsModels.fromJson(jsonDecode(response.body));
        //     prefs.setString('id', result['response']['personal_detail']['id']);
        //     Future.delayed(const Duration(seconds: 1), (){
        //       Get.to(() => StepperTrialPage(currentStep: int.parse(result['response']['personal_detail']['ver']), fromLogin: true));
        //     });
        //   }else if(result['message'] == "Login google berhasil"){
        //     accountsModels.value = AccountsModels.fromJson(jsonDecode(response.body));
        //     prefs.setString('id', result['response']['personal_detail']['id']);
        //     if(result['response']['personal_detail']['status'] == "2"){
        //       Future.delayed(const Duration(seconds: 1), (){
        //         Get.to(() => StepperTrialPage(currentStep: int.parse(result['response']['personal_detail']['ver']), fromLogin: true, loginWithGoogle: true));
        //       });
        //     }else if(result['response']['personal_detail']['status'] == "-1"){
        //       prefs.setBool('login', true);
        //       Future.delayed(const Duration(seconds: 1), (){
        //         prefs.setBool('loginWithGoogle', true);
        //         prefs.setString("emailGoogle", email!);
        //         prefs.setString('id', result['response']['personal_detail']['id']);
        //         Get.to(() => const MainPage());
        //       });
        //     }
        //   }
        // }else{
        //   print("masuk ke else = $result");
        // }
      } else {
        Get.snackbar("Failed", result['message'], backgroundColor: Colors.white, colorText: Colors.black87);
        isLoading(false);
        return false;
      }
    } catch (e) {
      isLoading(false);
      return false;
    }
  }
}