// import 'package:chatapp/callscreen/audiocallscreen.dart';
// import 'package:chatapp/utils/chatbubble.dart';
// import 'package:flutter/material.dart';
// import 'package:chatapp/utils/gradient.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final List<Map<String, dynamic>> messages = [
//     {
//       "text": "Hello!",
//       "isSent": false,
//       "time": DateTime.now().subtract(Duration(minutes: 5))
//     },
//     {
//       "text": "Hi, how are you?",
//       "isSent": true,
//       "time": DateTime.now().subtract(Duration(minutes: 4))
//     },
//     {
//       "text": "I'm good. You?",
//       "isSent": false,
//       "time": DateTime.now().subtract(Duration(minutes: 3))
//     },
//   ];

//   final TextEditingController _controller = TextEditingController();

//   void _sendMessage() {
//     if (_controller.text.isNotEmpty) {
//       setState(() {
//         messages.add({
//           "text": _controller.text,
//           "isSent": true,
//           "time": DateTime.now(),
//         });
//       });
//       _controller.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           decoration: BoxDecoration(
//             gradient: GradientHelper.backgroundGradient(),
//           ),
//           child: Column(
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: MediaQuery.of(context).size.height * 0.09,
//                 decoration: BoxDecoration(
//                   gradient: GradientHelper.appbarGradient(),
//                   border: Border(
//                     bottom: BorderSide(
//                       color: const Color.fromARGB(255, 29, 148, 218),
//                       width: 0.1,
//                     ),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 22,
//                             backgroundImage: NetworkImage(
//                               "https://images.unsplash.com/photo-1633332755192-727a05c4013d",
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Salman",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: "Poppins SemiBold"),
//                               ),
//                               Text(
//                                 "Online",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           AudioCallingScreen()));
//                             },
//                             icon: const Icon(Icons.call, color: Colors.white),
//                             iconSize: 25,
//                           ),
//                           // const SizedBox(width: 20),
//                           IconButton(
//                             onPressed: () {},
//                             icon: const Icon(Icons.videocam,
//                                 size: 29, color: Colors.white),
//                             iconSize: 29,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     return ChatBubble(
//                       message: messages[index]["text"],
//                       isSent: messages[index]["isSent"],
//                       timestamp: messages[index]["time"],
//                     );
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         controller: _controller,
//                         cursorColor: Colors.white,
//                         textCapitalization: TextCapitalization.sentences,
//                         style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontFamily: "Poppins SemiBold"),
//                         decoration: InputDecoration(
//                           hintText: "Type a message",
//                           hintStyle: const TextStyle(
//                               color: Colors.grey,
//                               fontSize: 14,
//                               fontFamily: "Poppins SemiBold"),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(25),
//                             borderSide: const BorderSide(color: Colors.white),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(25),
//                             borderSide: const BorderSide(color: Colors.white),
//                           ),
//                           suffixIcon: IconButton(
//                             icon: const Icon(Icons.attach_file,
//                                 color: Colors.grey),
//                             onPressed: () {},
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     GestureDetector(
//                       onTap: _sendMessage,
//                       child: Container(
//                         width: 50,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           gradient: GradientHelper.iconGradient(),
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(Icons.send, color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:just_audio/just_audio.dart';
import 'package:chatapp/utils/chatbubble.dart';
import 'package:chatapp/utils/gradient.dart';
import 'package:chatapp/callscreen/audiocallscreen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> messages = [];
  final TextEditingController _controller = TextEditingController();
  FlutterSoundRecorder? _recorder;
  final AudioPlayer _player = AudioPlayer();
  bool _isRecording = false;
  String? _audioPath;

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    _recorder = FlutterSoundRecorder();
    await _recorder!.openRecorder();

    var status = await Permission.microphone.request();
    if (!status.isGranted) {
      print("Microphone permission not granted!");
    }
  }

  Future<void> _startRecording() async {
    try {
      Directory tempDir = await getApplicationDocumentsDirectory();
      String filePath = '${tempDir.path}/recorded_audio.aac';

      await _recorder!.startRecorder(
        toFile: filePath,
        codec: Codec.aacADTS, // More compatible format
      );

      setState(() {
        _isRecording = true;
        _audioPath = filePath;
      });
    } catch (e) {
      print("Error starting recorder: $e");
    }
  }

  Future<void> _stopRecordingAndSend() async {
    try {
      String? filePath = await _recorder!.stopRecorder();
      setState(() {
        _isRecording = false;
      });

      if (filePath != null) {
        messages.add({
          "text": null,
          "isSent": true,
          "audio": filePath,
          "time": DateTime.now(),
        });
        setState(() {});
      }
    } catch (e) {
      print("Error stopping recorder: $e");
    }
  }

  Future<void> _playAudio(String path) async {
    try {
      await _player.setFilePath(path);
      _player.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add({
          "text": _controller.text,
          "isSent": true,
          "time": DateTime.now(),
          "audio": null,
        });
      });
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _recorder?.closeRecorder();
    _player.dispose();
    super.dispose();
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
              _buildChatHeader(),
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return messages[index]["audio"] != null
                        ? _buildAudioMessage(messages[index])
                        : ChatBubble(
                            message: messages[index]["text"],
                            isSent: messages[index]["isSent"],
                            timestamp: messages[index]["time"],
                          );
                  },
                ),
              ),
              _buildMessageInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatHeader() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.09,
      decoration: BoxDecoration(
        gradient: GradientHelper.appbarGradient(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1633332755192-727a05c4013d",
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Salman",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
                            builder: (context) => const AudioCallingScreen()));
                  },
                  icon: const Icon(Icons.call, color: Colors.white),
                  iconSize: 25,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.videocam, size: 29, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _controller,
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Type a message",
                hintStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _controller.text.isEmpty ? null : _sendMessage,
            onLongPress: _startRecording,
            onLongPressEnd: (details) async => await _stopRecordingAndSend(),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: GradientHelper.iconGradient(),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _controller.text.isEmpty ? Icons.mic : Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioMessage(Map<String, dynamic> message) {
    return Align(
      alignment:
          message["isSent"] ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: message["isSent"] ? Colors.blue : Colors.grey[800],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.audiotrack, color: Colors.white),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () => _playAudio(message["audio"]),
              child:
                  const Icon(Icons.play_arrow, color: Colors.white, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}
