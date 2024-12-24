import 'package:flu_drinks/models/cart_model.dart';

abstract class CartState {
  CartState();

  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoadSuccess extends CartState {
  final List<Cart> carts;

  CartLoadSuccess(this.carts);

  @override
  List<Object?> get props => [];
}

class CartLoadFail extends CartState {
  final String message;

  CartLoadFail(this.message);

  @override
  List<Object?> get props => [message];
}

class CartCountLoadSuccess extends CartState {
  final int count;

  CartCountLoadSuccess(this.count);

  @override
  List<Object?> get props => [];
}

class CartAddCartSuccess extends CartState {
  final String message;

  CartAddCartSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CartAddCartFail extends CartState {
  final String message;

  CartAddCartFail(this.message);

  @override
  List<Object?> get props => [message];
}

class CartEditCartSuccess extends CartState {
  final String message;

  CartEditCartSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CartEditCartFail extends CartState {
  final String message;

  CartEditCartFail(this.message);

  @override
  List<Object?> get props => [message];
}

class CartDeleteCartSuccess extends CartState {
  final String message;

  CartDeleteCartSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CartDeleteCartFail extends CartState {
  final String message;

  CartDeleteCartFail(this.message);

  @override
  List<Object?> get props => [message];
}

class CartAddOrderSuccess extends CartState {
  final String message;

  CartAddOrderSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CartAddOrderFail extends CartState {
  final String message;

  CartAddOrderFail(this.message);

  @override
  List<Object?> get props => [message];
}
