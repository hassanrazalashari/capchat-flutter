import 'package:flutter/material.dart';
import 'package:chatapp/utils/gradient.dart';

class AudioCallingScreen extends StatefulWidget {
  const AudioCallingScreen({super.key});

  @override
  State<AudioCallingScreen> createState() => _AudioCallingScreenState();
}

class _AudioCallingScreenState extends State<AudioCallingScreen> {
  bool _isMicOn = true;
  bool _isSpeakerOn = false;

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
                    const Text(
                      "Salman",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Calling...",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
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
                        icon: Icon(
                          _isSpeakerOn ? Icons.volume_up : Icons.volume_off,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            _isSpeakerOn = !_isSpeakerOn;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
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
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: IconButton(
                        icon: Icon(
                          _isMicOn ? Icons.mic : Icons.mic_off,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            _isMicOn = !_isMicOn;
                          });
                        },
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
