import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elysian_user/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signup(String name, String email, String password);
  Future<UserModel> googleLogin();
  Future<UserModel> getCurrentUser();
  Future<void> logout();
  Future<void> forgotPassword(String email);
  Future<void> deleteAccount();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.googleSignIn,
  });

  @override
  Future<UserModel> login(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = userCredential.user!.uid;
    final userDoc = await firebaseFirestore.collection('users').doc(uid).get();

    if (userDoc.exists) {
      final userModel = UserModel.fromSnapshot(userDoc);
      // Update photoURL from Firebase Auth if available
      final photoURL = userCredential.user?.photoURL;
      if (photoURL != null && userModel.photoURL != photoURL) {
        return UserModel(
          uid: userModel.uid,
          email: userModel.email,
          name: userModel.name,
          photoURL: photoURL,
        );
      }
      return userModel;
    } else {
      // Fallback if user exists in Auth but not in Firestore (should not happen in normal flow)
      return UserModel(
        uid: uid,
        email: email,
        name: userCredential.user?.displayName ?? '',
        photoURL: userCredential.user?.photoURL,
      );
    }
  }

  @override
  Future<UserModel> signup(String name, String email, String password) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = userCredential.user!.uid;
    final photoURL = userCredential.user!.photoURL;
    final userModel = UserModel(
      uid: uid,
      email: email,
      name: name,
      photoURL: photoURL,
    );

    await firebaseFirestore
        .collection('users')
        .doc(uid)
        .set(userModel.toDocument());

    // Also update displayName in Firebase Auth
    await userCredential.user!.updateDisplayName(name);

    return userModel;
  }

  @override
  Future<UserModel> googleLogin() async {
    // Trigger the Google Sign-In flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // If the user cancels the sign-in, throw an exception
    if (googleUser == null) {
      throw Exception('Google Sign In was cancelled by user');
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential with the tokens
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await firebaseAuth.signInWithCredential(credential);
    final uid = userCredential.user!.uid;
    final email = userCredential.user!.email ?? '';
    final name = userCredential.user!.displayName ?? '';
    final photoURL = userCredential.user!.photoURL;

    final userDoc = await firebaseFirestore.collection('users').doc(uid).get();

    if (userDoc.exists) {
      final userModel = UserModel.fromSnapshot(userDoc);
      // Update photoURL from Firebase Auth if available and different
      if (photoURL != null && userModel.photoURL != photoURL) {
        final updatedModel = UserModel(
          uid: userModel.uid,
          email: userModel.email,
          name: userModel.name,
          photoURL: photoURL,
        );
        // Update Firestore with new photoURL
        await firebaseFirestore.collection('users').doc(uid).update({
          'photoURL': photoURL,
        });
        return updatedModel;
      }
      return userModel;
    } else {
      final userModel = UserModel(
        uid: uid,
        email: email,
        name: name,
        photoURL: photoURL,
      );
      await firebaseFirestore
          .collection('users')
          .doc(uid)
          .set(userModel.toDocument());
      return userModel;
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      throw Exception('No user is currently signed in');
    }

    final uid = currentUser.uid;
    final userDoc = await firebaseFirestore.collection('users').doc(uid).get();

    if (userDoc.exists) {
      final userModel = UserModel.fromSnapshot(userDoc);
      // Get photoURL from Firebase Auth (it might be more up-to-date)
      final photoURL = currentUser.photoURL ?? userModel.photoURL;
      return UserModel(
        uid: userModel.uid,
        email: userModel.email,
        name: userModel.name,
        photoURL: photoURL,
      );
    } else {
      // Fallback: create user model from Firebase Auth data
      return UserModel(
        uid: uid,
        email: currentUser.email ?? '',
        name: currentUser.displayName ?? '',
        photoURL: currentUser.photoURL,
      );
    }
  }

  @override
  Future<void> logout() async {
    await googleSignIn.signOut();
    await firebaseAuth.signOut();
  }

  @override
  Future<void> forgotPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> deleteAccount() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      await firebaseFirestore.collection('users').doc(user.uid).delete();
      await user.delete();
    }
  }
}
