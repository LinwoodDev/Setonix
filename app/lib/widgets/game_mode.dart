import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix_api/setonix_api.dart';

class GameModeThumbnail extends StatelessWidget {
  final PackItem<GameMode>? mode;
  final bool sandbox, multiplayer;
  final double? iconSize;
  final BoxFit fit;

  const GameModeThumbnail({
    super.key,
    this.mode,
    this.sandbox = false,
    this.multiplayer = false,
    this.iconSize,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    if (multiplayer) return const _MultiplayerThumbnail();
    if (sandbox) return const _SandboxThumbnail();
    final scheme = ColorScheme.of(context);
    final bytes = _previewBytes();
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ColoredBox(
        color: scheme.surfaceContainerHighest,
        child: bytes == null
            ? Center(
                child: Icon(
                  PhosphorIconsLight.paintBrushBroad,
                  size: iconSize ?? 44,
                ),
              )
            : Image.memory(
                bytes,
                fit: fit,
                filterQuality: FilterQuality.none,
                isAntiAlias: false,
              ),
      ),
    );
  }

  Uint8List? _previewBytes() {
    final mode = this.mode;
    final preview = mode?.item.preview;
    if (preview == null || preview.isEmpty) return null;
    final path = preview.startsWith('$kPackTexturesPath/')
        ? preview.substring(kPackTexturesPath.length + 1)
        : preview;
    return mode?.pack.getTexture(path);
  }
}

class _SandboxThumbnail extends StatelessWidget {
  const _SandboxThumbnail();

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.of(context);
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ColoredBox(
        color: scheme.primaryContainer,
        child: Center(
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: scheme.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              PhosphorIconsFill.cubeTransparent,
              size: 38,
              color: scheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class _MultiplayerThumbnail extends StatelessWidget {
  const _MultiplayerThumbnail();

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.of(context);
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ColoredBox(
        color: scheme.primaryContainer,
        child: Center(
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: scheme.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              PhosphorIconsFill.usersThree,
              size: 38,
              color: scheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class GameModeTile extends StatelessWidget {
  final bool sandbox, multiplayer;
  final String label;
  final PackItem<GameMode>? mode;
  final VoidCallback onTap;

  const GameModeTile({
    super.key,
    this.sandbox = false,
    this.multiplayer = false,
    required this.label,
    required this.mode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GameModeThumbnail(mode: mode, sandbox: sandbox),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
