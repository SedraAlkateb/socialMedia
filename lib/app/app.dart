import 'package:untitled11/app/di.dart';

import 'package:flutter/material.dart';
import 'package:untitled11/presentation/home/bloc/home_bloc.dart';
import 'package:untitled11/presentation/post/bloc/post_bloc.dart';
import 'package:untitled11/presentation/resources/routes_manager.dart';
import 'package:untitled11/presentation/resources/them_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled11/presentation/stroy/bloc/story_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>HomeBloc()),
        BlocProvider(create: (_) =>
        instance<PostBloc>()..add(PostsEvent())),
        BlocProvider(create: (_) =>
        instance<StoryBloc>()..add(StoriesEvent())),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.navBar,
        theme: getApplicationTheme(),
      ),
    );
  }
}
