import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/calc_cubit.dart';
import 'screens/form_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalcCubit(),
      child: MaterialApp(
        title: 'Калькулятор кубов суммы',
        debugShowCheckedModeBanner: false,
        home: FormScreen(),
      ),
    );
  }
}
