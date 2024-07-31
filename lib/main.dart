// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:math';

import 'package:ass2/sign_up.dart';
import 'package:ass2/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit.dart';
import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit_App()
        ..create_data()
        ..get_postion(),
      child: BlocConsumer<cubit_App, states_App>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: signUp(),
            );
          }),
    );
  }
}
