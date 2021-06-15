import 'package:flutter/material.dart';

class CustomiconButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final IconData icon;
  const CustomiconButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color = Colors.indigo,
    this.isFilled = false,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          StadiumBorder(),
        ),
        backgroundColor: MaterialStateProperty.all(color.withOpacity(0.5)),
        overlayColor: MaterialStateProperty.all(color.withOpacity(0.3)),
      ),
      onPressed: () => onPressed(),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
