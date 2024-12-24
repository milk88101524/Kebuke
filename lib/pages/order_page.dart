import 'package:flu_drinks/bloc/order_bloc/order_bloc.dart';
import 'package:flu_drinks/bloc/order_bloc/order_event.dart';
import 'package:flu_drinks/bloc/order_bloc/order_state.dart';
import 'package:flu_drinks/components/app_color.dart';
import 'package:flu_drinks/components/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderBloc>(
      create: (context) => OrderBloc(),
      child: OrderPageView(),
    );
  }
}

class OrderPageView extends StatelessWidget {
  const OrderPageView({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OrderBloc>(context).add(LoadOrder());

    return Scaffold(
      backgroundColor: colorBG,
      appBar: AppBar(
        backgroundColor: colorBG,
        foregroundColor: colorAccent,
      ),
      body: BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
        if (state is OrderLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is OrderLoadSuccess) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return OrderCard(
                cart: state.orders[index],
              );
            },
            itemCount: state.orders.length,
          );
        } else if (state is OrderLoadFail) {
          return Center(
            child: Text(state.message),
          );
        }
        return SizedBox.shrink();
      }),
    );
  }
}
