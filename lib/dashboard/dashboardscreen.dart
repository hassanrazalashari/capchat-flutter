import 'package:chatapp/dashboard/callsscreen.dart';
import 'package:chatapp/dashboard/chatsscreen.dart';
import 'package:chatapp/dashboard/statusscreen.dart';
import 'package:chatapp/utils/gradient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Main Dashboard Screen
class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  bool _isSearching = false;
  final FocusNode _searchFocusNode = FocusNode();
  int _currentIndex = 0; // Track the current screen index
  final PageController _pageController =
      PageController(); // Controller for PageView

  // Key to get the position of the more_vert icon.
  final GlobalKey _moreVertKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _searchFocusNode.removeListener(_onFocusChange);
    _searchFocusNode.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_searchFocusNode.hasFocus) {
      setState(() {
        _isSearching = false;
      });
    }
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (_isSearching) {
        _searchFocusNode.requestFocus();
      } else {
        _searchFocusNode.unfocus();
      }
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  // Show the custom gradient popup menu.
  void _showGradientMenu() async {
    // Get the position of the more_vert icon.
    final RenderBox button =
        _moreVertKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final Offset offset = button.localToGlobal(Offset.zero, ancestor: overlay);

    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + button.size.height,
        offset.dx + button.size.width,
        offset.dy,
      ),
      // We wrap all menu items in a single PopupMenuItem so we can add a gradient background.
      items: [
        PopupMenuItem(
          enabled: false,
          child: Container(
            decoration: BoxDecoration(
              gradient: GradientHelper.appbarGradient(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Settings item
                InkWell(
                  borderRadius: BorderRadius.circular(30),
                  hoverColor: Colors.grey.shade900,
                  focusColor: Colors.grey.shade900,
                  splashColor: Colors.grey.shade900,
                  onTap: () {
                    Navigator.pop(context, 'settings');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ListTile(
                      leading: Icon(Icons.settings, color: Colors.white),
                      title: Text("Settings",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                // Logout item
                InkWell(
                  borderRadius: BorderRadius.circular(30),
                  hoverColor: Colors.grey.shade900,
                  focusColor: Colors.grey.shade900,
                  splashColor: Colors.grey.shade900,
                  onTap: () {
                    Navigator.pop(context, 'logout');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ListTile(
                      leading: Icon(Icons.logout, color: Colors.red),
                      title:
                          Text("Logout", style: TextStyle(color: Colors.red)),
                    ),
                  ),
                ),
                // Add any additional menu items below as needed.
              ],
            ),
          ),
        ),
      ],
      // Set color transparent so our container’s gradient shows.
      color: Colors.transparent,
      elevation: 0,
    );

    if (result != null) {
      if (result == 'logout') {
        // Handle logout action here.
      } else if (result == 'settings') {
        // Navigate to settings screen or perform settings action.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            gradient: GradientHelper.backgroundGradient(),
          ),
          child: Column(
            children: [
              Visibility(
                visible: !_isSearching,
                child: Container(
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
                        Text(
                          "CapChat",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins SemiBold",
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.search_outlined,
                                  color: Colors.white),
                              onPressed: _toggleSearch,
                            ),
                            // const SizedBox(width: 0),
                            // Changed the more_vert icon into an IconButton with a custom onPressed.
                            IconButton(
                              key: _moreVertKey,
                              icon: Icon(Icons.more_vert, color: Colors.white),
                              onPressed: _showGradientMenu,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _isSearching,
                child: Container(
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
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                cursorColor: Colors.white,
                                focusNode: _searchFocusNode,
                                decoration: InputDecoration(
                                  hintText: "Search...",
                                  hintStyle: TextStyle(color: Colors.white54),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: "Poppins SemiBold",
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.white),
                              onPressed: _toggleSearch,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  children: const [
                    ChatsScreen(), // Chats Screen
                    StatusScreen(), // Status Screen
                    CallsScreen(), // Calls Screen
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.09,
                decoration: BoxDecoration(
                  gradient: GradientHelper.bottomnavigationbarGradient(),
                  border: Border(
                    top: BorderSide(
                      color: const Color.fromARGB(255, 29, 148, 218),
                      width: 0.1,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: _currentIndex == 0
                            ? ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return GradientHelper.iconGradient()
                                      .createShader(bounds);
                                },
                                child: Icon(
                                  CupertinoIcons.chat_bubble,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              )
                            : Icon(
                                CupertinoIcons.chat_bubble,
                                color: Colors.white,
                                size: 30,
                              ),
                        onPressed: () => _onItemTapped(0),
                      ),
                      IconButton(
                        icon: _currentIndex == 1
                            ? ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return GradientHelper.iconGradient()
                                      .createShader(bounds);
                                },
                                child: Icon(
                                  Icons.auto_awesome,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              )
                            : Icon(
                                Icons.auto_awesome,
                                color: Colors.white,
                                size: 30,
                              ),
                        onPressed: () => _onItemTapped(1),
                      ),
                      IconButton(
                        icon: _currentIndex == 2
                            ? ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return GradientHelper.iconGradient()
                                      .createShader(bounds);
                                },
                                child: Icon(
                                  CupertinoIcons.phone,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              )
                            : Icon(
                                CupertinoIcons.phone,
                                color: Colors.white,
                                size: 30,
                              ),
                        onPressed: () => _onItemTapped(2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
