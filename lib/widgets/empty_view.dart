import 'package:flutter/material.dart';

/**
 * 页面加载loading过渡页
 */
class EmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.deepOrange),
        ),
      ),
    );
  }
}
