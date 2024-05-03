import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/entites.dart';

class MyUser extends Equatable{
  final String id;
  final String email;
  final String name;
  final String RollNo;
  final bool isAdmin;
  final String Club;
  String? picture;

  MyUser({
    required this.id, 
    required this.email, 
    required this.name,
    required this.RollNo,
    this.isAdmin=false,
    required this.Club,
    this.picture});
  static  final empty=MyUser(
    id: '',
    email: '',
    name: '',
    RollNo:'',
    isAdmin: false,
    Club: '',
    picture: '');

  MyUser copyWith({
  String? id,
  String? email,
  String? name,
  String? RollNo,
  bool? isAdmin,
  String? Club,
  String? picture
  }){
    return MyUser(
      id: id ?? this.id,
       email: email ?? this.email,
        name: name ?? this.name,
        RollNo:RollNo??this.RollNo,
        isAdmin: isAdmin??this.isAdmin,
        Club: Club??this.Club,
        picture: picture??this.picture
         );
  }

  bool get isEmpty => this==MyUser.empty;

  bool get isNotEMpty => this!=MyUser.empty;


  MyUserEntity toEntity(){
    return MyUserEntity(
      id:id,
      email:email,
      name:name,
      RollNo:RollNo,
      isAdmin: isAdmin,
      Club: Club,
      picture: picture
    );
  }

  static  MyUser fromEntity(MyUserEntity entity){
    return MyUser(
      id: entity.id,
       email: entity.email, 
       name: entity.name,
       RollNo: entity.RollNo,
       isAdmin: entity.isAdmin,
       Club: entity.Club,
       picture: entity.picture);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,email,name,RollNo,isAdmin,Club,picture];
}