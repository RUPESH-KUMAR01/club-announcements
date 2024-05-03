
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:user_repository/src/user_repo.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepository implements UserRepository{
FirebaseUserRepository({
  FirebaseAuth? firebaseAuth,
}):_firebaseAuth=firebaseAuth??FirebaseAuth.instance;


final UsersCollection=FirebaseFirestore.instance.collection('users');
final FirebaseAuth _firebaseAuth;

  @override
  Future<void> LogOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    // TODO: implement resetPassword
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    // TODO: implement signIn
    try{
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email, 
        password: password);
    }
    catch(e){
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    // TODO: implement signUp
    try{
      UserCredential user=await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email,
         password: password);
      myUser=myUser.copyWith(id: user.user!.uid);
      return myUser;
    }catch(e){
      log(e.toString());
      rethrow;
    }
  }
  
@override
Future<MyUser> getMyUser(String myUserId) async {
    try {
      return UsersCollection.doc(myUserId).get().then((value) =>
				MyUser.fromEntity(MyUserEntity.fromDocument(value.data()!))
			);
    } catch (e) {
			log(e.toString());
      rethrow;
    }
  }
  
  @override
  Future<void> setUserData(MyUser myuser) async {
    // TODO: implement setUserData
    try {
      await UsersCollection.doc(myuser.id).set(myuser.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  
  @override
  // TODO: implement user
  Stream<User?> get user{
    return _firebaseAuth.authStateChanges().map((
      firebaseUser){
        final user=firebaseUser;
        return user;
    } );
  }

  Stream<MyUser>  userdetails(String MyUserId){
    return UsersCollection.doc(MyUserId).snapshots().map((val) => MyUser.fromEntity(MyUserEntity.fromDocument(val.data()!)));
  }
  
  @override
  // TODO: implement getallusers
  Stream<List<MyUser>> get getallusers {
    return UsersCollection.snapshots().
    map((event) => event.docs.
    map((e) => MyUser.fromEntity(MyUserEntity.fromDocument(e.data()))).toList()
    );
  }
  
  @override
  Future<List<MyUser>> GetAllUsers() async{
    List<MyUser> users=[];
        try {
      final pro=await UsersCollection.get();
      pro.docs.forEach((element) {
        return users.add(MyUser.fromEntity(MyUserEntity.fromDocument(element.data())));
      });
      return users;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  @override
	 Future<String> uploadPicture(String file, String userId) async {
		try {
		  File imageFile = File(file);
			Reference firebaseStoreRef = FirebaseStorage
				.instance
				.ref()
				.child('$userId/PP/${userId}_lead');
			await firebaseStoreRef.putFile(
        imageFile,
      );
			String url = await firebaseStoreRef.getDownloadURL();
			await UsersCollection
				.doc(userId)
				.update({'picture': url});
			return url;
		} catch (e) {
		  log(e.toString());
			rethrow;
		}
	}

}