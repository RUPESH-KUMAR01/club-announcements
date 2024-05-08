import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:post_repository/post_repository.dart';
import 'package:post_repository/src/models/post.dart';
import 'package:uuid/uuid.dart';
import 'post_repo.dart';

class FirebasePostRepository implements PostRepository {

	final postCollection = FirebaseFirestore.instance.collection('posts');

  @override
  Future<Post> createPost(Post post,String file) async {
    try {
      post.postId = const Uuid().v1();
			post.createAt = DateTime.now();
      File imageFile = File(file);
			Reference firebaseStoreRef = FirebaseStorage
				.instance
				.ref()
				.child('${post.myUser.id}/post/${post.postId}_lead');
			await firebaseStoreRef.putFile(
        imageFile,
      );
			String url = await firebaseStoreRef.getDownloadURL();
      post.picture=url;


      await postCollection
				.doc(post.postId)
				.set(post.toEntity().toDocument());

			return post;
    } catch (e) {
      log(e.toString());
			rethrow;
    }
  }

  @override
  Future<List<Post>> getPost() {
    try {
      return postCollection.orderBy('createAt',descending: true)
				.get()
				.then((value) => value.docs.map((e) => 
					Post.fromEntity(PostEntity.fromDocument(e.data()))
				).toList());
    } catch (e) {
      print(e.toString());
			rethrow;
    }
  }

}