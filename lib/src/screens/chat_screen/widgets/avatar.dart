import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double radius;
  final String imgUrl;
  const Avatar({super.key, required this.radius, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: CircleAvatar(
        radius: radius - 2,
        backgroundImage: NetworkImage(imgUrl),
      ),
    );
  }
}

