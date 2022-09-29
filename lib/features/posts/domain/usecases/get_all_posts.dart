import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/posts/domain/entities/post.dart';
import 'package:clean_architecture/features/posts/domain/repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';

class GetAllPostsUseCase{
  final PostsRepository repositories;
  GetAllPostsUseCase(this.repositories);
  Future<Either<Failure,List<Post>>> call() async{
    return await repositories.getAllPosts();
  }
}