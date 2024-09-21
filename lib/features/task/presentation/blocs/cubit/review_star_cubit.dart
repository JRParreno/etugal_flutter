import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewStarCubit extends Cubit<double> {
  ReviewStarCubit() : super(0);

  void onChangeStars(double value) {
    emit(value);
  }
}
