import 'package:clean_architecture/features/posts/domain/entities/post.dart';
import 'package:dartz/dartz.dart';

abstract class PostsRespositories{
   Future <List<Post>> getAllPosts();
   Future<bool> deletePost(int id);
   Future<bool> updatePost(Post post);
   Future<bool> addPost(Post post);
}