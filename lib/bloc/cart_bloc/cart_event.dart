import 'package:flu_drinks/models/cart_model.dart';

abstract class CartEvent {}

class LoadCart extends CartEvent {}

class GetCartCount extends CartEvent {}

class AddCart extends CartEvent {
  final Cart cart;

  AddCart(this.cart);
  List<Object?> get props => [];
}

class EditCartCount extends CartEvent {
  final Cart cart;
  final String newCount;

  EditCartCount(
    this.cart,
    this.newCount,
  );
  List<Object?> get props => [];
}

class EditCart extends CartEvent {
  final Cart cart;

  EditCart(
    this.cart,
  );
  List<Object?> get props => [];
}

class DeleteCart extends CartEvent {
  final Cart cart;

  DeleteCart(this.cart);
  List<Object?> get props => [];
}

class AddOrder extends CartEvent {
  final List<Cart> carts;

  AddOrder(this.carts);
  List<Object?> get props => [];
}
