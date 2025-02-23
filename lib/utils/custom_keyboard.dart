import 'package:flutter/material.dart';

// Enumeration for keyboard modes.
enum KeyboardMode { letters, symbols, emojis, translator }

class CustomKeyboard extends StatefulWidget {
  // Callback for when text input is provided via a key tap.
  final ValueSetter<String> onTextInput;
  // Callback for the backspace key.
  final VoidCallback onBackspace;
  // Callback for the enter key.
  final VoidCallback onEnter;

  const CustomKeyboard({
    Key? key,
    required this.onTextInput,
    required this.onBackspace,
    required this.onEnter,
  }) : super(key: key);

  @override
  _CustomKeyboardState createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  KeyboardMode _currentMode = KeyboardMode.letters;
  bool _isUppercase = true; // Toggle for text capitalization in letters mode.

  /// Top mode selector to switch between Letters, Symbols, Emojis, and Translator.
  Widget _buildModeSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildModeButton("ABC", KeyboardMode.letters),
          _buildModeButton("Symbols", KeyboardMode.symbols),
          _buildModeButton("😊", KeyboardMode.emojis),
          _buildModeButton("Translate", KeyboardMode.translator),
        ],
      ),
    );
  }

  /// Builds a mode selector button with a gradient background.
  Widget _buildModeButton(String label, KeyboardMode mode) {
    bool isSelected = _currentMode == mode;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentMode = mode;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [Colors.grey.shade800, Colors.grey.shade900],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// Returns the keyboard content based on the selected mode.
  Widget _buildKeyboardContent() {
    switch (_currentMode) {
      case KeyboardMode.letters:
        return _buildLettersKeyboard();
      case KeyboardMode.symbols:
        return _buildSymbolsKeyboard();
      case KeyboardMode.emojis:
        return _buildEmojisKeyboard();
      case KeyboardMode.translator:
        return _buildTranslatorKeyboard();
      default:
        return _buildLettersKeyboard();
    }
  }

  /// Letters keyboard with shift (capitalization), backspace, space, and enter keys.
  Widget _buildLettersKeyboard() {
    // Define the rows for a QWERTY keyboard.
    List<List<String>> letterRows = [
      ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
      ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
      ["Z", "X", "C", "V", "B", "N", "M"],
    ];

    return Column(
      children: [
        // First two rows.
        for (var row in letterRows.take(2))
          Expanded(
            child: Row(
              children: row.map((letter) {
                String displayLetter =
                    _isUppercase ? letter : letter.toLowerCase();
                return _buildKey(displayLetter, onTap: () {
                  widget.onTextInput(displayLetter);
                });
              }).toList(),
            ),
          ),
        // Third row includes a shift toggle and a backspace key.
        Expanded(
          child: Row(
            children: [
              _buildSpecialKey(
                Icons.arrow_upward,
                label: "SHIFT",
                onTap: () {
                  setState(() {
                    _isUppercase = !_isUppercase;
                  });
                },
              ),
              ...letterRows[2].map((letter) {
                String displayLetter =
                    _isUppercase ? letter : letter.toLowerCase();
                return _buildKey(displayLetter, onTap: () {
                  widget.onTextInput(displayLetter);
                });
              }).toList(),
              _buildSpecialKey(
                Icons.backspace,
                label: "BACK",
                onTap: () {
                  widget.onBackspace();
                },
              ),
            ],
          ),
        ),
        // Fourth row: a button to toggle symbols mode, a space key, and an enter key.
        Expanded(
          child: Row(
            children: [
              _buildSpecialKey(
                null,
                label: "123",
                onTap: () {
                  setState(() {
                    _currentMode = KeyboardMode.symbols;
                  });
                },
              ),
              Expanded(
                flex: 3,
                child: _buildKey("Space", onTap: () {
                  widget.onTextInput(" ");
                }),
              ),
              _buildSpecialKey(
                null,
                label: "Enter",
                onTap: () {
                  widget.onEnter();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Symbols keyboard.
  Widget _buildSymbolsKeyboard() {
    List<List<String>> symbolRows = [
      ["!", "@", "#", "\$", "%", "^", "&", "*", "(", ")"],
      ["-", "+", "=", "/", "?", "<", ">", "[", "]"],
      [":", ";", "\"", "'", "{", "}", "\\", "|"],
    ];

    return Column(
      children: [
        for (var row in symbolRows)
          Expanded(
            child: Row(
              children: row.map((symbol) {
                return _buildKey(symbol, onTap: () {
                  widget.onTextInput(symbol);
                });
              }).toList(),
            ),
          ),
        // Bottom row: switch back to letters, space, and backspace.
        Expanded(
          child: Row(
            children: [
              _buildSpecialKey(
                null,
                label: "ABC",
                onTap: () {
                  setState(() {
                    _currentMode = KeyboardMode.letters;
                  });
                },
              ),
              Expanded(
                flex: 3,
                child: _buildKey("Space", onTap: () {
                  widget.onTextInput(" ");
                }),
              ),
              _buildSpecialKey(
                Icons.backspace,
                label: "BACK",
                onTap: () {
                  widget.onBackspace();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Emoji keyboard.
  Widget _buildEmojisKeyboard() {
    List<List<String>> emojiRows = [
      ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "😊", "😇"],
      ["😉", "😍", "😘", "😗", "😚", "😙", "😋", "🤪", "😜", "🤩"],
      ["🤔", "😎", "🤗", "🤭", "🤫", "🤥", "😶", "😐", "😑"],
    ];

    return Column(
      children: [
        for (var row in emojiRows)
          Expanded(
            child: Row(
              children: row.map((emoji) {
                return _buildKey(emoji, onTap: () {
                  widget.onTextInput(emoji);
                });
              }).toList(),
            ),
          ),
        // Bottom row: back to letters, space, backspace.
        Expanded(
          child: Row(
            children: [
              _buildSpecialKey(
                null,
                label: "ABC",
                onTap: () {
                  setState(() {
                    _currentMode = KeyboardMode.letters;
                  });
                },
              ),
              Expanded(
                flex: 3,
                child: _buildKey("Space", onTap: () {
                  widget.onTextInput(" ");
                }),
              ),
              _buildSpecialKey(
                Icons.backspace,
                label: "BACK",
                onTap: () {
                  widget.onBackspace();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Translator keyboard with preset phrases.
  Widget _buildTranslatorKeyboard() {
    // Preset phrases (you can extend or even integrate with a translation API).
    List<List<String>> translatorRows = [
      ["Hello", "Hi", "How are you?"],
      ["Goodbye", "See you", "Take care"],
      ["Thank you", "Please", "Sorry"],
    ];

    return Column(
      children: [
        for (var row in translatorRows)
          Expanded(
            child: Row(
              children: row.map((phrase) {
                return _buildKey(phrase, onTap: () {
                  widget.onTextInput(phrase);
                });
              }).toList(),
            ),
          ),
        // Bottom row: back to letters, space, backspace.
        Expanded(
          child: Row(
            children: [
              _buildSpecialKey(
                null,
                label: "ABC",
                onTap: () {
                  setState(() {
                    _currentMode = KeyboardMode.letters;
                  });
                },
              ),
              Expanded(
                flex: 3,
                child: _buildKey("Space", onTap: () {
                  widget.onTextInput(" ");
                }),
              ),
              _buildSpecialKey(
                Icons.backspace,
                label: "BACK",
                onTap: () {
                  widget.onBackspace();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds a standard key with a gradient background.
  Widget _buildKey(String value, {required VoidCallback onTap}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.deepPurple, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              // For the space key, you might display an icon or leave it blank.
              value == "Space" ? "" : value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a special key for functions like shift, backspace, enter, or mode switches.
  Widget _buildSpecialKey(IconData? icon,
      {required String label, required VoidCallback onTap}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.orangeAccent, Colors.redAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: icon != null
                ? Icon(icon, color: Colors.white)
                : Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Overall gradient background for the keyboard.
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black87, Colors.black54],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      height: 350, // Adjust height as desired.
      child: Column(
        children: [
          _buildModeSelector(),
          const Divider(color: Colors.white54),
          Expanded(child: _buildKeyboardContent()),
        ],
      ),
    );
  }
}
