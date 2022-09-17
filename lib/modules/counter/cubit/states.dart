import 'package:udemeabdallahmansor/modules/counter/cubit/states.dart';

abstract class CounterStates {}

class CounterInitialState extends CounterStates {}

class CounterPlusState extends CounterStates
{
  final int counter;

  CounterPlusState(this.counter);
}

class CounterMinusState extends CounterStates
{
  final int counter;

  CounterMinusState(this.counter);
}