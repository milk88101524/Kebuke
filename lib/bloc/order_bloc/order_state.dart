abstract class OrderState {
  OrderState();

  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoadSuccess extends OrderState {
  final List orders;

  OrderLoadSuccess(this.orders);

  @override
  List<Object?> get props => [];
}

class OrderLoadFail extends OrderState {
  final String message;

  OrderLoadFail(this.message);

  @override
  List<Object?> get props => [message];
}

class OrderCountLoadSuccess extends OrderState {
  final int count;

  OrderCountLoadSuccess(this.count);

  @override
  List<Object?> get props => [];
}
