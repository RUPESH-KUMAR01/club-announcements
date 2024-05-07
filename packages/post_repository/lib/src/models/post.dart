import 'package:user_repository/user_repository.dart';

import '../entities/entities.dart';

class Post {
	String postId;
	String post;
	DateTime createAt;
	MyUser myUser;
  String picture;
  String desc;

	Post({
		required this.postId,
		required this.post,
		required this.createAt,
		required this.myUser,
    required this.picture,
    required this.desc
	});

	/// Empty user which represents an unauthenticated user.
  static final empty = Post(
		postId: '', 
		post: '',
		createAt: DateTime.now(), 
		myUser: MyUser.empty,
    picture: '',
    desc: ''
	);

	/// Modify MyUser parameters
	Post copyWith({
    String? postId,
    String? post,
    DateTime? createAt,
    MyUser? myUser,
    String? picture,
    String? desc
  }) {
    return Post(
      postId: postId ?? this.postId,
      post: post ?? this.post,
      createAt: createAt ?? this.createAt,
      myUser: myUser ?? this.myUser,
      picture: picture ?? this.picture,
      desc: desc ?? this.desc
    );
  }

	/// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == Post.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != Post.empty;

	PostEntity toEntity() {
    return PostEntity(
      postId: postId,
      post: post,
      createAt: createAt,
      myUser: myUser,
      picture:picture,
      desc: desc
    );
  }

	static Post fromEntity(PostEntity entity) {
    return Post(
      postId: entity.postId,
      post: entity.post,
      createAt: entity.createAt,
      myUser: entity.myUser,
      picture: entity.picture,
      desc: entity.desc
    );
  }

	@override
  String toString() {
    return '''Post: {
      postId: $postId
      post: $post
      createAt: $createAt
      myUser: $myUser
      picture: $picture
      entity: $desc
    }''';
  }
	
}