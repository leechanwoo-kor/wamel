import 'package:flutter/material.dart';

TextStyle lTextStyle({
  required Color color,
  required double size,
  required bool bold,
}) {
  size ??= 14;
  bold ??= false;
  color ??= Colors.black;
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
  );
}

Widget lText(
  String text, {
  required Color color,
  required double size,
  required bool bold,
  required TextOverflow overflow,
}) {
  size ??= 14;
  bold ??= false;
  color ??= Colors.black;
  return Text(
    '$text',
    overflow: overflow,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    ),
  );
}

Widget lHeight(double height) {
  height ??= 10;
  return SizedBox(height: height);
}

Widget lWidth(double width) {
  width ??= 10;
  return SizedBox(width: width);
}

Widget lBlank() {
  return Container();
}

Widget lExpanded({required int flex, required Widget child}) {
  flex ??= 1;
  child ??= Container();
  return Expanded(flex: flex, child: Center(child: child));
}

Widget lTextField({
  required String hintText,
  required double padding,
  required Function(String) onChanged,
  required Function(String) onSubmitted,
  required TextInputType keyboardType,
}) {
  hintText ??= '입력해 주세요...';
  padding ??= 10;
  onChanged ??= (_) {};
  onSubmitted ??= (_) {};
  keyboardType ??= TextInputType.number;
  return Container(
    child: TextField(
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(padding),
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    ),
  );
}

Widget lButton(
  String text, {
  required void Function() onTap,
  required double height,
  required double fontSize,
  required double width,
  required double radius,
  required Color colorText,
  required Color colorBg,
}) {
  height ??= 30;
  width ??= height * 2 / 0.7;
  radius ??= height / 2;
  fontSize ??= 14;
  colorText ??= Colors.black;
  colorBg ??= Colors.grey[100]!;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: colorBg,
          borderRadius: BorderRadiusDirectional.all(Radius.circular(radius))),
      child: lText(text,
          color: colorText,
          size: fontSize,
          bold: true,
          overflow: TextOverflow.clip),
    ),
  );
}

Widget lIconButton(
  IconData icon, {
  required double size,
  required Color color,
  required Function onTap,
}) {
  size ??= 36;
  color ??= Colors.white;
  return IconButton(
    iconSize: size,
    icon: Icon(
      icon,
      size: size,
      color: color,
    ),
    onPressed: onTap as void Function()?,
  );
}
