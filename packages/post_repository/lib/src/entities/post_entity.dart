import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/user_repository.dart';

class PostEntity {
	String postId;
	String post;
	DateTime createAt;
	MyUser myUser;
  String picture;
  String desc;

	PostEntity({
		required this.postId,
		required this.post,
		required this.createAt,
		required this.myUser,
    required this.picture,
    required this.desc
	});

	Map<String, Object?> toDocument() {
    return {
      'postId': postId,
			'post': post,
      'createAt': createAt,
      'myUser': myUser.toEntity().toDocument(),
      'picture':picture,
      'desc':desc
    };
  }

	static PostEntity fromDocument(Map<String, dynamic> doc) {
    return PostEntity(
      postId: doc['postId'] as String,
			post: doc['post'] as String,
      createAt: (doc['createAt'] as Timestamp).toDate(),
      myUser: MyUser.fromEntity(MyUserEntity.fromDocument(doc['myUser']),),
      picture: doc['picture'] as String,
      desc: doc['desc'] as String
    );
  }
	
	@override
	List<Object?> get props => [postId, post, createAt, myUser,picture,desc];

	@override
  String toString() {
    return '''PostEntity: {
      postId: $postId
      post: $post
      createAt: $createAt
      myUser: $myUser
      picture: $picture
      desc: $desc
    }''';
  }
}