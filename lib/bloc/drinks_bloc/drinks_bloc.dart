import 'package:flu_drinks/bloc/drinks_bloc/drinks_event.dart';
import 'package:flu_drinks/bloc/drinks_bloc/drinks_state.dart';
import 'package:flu_drinks/models/api_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrinksBloc extends Bloc<DrinksEvent, DrinksState> {
  List menu = [];

  DrinksBloc() : super(DrinkInitial()) {
    on<LoadDrink>(_loadMenu);
  }

  Future<void> _loadMenu(LoadDrink event, Emitter<DrinksState> emit) async {
    emit(DrinkLoading());

    try {
      menu = await showGitMenu();
      emit(DrinkLoadSuccess(menu));
    } catch (e) {
      emit(DrinkLoadFail(e.toString()));
    }
  }
}
