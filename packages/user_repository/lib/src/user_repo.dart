import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

abstract class UserRepository{

  Stream<User?> get user;
  Future<void> signIn(String email,String password);
  Future<void> LogOut();
  Future<MyUser> signUp(MyUser myUser,String password);
  Future<void> resetPassword(String email);
  Stream<MyUser>  userdetails(String MyUserId);
  //set User data
  Future<void> setUserData(MyUser myuser);
  //get User data
  Future<MyUser> getMyUser(String MyUserId);
  Stream<List<MyUser>> get getallusers;
  Future<List<MyUser>> GetAllUsers();
  Future<String> uploadPicture(String file, String userId);
 }