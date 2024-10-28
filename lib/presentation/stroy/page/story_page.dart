import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled11/domain/models/models.dart';

class StoryPage extends StatefulWidget {
  final StoryModel storyModel;
final int sql;
  const StoryPage({super.key, required this.storyModel,required this.sql});

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late Timer _timer;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5), // مدة عرض كل صورة
    )..forward();

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        if (_currentIndex < widget.storyModel.images.length - 1) {
          _currentIndex++;
        } else {
          _timer.cancel(); // إيقاف المؤقت عند آخر صورة
          Navigator.pop(context); // الرجوع إلى الشاشة السابقة بعد انتهاء القصة
        }
      });
      _animationController.reset();
      _animationController.forward();
    });
  }

  void _pauseStory() {
    _timer.cancel(); // إيقاف المؤقت
    _animationController.stop(); // إيقاف الأنيميشن
  }

  void _resumeStory() {
    _startTimer(); // إعادة تشغيل المؤقت
    _animationController.forward(); // إعادة تشغيل الأنيميشن
  }

  void _goNext() {
    setState(() {
      if (_currentIndex < widget.storyModel.images.length - 1) {
        _currentIndex++;
        _animationController.reset();
        _animationController.forward();
      } else {
        Navigator.pop(context); // الرجوع إلى الشاشة السابقة بعد انتهاء القصة
      }
    });
  }

  void _goPrevious() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        _animationController.reset();
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: (details) {
          final width = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx < width / 2) {
            _goPrevious();
          } else {
            _goNext();
          }
        },
        onLongPress: _pauseStory,
        onLongPressUp: _resumeStory,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: widget.sql == 1
                  ? Image.memory(
                base64Decode(widget.storyModel.images[_currentIndex]),
                fit: BoxFit.cover,
              )
                  : CachedNetworkImage(
                imageUrl:
                widget.storyModel.images[_currentIndex],
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
              ),
            ),

            Positioned(
              top: 40,
              left: 10,
              right: 10,
              child: Row(
                children: widget.storyModel.images.asMap().entries.map((entry) {
                  int idx = entry.key;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return LinearProgressIndicator(
                            value: _currentIndex == idx
                                ? _animationController.value
                                : (_currentIndex > idx ? 1 : 0),
                            backgroundColor: Colors.white.withOpacity(0.5),
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Positioned(
              top: 50,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
