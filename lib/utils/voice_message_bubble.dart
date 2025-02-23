import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/animation.dart';
import 'package:chatapp/utils/gradient.dart';

class VoiceMessageBubble extends StatefulWidget {
  final bool isSent;
  final String audioPath;
  final Duration duration;
  final DateTime timestamp;

  const VoiceMessageBubble({
    super.key,
    required this.isSent,
    required this.audioPath,
    required this.duration,
    required this.timestamp,
  });

  @override
  State<VoiceMessageBubble> createState() => _VoiceMessageBubbleState();
}

class _VoiceMessageBubbleState extends State<VoiceMessageBubble> 
    with SingleTickerProviderStateMixin {
  final AudioPlayer _player = AudioPlayer();
  late AnimationController _waveController;
  bool _isPlaying = false;
  double _playbackProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _player.dispose();
    _waveController.dispose();
    super.dispose();
  }

  Future<void> _togglePlayback() async {
    if (_isPlaying) {
      await _player.pause();
    } else {
      await _player.setFilePath(widget.audioPath);
      await _player.play();
      _player.positionStream.listen((position) {
        setState(() {
          _playbackProgress = position.inMilliseconds.toDouble() / 
              widget.duration.inMilliseconds.toDouble();
        });
      });
    }
    setState(() => _isPlaying = !_isPlaying);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: widget.isSent
              ? GradientHelper.sentbubble()
              : GradientHelper.recievedbubble(),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: _togglePlayback,
                ),
                const SizedBox(width: 8),
                _buildWaveform(),
                const SizedBox(width: 12),
                Text(
                  '${widget.duration.inSeconds}s',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildProgressIndicator(),
            const SizedBox(height: 4),
            Text(
              _formatTime(widget.timestamp),
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaveform() {
    return AnimatedBuilder(
      animation: _waveController,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(100, 30),
          painter: WaveformPainter(
            isPlaying: _isPlaying,
            progress: _playbackProgress,
            animationValue: _waveController.value,
          ),
        );
      },
    );
  }

  Widget _buildProgressIndicator() {
    return LinearProgressIndicator(
      value: _playbackProgress,
      backgroundColor: Colors.white.withOpacity(0.2),
      valueColor: AlwaysStoppedAnimation<Color>(
        widget.isSent ? Colors.white : Colors.blue[200]!,
      ),
      minHeight: 2,
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }
}

class WaveformPainter extends CustomPainter {
  final bool isPlaying;
  final double progress;
  final double animationValue;

  WaveformPainter({
    required this.isPlaying,
    required this.progress,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final waveCount = 20;
    final waveWidth = size.width / waveCount;
    final maxHeight = size.height;

    for (var i = 0; i < waveCount; i++) {
      final height = (sin((i + animationValue * 2 * pi)) * maxHeight / 2 + 
          maxHeight / 2) * (isPlaying ? 1 : 0.3);
      final left = i * waveWidth;
      final isPlayed = left < size.width * progress;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            left + 2,
            (size.height - height) / 2,
            waveWidth - 4,
            height,
          ),
          const Radius.circular(2),
        ),
        paint..color = isPlayed ? Colors.blue[200]! : Colors.white,
      );
    }
  }

  @override
  bool shouldRepaint(covariant WaveformPainter oldDelegate) => true;
}