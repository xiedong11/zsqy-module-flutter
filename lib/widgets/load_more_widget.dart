import 'package:flutter/material.dart';

class LoadMoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Row(
            children: <Widget>[
              new CircularProgressIndicator(),
              Padding(padding: EdgeInsets.all(10)),
              Text('加载中...')
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
      color: Colors.white70,
    );
  }
}
