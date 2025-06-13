import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'calc_state.dart';

class CalcCubit extends Cubit<CalcState> {
  CalcCubit() : super(CalcInitial());

  int? a, b;
  bool agreed = false;

  void updateA(String value) {
    a = int.tryParse(value);
  }

  void updateB(String value) {
    b = int.tryParse(value);
  }

  void setAgreement(bool value) {
    agreed = value;
  }

  Future<void> calculate() async {
    if (a == null || b == null) {
      emit(CalcFormInvalid("Введите корректные числа"));
      return;
    }
    if (!agreed) {
      emit(CalcFormInvalid("Подтвердите согласие"));
      return;
    }

    final result = (a! + b!) * (a! + b!) * (a! + b!);
    await _saveResult(a!, b!, result);
    emit(CalcResult(result));
  }

  void reset() {
    emit(CalcInitial());
  }

  Future<void> _saveResult(int a, int b, int result) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('history') ?? [];
    final newEntry = 'a: $a, b: $b, (a+b)^3 = $result';
    list.add(newEntry);
    await prefs.setStringList('history', list);
  }
}
