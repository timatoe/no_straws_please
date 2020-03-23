import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../styles.dart';

/// Partially overlays and then blurs its child's background.
class FrostedBox extends StatelessWidget {
  const FrostedBox({
    this.child,
    Key key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Styles.frostedBackground,
        ),
        child: child,
      ),
    );
  }
}

/// An Icon that implicitly animates changes to its color.
class ColorChangingIcon extends ImplicitlyAnimatedWidget {
  const ColorChangingIcon(
    this.icon, {
    this.color = CupertinoColors.black,
    this.size,
    @required Duration duration,
    Key key,
  })  : assert(icon != null),
        assert(color != null),
        assert(duration != null),
        super(key: key, duration: duration);

  final Color color;

  final IconData icon;

  final double size;

  @override
  _ColorChangingIconState createState() => _ColorChangingIconState();
}

class _ColorChangingIconState
    extends AnimatedWidgetBaseState<ColorChangingIcon> {
  ColorTween _colorTween;

  @override
  Widget build(BuildContext context) {
    return Icon(
      widget.icon,
      semanticLabel: 'Back button',
      size: widget.size,
      color: _colorTween?.evaluate(animation),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _colorTween = visitor(
      _colorTween,
      widget.color,
      (dynamic value) => ColorTween(begin: value as Color),
    ) as ColorTween;
  }
}

/// A simple "close this modal" button that invokes a callback when pressed.
class BackButton extends StatefulWidget {
  const BackButton(this.onPressed);

  final VoidCallback onPressed;

  @override
  BackButtonState createState() {
    return BackButtonState();
  }
}

class BackButtonState extends State<BackButton> {
  bool tapInProgress = false;

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;
    
    return GestureDetector(
      onTapDown: (details) {
        setState(() => tapInProgress = true);
      },
      onTapUp: (details) {
        setState(() => tapInProgress = false);
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() => tapInProgress = false);
      },
      child: Center(
        child: ColorChangingIcon(
          CupertinoIcons.back,
          duration: Duration(milliseconds: 300),
          color: tapInProgress
              ? Styles.backButtonPressed
              : isDark ? Styles.darkBackButtonUnpressed : Styles.backButtonUnpressed,
          size: 20,
        ),
      ),
    );
  }
}
