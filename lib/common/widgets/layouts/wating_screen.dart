import 'package:flutter/material.dart';

class WatingScreen extends StatelessWidget {
  const WatingScreen({required this.child, required this.duration, super.key});

  final Widget child;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: _WatingBackground(
        image: const AssetImage('assets/images/wating_background.png'),
        duration: duration,
        child: child,
      ),
    );
  }
}

class _WatingBackground extends StatefulWidget {
  const _WatingBackground({
    required this.child,
    required this.image,
    required this.duration,
  });

  final Widget child;
  final AssetImage image;
  final Duration duration;

  @override
  _WatingBackgroundState createState() => _WatingBackgroundState();
}

class _WatingBackgroundState extends State<_WatingBackground>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _position = Tween<double>(
    begin: 0,
    end: -1,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.7, curve: Curves.easeInOutQuart),
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned(
              left:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? _position.value * MediaQuery.of(context).size.width
                      : 0,
              height:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.height
                      : MediaQuery.of(context).size.width,
              top:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 0
                      : -MediaQuery.of(context).size.height / 2,
              child: Image(
                image: widget.image,
                fit:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? BoxFit.fitHeight
                        : BoxFit.fitWidth,
              ),
            ),
            Container(alignment: Alignment.center, child: widget.child),
          ],
        );
      },
    );
  }
}
