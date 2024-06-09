import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

LoadingController showLoadingOverlay(BuildContext context) {
  final GlobalKey<_PlayOverlayState> key = GlobalKey();
  final entry = OverlayEntry(
    builder: (context) => LoadingOverlay(key: key),
  );
  Overlay.of(context).insert(entry);
  return LoadingController._(entry, key);
}

class LoadingController {
  final OverlayEntry entry;
  final GlobalKey<_PlayOverlayState> key;

  LoadingController._(this.entry, this.key);

  void destroy() {
    entry.remove();
  }

  void remove() {
    key.currentState?.remove(destroy);
  }

  void setLabel(String? label) {
    key.currentState?.setLabel(label);
  }
}

class LoadingOverlay extends StatefulWidget {
  const LoadingOverlay({super.key});

  @override
  State<LoadingOverlay> createState() => _PlayOverlayState();
}

class _PlayOverlayState extends State<LoadingOverlay>
    with TickerProviderStateMixin {
  String? _label;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  )..forward();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Container(
        color: Colors.black.withAlpha((0x80 * _controller.value).toInt()),
        child: child,
      ),
      child: Stack(
        children: [
          Dialog(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    _label ?? AppLocalizations.of(context).loading,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void remove(VoidCallback destroy) {
    _controller.reverse();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        destroy();
      }
    });
  }

  void setLabel(String? label) {
    setState(() {
      _label = label;
    });
  }
}
