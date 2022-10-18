import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/features/posts/data/datasources/post_local_data_source.dart';
import 'package:clean_architecture/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:clean_architecture/features/posts/data/models/post_model.dart';
import 'package:clean_architecture/features/posts/data/repositories/post_repository_implement.dart';
import 'package:clean_architecture/features/posts/domain/repositories/posts_repositories.dart';
import 'package:clean_architecture/features/posts/domain/usecases/add_post.dart';
import 'package:clean_architecture/features/posts/domain/usecases/delete_post.dart';
import 'package:clean_architecture/features/posts/domain/usecases/get_all_posts.dart';
import 'package:clean_architecture/features/posts/domain/usecases/update_post.dart';
import 'package:clean_architecture/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart'as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> init()async{
   final sharedPreferences = await SharedPreferences.getInstance();
  /// Features  posts


  //Bloc
sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
sl.registerFactory(() => AddDeleteUpdatePostBloc(
    addPost: sl(),
    updatePost: sl(),
    deletePost: sl()));



  //UseCases
sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
sl.registerLazySingleton(() => AddPostUseCase(sl()));
sl.registerLazySingleton(() => DeletePostUseCase(sl()));
sl.registerLazySingleton(() => UpdatePostUseCase(sl()));


  //Repository
sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImplement(
    postRemoteDataSource: sl(),
    postLocalDataSource: sl(),
    networkInfo: sl()));
  //DataSources
sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(client: sl()));
sl.registerLazySingleton<PostLocalDataSource>(() => PostLocalDataSourceImpl(sharedPreferences: sl()));
  ///Core
sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  ///External
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}