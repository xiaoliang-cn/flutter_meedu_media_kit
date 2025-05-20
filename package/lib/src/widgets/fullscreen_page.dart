import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu_media_kit/meedu_player.dart';

class MeeduPlayerFullscreenPage extends StatefulWidget {
  final MeeduPlayerController controller;
  final bool disposePlayer;

  const MeeduPlayerFullscreenPage(
      {Key? key, required this.controller, required this.disposePlayer})
      : super(key: key);
  @override
  State<MeeduPlayerFullscreenPage> createState() =>
      MeeduPlayerFullscreenPageState();
}

class MeeduPlayerFullscreenPageState extends State<MeeduPlayerFullscreenPage> {
  late SubtitleViewConfiguration subtitleViewConfiguration;
  static MeeduPlayerFullscreenPageState? of(BuildContext context) {
    return context.findAncestorStateOfType<MeeduPlayerFullscreenPageState>();
  }

  setSubViewConfiguration(SubtitleViewConfiguration config) {
    setState(() {
      subtitleViewConfiguration = config;
    });
  }

  @override
  void initState() {
    subtitleViewConfiguration = widget.controller.subtitleViewConfiguration ??
        const SubtitleViewConfiguration();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.controller.isInPipMode.value) {
          widget.controller.closePip(context);

          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: MeeduVideoPlayer(
          subtitleConfiguration: subtitleViewConfiguration,
          controller: widget.controller,
        ),
      ),
    );
  }

  @override
  Future<void> dispose() async {
    widget.controller.customDebugPrint("disposed");
    if (widget.disposePlayer) {
      widget.controller.videoPlayerClosed();
    } else {
      widget.controller.onFullscreenClose();
    }

    widget.controller.launchedAsFullScreen = false;
    if (kIsWeb) {
      //FORCE UI REFRESH
      widget.controller.forceUIRefreshAfterFullScreen.value = true;
    }
    // if (kIsWeb) {
    //   print("ON WEB WILL PLAY AFTER CLOSING FULLSCREEN");
    //   widget.controller.pause();
    //   widget.controller.play();
    // }
    super.dispose();
  }
}
