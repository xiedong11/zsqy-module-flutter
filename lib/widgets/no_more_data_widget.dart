import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class NoMoreDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Text('当前列表到底了...'),
        ),
      ),
      color: Colors.white70,
    );
  }
}
