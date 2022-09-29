import 'package:clean_architecture/features/posts/domain/repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class DeletePostUseCase{
  final PostsRepository repositories;
  DeletePostUseCase(this.repositories);
  Future<Either<Failure,Unit>> call(int postId)async{
    return await repositories.deletePost(postId);
  }
}