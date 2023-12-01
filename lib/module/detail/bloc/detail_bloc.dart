import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera_test/common/models/product_model.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvents, DetailState> {
  DetailBloc() : super(const DetailState());
}
