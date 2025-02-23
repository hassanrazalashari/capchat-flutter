import 'package:chatapp/chat/chatscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/utils/gradient.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  // Mock data - replace with your actual data source
  final List<Map<String, String>> contacts = const [
    {
      'name': 'Hassan Raza',
      'email': 'hassanrazalasahri001@yahoo.com',
      'image': 'https://randomuser.me/api/portraits/men/1.jpg'
    },
    {
      'name': 'Asim Raza',
      'email': 'asimrazaa2005@gmail.com',
      'image': 'https://randomuser.me/api/portraits/men/2.jpg'
    },
    {
      "name": "Ali Ahmed",
      "email": "ali.ahmed@example.com",
      "image": "https://randomuser.me/api/portraits/men/3.jpg"
    },
    {
      "name": "Fatima Khan",
      "email": "fatima.khan@example.com",
      "image": "https://randomuser.me/api/portraits/women/4.jpg"
    },
    {
      "name": "Omar Malik",
      "email": "omar.malik@example.com",
      "image": "https://randomuser.me/api/portraits/men/5.jpg"
    }
  ];

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
              _buildAppBar(),
              Expanded(
                child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final contact = contacts[index];
                    return _buildContactTile(context, contact);
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  // AppBar Widget
  Widget _buildAppBar() {
    return Container(
      width: double.infinity,
      height: 70,
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Contacts",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins SemiBold",
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Contact ListTile Widget
  Widget _buildContactTile(BuildContext context, Map<String, String> contact) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade600,
            width: 0.1,
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(contact['image']!),
        ),
        title: Text(
          contact['name']!,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins SemiBold",
          ),
        ),
        subtitle: Text(
          contact['email']!,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontFamily: "Poppins Medium",
          ),
        ),
        trailing: Icon(
          CupertinoIcons.conversation_bubble,
          color: Colors.grey.shade400,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen()),
          );
        },
      ),
    );
  }

  // Floating Action Button
  Widget _buildFloatingActionButton() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: GradientHelper.iconGradient(),
      ),
      child: FloatingActionButton(
        onPressed: () {
          // TODO: Implement new chat functionality
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Icon(
          CupertinoIcons.add,
          size: 28,
          color: Colors.white,
        ),
      ),
    );
  }
}
