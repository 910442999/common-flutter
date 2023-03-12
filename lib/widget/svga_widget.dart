import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'index.dart';

class SVGAWidget extends StatefulWidget {
  final String image;
  bool? allowOverflow;
  final double width;
  final double height;
  final BoxFit? fit;
  final bool? clearsAfterStop;
  final FilterQuality? filterQuality;
  final SVGAAnimationController? animationController;
  final void Function(MovieEntity entity)? dynamicCallback;

  SVGAWidget(
      {Key? key,
      required this.image,
      this.dynamicCallback,
      this.fit,
      required this.width,
      required this.height,
      this.animationController,
      this.clearsAfterStop,
      this.filterQuality,
      this.allowOverflow})
      : super(key: key);

  @override
  _SVGAWidgetState createState() => _SVGAWidgetState();
}

class _SVGAWidgetState extends State<SVGAWidget>
    with SingleTickerProviderStateMixin {
  SVGAAnimationController? animationController;

  // Canvaskit need FilterQuality.high
  bool hideOptions = true;

  @override
  void initState() {
    super.initState();
    if (widget.animationController == null) {
      animationController = SVGAAnimationController(vsync: this);
    } else {
      animationController = widget.animationController;
    }
    _loadAnimation();
  }

  @override
  void dispose() {
    this.animationController?.dispose();
    this.animationController = null;
    super.dispose();
  }

  void _loadAnimation() async {
    // FIXME: may throw error on loading
    final videoItem = await _loadVideoItem(widget.image);
    if (widget.dynamicCallback != null) {
      widget.dynamicCallback!(videoItem);
    }
    if (mounted)
      setState(() {
        this.animationController?.videoItem = videoItem;
        _playAnimation();
      });
  }

  void _playAnimation() {
    if (animationController?.isCompleted == true) {
      animationController?.reset();
    }
    animationController?.repeat(); // or animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SVGAImage(
          animationController!,
          fit: widget.fit ?? BoxFit.contain,
          clearsAfterStop: widget.clearsAfterStop ?? false,
          allowDrawingOverflow: widget.allowOverflow,
          filterQuality: widget.filterQuality ??
              (kIsWeb ? FilterQuality.high : FilterQuality.low),
          preferredSize: Size(widget.width, widget.height),
        ),
      ),
    );
  }
}

Future _loadVideoItem(String image) {
  Future Function(String) decoder;
  if (image.startsWith(RegExp(r'https?://'))) {
    decoder = SVGAParser.shared.decodeFromURL;
  } else {
    decoder = SVGAParser.shared.decodeFromAssets;
  }
  return decoder(image);
}
