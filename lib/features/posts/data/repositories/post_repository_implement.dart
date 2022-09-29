import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/posts/data/datasources/post_local_data_source.dart';
import 'package:clean_architecture/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:clean_architecture/features/posts/domain/entities/post.dart';
import 'package:clean_architecture/features/posts/domain/repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';

class PostsRepositoryImplement implements PostsRepository{
final PostRemoteDataSource postRemoteDataSource;
final PostLocalDataSource postLocalDataSource;

  PostsRepositoryImplement(
      {required this.postRemoteDataSource,required this.postLocalDataSource});
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async{
    await postRemoteDataSource.getAllPosts();
    await postLocalDataSource.getCachedPosts();
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) {
    // TODO: implement addPost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }



  @override
  Future<Either<Failure, Unit>> updatePost(Post post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
  
}