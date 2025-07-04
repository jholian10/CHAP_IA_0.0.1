import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chap_event.dart';
part 'chap_state.dart';

class ChapBloc extends Bloc<ChapEvent, ChapState> {
  ChapBloc() : super(ChapInitial()) {
    on<ChapEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
