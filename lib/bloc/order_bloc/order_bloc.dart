import 'package:flu_drinks/bloc/order_bloc/order_event.dart';
import 'package:flu_drinks/bloc/order_bloc/order_state.dart';
import 'package:flu_drinks/models/api_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  List orders = [];

  OrderBloc() : super(OrderInitial()) {
    on<LoadOrder>(_loadOrder);
    on<GetOrderCount>(_getOrderCount);
  }

  Future<void> _loadOrder(LoadOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading());

    try {
      orders = await fetchOrder();
      emit(OrderLoadSuccess(orders));
    } catch (e) {
      emit(OrderLoadFail(e.toString()));
    }
  }

  Future<void> _getOrderCount(
      GetOrderCount event, Emitter<OrderState> emit) async {
    int count = 0;
    emit(OrderLoading());

    try {
      count = await getOrderCount();
      emit(OrderCountLoadSuccess(count));
    } catch (e) {
      emit(OrderLoadFail(e.toString()));
    }
  }
}
