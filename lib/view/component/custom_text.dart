import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final double height ;
  final Color color ;


  CustomText({@required this.text,this.size,this.height=1,this.color
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,

      style: Theme.of(context).textTheme.bodyText1.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: size,
        height: height
          ,color: color
      ),
    );
  }
}
