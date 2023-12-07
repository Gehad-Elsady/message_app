import 'package:flutter/material.dart';
class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.color,
    required this.title,
    required this.onPressed
  }) : super(key: key);
  final String title;
  final Color color;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200,
          height: 42,
          child: Text(title,style: TextStyle(color: Colors.white,fontSize: 20),),
        ),
      ),
    );
  }
}
