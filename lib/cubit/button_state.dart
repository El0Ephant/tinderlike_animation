part of 'button_cubit.dart';

@immutable
abstract class ButtonState {}

class ButtonInitial extends ButtonState {}
class LeftSwipe extends ButtonState {}
class RightSwipe extends ButtonState {}
class UpSwipe extends ButtonState {}