import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  
  final String title;
  final int? titleSize;
  final VoidCallback onPressed;
  final bool disabled;
  
  const CustomButtonWidget({ 
    Key? key,
    required this.title,
    this.titleSize,
    required this.onPressed,
    this.disabled = false 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      child: Text(title),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if(states.contains(MaterialState.disabled)) return Colors.red;
          if (states.contains(MaterialState.pressed)) return Colors.blue;

          return Colors.green;
        }),
        shape: MaterialStateProperty.all( // .all para todos os estados
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
        ),
        textStyle: MaterialStateProperty.resolveWith((states) {

          if(states.contains(MaterialState.pressed)) {
            return TextStyle(
              fontSize: titleSize != null ? titleSize! * 2 : 28,
            );
          }

          return TextStyle(
            fontSize: titleSize != null ? titleSize!.toDouble() : 18
          );
        }),
      ),
    );
  }
}