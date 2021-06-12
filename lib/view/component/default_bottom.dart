import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

//genral buttom use in any war
class DefaultButton extends StatelessWidget {
   DefaultButton({
    this.text,
    this.press,
    this.color=KPrimaryColor,
    this.width = double.infinity,
  });
  final String text;
  final double width;
  final Function press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: getProportionateScreenHeight(56),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            primary: color,
          ),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(18), color: Colors.white),
          )),
    );
  }
}
