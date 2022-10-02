import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/features/posts/data/datasources/post_local_data_source.dart';
import 'package:clean_architecture/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:clean_architecture/features/posts/data/models/post_model.dart';
import 'package:clean_architecture/features/posts/domain/entities/post.dart';
import 'package:clean_architecture/features/posts/domain/repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';
typedef Future<Unit> DeleteOrUpdateOrAddPost();

class PostsRepositoryImplement implements PostsRepository{
final PostRemoteDataSource postRemoteDataSource;
final PostLocalDataSource postLocalDataSource;
final NetworkInfo networkInfo;

  PostsRepositoryImplement(
      {required this.postRemoteDataSource,required this.postLocalDataSource,required this.networkInfo});
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async{
    if(await networkInfo.isConected)
      {
        try{
         final remotePosts = await postRemoteDataSource.getAllPosts();
         postLocalDataSource.cachePosts(remotePosts);
         return Right(remotePosts);
        }on ServerException
        {
          return Left(ServerFailure());
        }
      } else
        {
          try{
         final localPosts = await postLocalDataSource.getCachedPosts();
         return Right(localPosts);
          }on EmptyCacheException
          {
            return Left(EmptyCacheFailure());
          }
        }


  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async{
    final PostModel postModel = PostModel(id: post.id, title: post.title, body: post.body);
    return _getMessage(()
    {
      return postRemoteDataSource.addPost(postModel);
    }
    );
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId)async {
    return _getMessage(()
    {
      return postRemoteDataSource.deletePost(postId);
    }
    );
  }



  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async{
    final PostModel postModel = PostModel(id: post.id, title: post.title, body: post.body);
    return _getMessage(()
    {
      return postRemoteDataSource.updatePost(postModel);
    }
    );
  }
  Future<Either<Failure,Unit>> _getMessage(DeleteOrUpdateOrAddPost operation) async
  {
    if(await networkInfo.isConected)
    {
      try
      {
        await operation();
        return const Right(unit);
      }on ServerException
      {
        return Left(ServerFailure());
      }
    }else
    {
      return Left(OffLineFailure());
    }
  }
  
}