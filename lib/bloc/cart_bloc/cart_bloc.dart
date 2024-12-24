import 'package:flu_drinks/bloc/cart_bloc/cart_event.dart';
import 'package:flu_drinks/bloc/cart_bloc/cart_state.dart';
import 'package:flu_drinks/models/api_manager.dart';
import 'package:flu_drinks/models/cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<Cart> carts = [];

  CartBloc() : super(CartInitial()) {
    on<LoadCart>(_loadCart);
    on<GetCartCount>(_getCartCount);
    on<AddCart>(_addCart);
    on<EditCartCount>(_editCartCount);
    on<EditCart>(_editCart);
    on<DeleteCart>(_deleteCart);
    on<AddOrder>(_addOrder);
  }

  Future<void> _loadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());

    try {
      carts = await fetchCart();
      emit(CartLoadSuccess(carts));
    } catch (e) {
      emit(CartLoadFail(e.toString()));
    }
  }

  Future<void> _getCartCount(
      GetCartCount event, Emitter<CartState> emit) async {
    int count = 0;
    emit(CartLoading());

    try {
      count = await getCartCount();
      emit(CartCountLoadSuccess(count));
    } catch (e) {
      emit(CartLoadFail(e.toString()));
    }
  }

  Future<void> _addCart(AddCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      await addCart(event.cart);
      emit(CartAddCartSuccess("Successful"));
    } catch (e) {
      print(e.toString());
      emit(CartAddCartFail(e.toString()));
    }
  }

  Future<void> _editCartCount(
      EditCartCount event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      await editCartCount(event.cart.id, event.newCount);
      // 本地更新 carts 列表
      int index = carts.indexWhere((cart) => cart.id == event.cart.id);
      if (index != -1) {
        carts[index] = event.cart.copyWith(count: event.newCount);
      }
      emit(CartEditCartSuccess("Successful"));
      // 重新觸發成功狀態以更新 UI
      emit(CartLoadSuccess(carts));
    } catch (e) {
      emit(CartEditCartFail(e.toString()));
    }
  }

  Future<void> _editCart(EditCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      carts = await fetchCart();
      await editCart(event.cart);
      // 本地更新 carts 列表
      int index = carts.indexWhere((cart) => cart.id == event.cart.id);

      if (index != -1) {
        carts[index] = event.cart.copyWith(
          size: event.cart.size,
          sweetness: event.cart.sweetness,
          ice: event.cart.ice,
          count: event.cart.count,
          whiteBubble: event.cart.whiteBubble,
          whiteJelly: event.cart.whiteJelly,
          sweetAlmond: event.cart.sweetAlmond,
          price: event.cart.price,
        );
      }
      emit(CartEditCartSuccess("Successful"));
      emit(CartLoadSuccess(carts));
    } catch (e) {
      emit(CartEditCartFail(e.toString()));
    }
  }

  Future<void> _deleteCart(DeleteCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      await deleteCart(event.cart.id);
      // 本地更新 carts 列表
      carts.removeWhere((cart) => cart.id == event.cart.id); // 刪除對應的 cart
      emit(CartDeleteCartSuccess("Successful"));
      // 重新觸發成功狀態以更新 UI
      emit(CartLoadSuccess(carts));
    } catch (e) {
      emit(CartDeleteCartFail(e.toString()));
    }
  }

  Future<void> _addOrder(AddOrder event, Emitter<CartState> emit) async {
    try {
      await addOrder(event.carts);
      emit(CartAddOrderSuccess("Successful"));
    } catch (e) {
      emit(CartAddOrderFail(e.toString()));
    }
  }
}
