import 'package:chatapp/utils/gradient.dart';
import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final String text;
  final Function()? onPressed;

  const MyButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: widget.onPressed,
        child: Container(
          height: MediaQuery.of(context).size.height / 15,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 89, 85, 85),
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(20),
            gradient: GradientHelper.buttonGradient(),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins SemiBold",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
