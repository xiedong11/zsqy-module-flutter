import 'package:flutter/material.dart';

//多彩标签
class ColorLabel extends StatelessWidget {
  final String label;
  final Color color;
  ColorLabel(this.label,this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: this.color,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Text(
        '${this.label}',
        style: TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }
}
