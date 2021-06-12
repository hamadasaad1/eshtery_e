import 'package:elbya3/size_config.dart';
import 'package:elbya3/view/component/custom_svg_.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'custom_text copy.dart';

void changeNavigator(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void changeNavigatorReplacement(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}

Widget textFormFiled({
  @required String label,
  @required IconData preIcon,
  @required Function onChange,
  @required Function validate,
  @required TextInputType type,
  Function tap,
  Widget widget,
  bool obscureText = false,
  @required TextEditingController controller,
}) =>
    TextFormField(
      controller: controller,
      autocorrect: true,
      cursorRadius: const Radius.circular(10),
      keyboardType: type,
      onChanged: onChange,
      obscureText: obscureText,
      validator: validate,
      onTap: tap,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: widget,
        prefixIcon: Icon(preIcon),
        border: const OutlineInputBorder(
          gapPadding: 20,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );

void snackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: KPrimaryColor,
    action: SnackBarAction(
      textColor: Colors.white,
      label: 'Done',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  // Find the ScaffoldMessenger in the widget tree
  // and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class Utils {
  static getSizedBox({double width, double height}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}

buildSVGEmpty({String message}) {
  return Center(
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSvg(
            iconPath: "assets/icons/empty_cart.svg",
            height: getProportionateScreenWidth(200),
            width: getProportionateScreenWidth(200),
          ),
          SizedBox(
            height: 10,
          ),
          CustomText(
            text: message,
            size: 20,
            color: KPrimaryColor,
          )
        ],
      ),
    ),
  );
}
