import 'package:chatapp/callscreen/audiocallscreen.dart';
import 'package:chatapp/utils/chatbubble.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/utils/gradient.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> messages = [
    {
      "text": "Hello!",
      "isSent": false,
      "time": DateTime.now().subtract(Duration(minutes: 5))
    },
    {
      "text": "Hi, how are you?",
      "isSent": true,
      "time": DateTime.now().subtract(Duration(minutes: 4))
    },
    {
      "text": "I'm good. You?",
      "isSent": false,
      "time": DateTime.now().subtract(Duration(minutes: 3))
    },
  ];

  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add({
          "text": _controller.text,
          "isSent": true,
          "time": DateTime.now(),
        });
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: GradientHelper.backgroundGradient(),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.09,
                decoration: BoxDecoration(
                  gradient: GradientHelper.appbarGradient(),
                  border: Border(
                    bottom: BorderSide(
                      color: const Color.fromARGB(255, 29, 148, 218),
                      width: 0.1,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1633332755192-727a05c4013d",
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Salman",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins SemiBold"),
                              ),
                              Text(
                                "Online",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AudioCallingScreen()));
                            },
                            icon: const Icon(Icons.call, color: Colors.white),
                            iconSize: 25,
                          ),
                          // const SizedBox(width: 20),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.videocam,
                                size: 29, color: Colors.white),
                            iconSize: 29,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(
                      message: messages[index]["text"],
                      isSent: messages[index]["isSent"],
                      timestamp: messages[index]["time"],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _controller,
                        cursorColor: Colors.white,
                        textCapitalization: TextCapitalization.sentences,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Poppins SemiBold"),
                        decoration: InputDecoration(
                          hintText: "Type a message",
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontFamily: "Poppins SemiBold"),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.attach_file,
                                color: Colors.grey),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _sendMessage,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: GradientHelper.iconGradient(),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.send, color: Colors.white),
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
