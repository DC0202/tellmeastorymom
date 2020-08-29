import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Stream<User> get firebaseUser {
    return _auth.authStateChanges();
  }

  Future<bool> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    User user = (await _auth.signInWithCredential(credential)).user;
    await firebaseFirestore.collection('Users').get().then((value) {
      value.docs.forEach((element) {
        element.data().forEach((key, value) {
          if (key.toString() == "emailID" && value.toString() == user.email) {
            return true;
          }
        });
      });
    });
    print(user.email);

    // Once signed in, return the UserCredential
    return false;
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Sign Out");
  }
}
