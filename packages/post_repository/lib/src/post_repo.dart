import 'models/models.dart';

abstract class PostRepository {

	Future<Post> createPost(Post post,String file);

	Future<List<Post>> getPost();

}