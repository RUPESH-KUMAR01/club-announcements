import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable{
  final String id;
  final String email;
  final String name;
  final String RollNo;
  final bool isAdmin;
  final String Club;
  final String? picture;


  const MyUserEntity({
    required this.id, 
    required this.email, 
    required this.name, 
    required this.RollNo,
    this.isAdmin=false,
    required this.Club,
    this.picture
    });

  Map<String,Object?> toDocument(){
    return {
      'id':id,
      'email':email,
      'name':name,
      'RollNo':RollNo,
      'isAdmin':isAdmin,
      'Club':Club,
      'picture':picture
    };
  }

  static MyUserEntity fromDocument(Map<String,dynamic> doc){
    return MyUserEntity(
      id: doc['id'] as String,
     email: doc['email'] as String,
     name: doc['name'] as String,
     RollNo: doc['RollNo'] as String,
     isAdmin: doc['isAdmin'] as bool,
     Club: doc['Club'] as String,
     picture: doc['picture'] as String
     );
  }
  @override
  String toString() {
    return '''UserEntity{
      id:$id,
      email:$email,
      name:$name,
      RollNo:$RollNo,
      isAdmin:$isAdmin,
      Club:$Club,
      picture:$picture
    }''';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,email,name,RollNo,isAdmin,Club,picture];
}