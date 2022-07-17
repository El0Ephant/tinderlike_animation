import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'button_state.dart';

class ButtonCubit extends Cubit<ButtonState> {
  ButtonCubit() : super(ButtonInitial());

  void leftSwipe() => emit(LeftSwipe());
  void rightSwipe() => emit(RightSwipe());
  void upSwipe() => emit(UpSwipe());
}
