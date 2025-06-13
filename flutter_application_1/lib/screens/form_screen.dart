import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/calc_cubit.dart';
import '../cubit/calc_state.dart';
import 'result_screen.dart';
import 'history_screen.dart';

class FormScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalcCubit, CalcState>(
      builder: (context, state) {
        if (state is CalcResult) {
          return ResultScreen(result: state.result);
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Калькулятор'),
            leading: IconButton(
              icon: Icon(Icons.history),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HistoryScreen()),
                );
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Число A'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) =>
                        context.read<CalcCubit>().updateA(value),
                    validator: (value) => int.tryParse(value ?? '') == null
                        ? 'Введите число'
                        : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Число B'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) =>
                        context.read<CalcCubit>().updateB(value),
                    validator: (value) => int.tryParse(value ?? '') == null
                        ? 'Введите число'
                        : null,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: context.read<CalcCubit>().agreed,
                        onChanged: (value) => context
                            .read<CalcCubit>()
                            .setAgreement(value ?? false),
                      ),
                      Text('Согласие на обработку'),
                    ],
                  ),
                  if (state is CalcFormInvalid)
                    Text(state.message, style: TextStyle(color: Colors.red)),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<CalcCubit>().calculate();
                      }
                    },
                    child: Text('Рассчитать'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
