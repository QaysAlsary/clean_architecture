import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/posts/domain/entities/post.dart';
import 'package:clean_architecture/features/posts/domain/repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';

class AddPostUseCase{
  final PostsRepositories repositories;
  AddPostUseCase(this.repositories);
  Future<Either<Failure,Unit>> call(Post post)async {
    return await repositories.addPost(post);
  }
}