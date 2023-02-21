import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ebay_auction/consts/consts.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  // Text Controller
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Determine if the user is authenticated
  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Saving the user data
    try {
      final userDocRef = _db.collection('users').doc(googleUser.id);

      await userDocRef.set({
        'id': googleUser.id,
        'email': googleUser.email,
        'name': googleUser.displayName,
        'imageUrl': googleUser.photoUrl
      });
    } catch (error) {
      print('Error signing in with Google: $error');
    }

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

// signOut
  signOut(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

// Login Method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }
}
