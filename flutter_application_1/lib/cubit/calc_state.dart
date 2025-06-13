abstract class CalcState {}

class CalcInitial extends CalcState {}

class CalcFormInvalid extends CalcState {
  final String message;
  CalcFormInvalid(this.message);
}

class CalcResult extends CalcState {
  final int result;
  CalcResult(this.result);
}
