import 'package:flu_drinks/bloc/drink_update_bloc/drink_update_event.dart';
import 'package:flu_drinks/bloc/drink_update_bloc/drink_update_state.dart';
import 'package:flu_drinks/models/drink_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrinkUpdateBloc extends Bloc<DrinkUpdateEvent, DrinkUpdateState> {
  final Drink drink;

  DrinkUpdateBloc(this.drink, {DrinkUpdateState? initState})
      : super(initState ??
            DrinkUpdateState(
              price: drink.price.M,
              size: "M",
              sweetness: "正常糖",
              ice: "正常冰",
              whiteBubble: "false",
              whiteJelly: "false",
              sweetAlmond: "false",
              count: 1,
            )) {
    on<UpdateSize>((event, emit) {
      int basePrice = event.size == "M" ? drink.price.M : drink.price.L;
      int updatedPrice = _calculateTotalPrice(
        basePrice: basePrice,
        state: state,
      );
      emit(state.copyWith(size: event.size, price: updatedPrice));
    });

    on<UpdateSweetness>((event, emit) {
      emit(state.copyWith(sweetness: event.sweetness));
    });

    on<UpdateIce>((event, emit) {
      emit(state.copyWith(ice: event.ice));
    });

    on<UpdateWhiteBubble>((event, emit) {
      int basePrice = state.size == "M" ? drink.price.M : drink.price.L;
      int updatedPrice = _calculateTotalPrice(
        basePrice: basePrice,
        state: state.copyWith(whiteBubble: event.whiteBubble),
      );
      emit(state.copyWith(whiteBubble: event.whiteBubble, price: updatedPrice));
    });

    on<UpdateWhiteJelly>((event, emit) {
      int basePrice = state.size == "M" ? drink.price.M : drink.price.L;
      int updatedPrice = _calculateTotalPrice(
        basePrice: basePrice,
        state: state.copyWith(whiteJelly: event.whiteJelly),
      );
      emit(state.copyWith(whiteJelly: event.whiteJelly, price: updatedPrice));
    });

    on<UpdateSweetAlmond>((event, emit) {
      int basePrice = state.size == "M" ? drink.price.M : drink.price.L;
      int updatedPrice = _calculateTotalPrice(
        basePrice: basePrice,
        state: state.copyWith(sweetAlmond: event.sweetAlmond),
      );
      emit(state.copyWith(sweetAlmond: event.sweetAlmond, price: updatedPrice));
    });

    on<Increment>((event, emit) {
      int count = event.count + 1;
      emit(state.copyWith(count: count));
    });

    on<Decrement>((event, emit) {
      int count = event.count - 1;
      if (count <= 0) {
        emit(state.copyWith(count: 1));
      } else {
        emit(state.copyWith(count: count));
      }
    });
  }

  int _calculateTotalPrice({
    required int basePrice,
    required DrinkUpdateState state,
  }) {
    int extraPrice = 0;

    if (state.whiteBubble == "true") {
      extraPrice += 10;
    }
    if (state.whiteJelly == "true") {
      extraPrice += 10;
    }
    if (state.sweetAlmond == "true") {
      extraPrice += 15;
    }

    return basePrice + extraPrice;
  }
}
