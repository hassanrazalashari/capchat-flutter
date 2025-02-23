import 'package:flutter/material.dart';
import 'package:chatapp/utils/gradient.dart';

class AudioCallingScreen extends StatelessWidget {
  const AudioCallingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: GradientHelper.backgroundGradient(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 120,
                      backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1633332755192-727a05c4013d",
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Salman",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Calling...",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 50),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  gradient: GradientHelper.appbarGradient(),
                  border: Border(
                    top: BorderSide(
                      color: const Color.fromARGB(255, 29, 148, 218),
                      width: 0.1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: IconButton(
                        icon: const Icon(Icons.volume_up,
                            color: Colors.white, size: 30),
                        onPressed: () {},
                      ),
                    ),
                    // const SizedBox(width: 40),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.call_end,
                            color: Colors.white, size: 30),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    // const SizedBox(width: 40),
                    Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: IconButton(
                        icon: const Icon(Icons.mic_off,
                            color: Colors.white, size: 30),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
