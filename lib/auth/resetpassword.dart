import 'package:chatapp/auth/signin.dart';
import 'package:chatapp/utils/button.dart';
import 'package:chatapp/utils/gradient.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: GradientHelper.backgroundGradient(),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Reset Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins SemiBold",
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          cursorColor: Colors.white,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Poppins SemiBold",
                          ),
                          controller: newPasswordController,
                          keyboardType: TextInputType.text,
                          obscureText: !isPasswordVisible, // Toggle visibility
                          decoration: InputDecoration(
                            hintText: "New Password",
                            prefixIcon: const Icon(Icons.lock_outline,
                                color: Colors.white),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: "Poppins SemiBold",
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your new password";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          cursorColor: Colors.white,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Poppins SemiBold",
                          ),
                          controller: confirmPasswordController,
                          keyboardType: TextInputType.text,
                          obscureText:
                              !isConfirmPasswordVisible, // Toggle visibility
                          decoration: InputDecoration(
                            hintText: "Confirm Password",
                            prefixIcon: const Icon(Icons.lock_outline,
                                color: Colors.white),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  isConfirmPasswordVisible =
                                      !isConfirmPasswordVisible;
                                });
                              },
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: "Poppins SemiBold",
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please confirm your password";
                            }
                            if (value != newPasswordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  MyButton(
                    text: "Reset Password",
                    onPressed: () {
                      if (newPasswordController.text.isNotEmpty &&
                          confirmPasswordController.text.isNotEmpty &&
                          newPasswordController.text ==
                              confirmPasswordController.text) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please enter matching passwords")),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
