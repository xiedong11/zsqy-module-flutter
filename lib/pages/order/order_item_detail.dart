import 'package:flutter/material.dart';
import 'package:flutter_app/entity/order_entity.dart';

class OrderItemDetail extends StatefulWidget {
  OrderEntity orderEntity;

  OrderItemDetail({this.orderEntity});

  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<OrderItemDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('任务详情'),
        centerTitle: true,
      ),
      body: Container(
        child: Text(widget.orderEntity.title),
      ),
    );
  }
}
