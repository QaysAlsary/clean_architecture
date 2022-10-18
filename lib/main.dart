import 'package:clean_architecture/core/app_theme.dart';
import 'package:clean_architecture/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=> di.sl<PostsBloc>()),
        BlocProvider(create: (_)=>di.sl<AddDeleteUpdatePostBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme:appTheme ,
      title: 'Posts App  ',
      home: Scaffold(appBar:
      AppBar(
        title: Text('Posts App Bar'),

      ),
        body: Center(
          child: Container(
            child: Text('Hello World '),
          ),
        ),
      ),
      ),
    );
  }
}