import 'package:flutter/material.dart';

class TenDollarIcon extends StatelessWidget {
  final double size;

  const TenDollarIcon({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Text(
              '10',
              style: TextStyle(
                color: Colors.red,
                fontSize: size * 0.4,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Text(
              'dollar',
              style: TextStyle(
                color: Colors.red,
                fontSize: size * 0.3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
