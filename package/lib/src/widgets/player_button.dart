import 'package:flutter/material.dart';
import 'package:flutter_meedu_media_kit/meedu_player.dart';

class PlayerButton extends StatelessWidget {
  final double size;
  final String? iconPath;
  final VoidCallback onPressed;
  final Color backgroundColor, iconColor;
  final bool circle;
  final Widget? customIcon;
  final Icon? icon;
  const PlayerButton({
    Key? key,
    this.size = 40,
    this.iconPath,
    required this.onPressed,
    this.circle = true,
    this.backgroundColor = Colors.white54,
    this.iconColor = Colors.black,
    this.customIcon,
    this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(10),
      constraints: const BoxConstraints(),
      onPressed: () {
        onPressed();
        MeeduPlayerController.of(context).controls = true;
      },
      icon: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: circle ? BoxShape.circle : BoxShape.rectangle,
            ),
            child: customIcon ?? icon ?? Image.asset(
              iconPath!,
              color: iconColor,
              package: 'flutter_meedu_media_kit',
            ),
          ),
    );
  }
}
