import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix_api/setonix_api.dart';

class GameChatOverlay extends StatefulWidget {
  final bool open, handVisible;
  final VoidCallback onClose;

  const GameChatOverlay({
    super.key,
    required this.open,
    required this.handVisible,
    required this.onClose,
  });

  @override
  State<GameChatOverlay> createState() => _GameChatOverlayState();
}

class _GameChatOverlayState extends State<GameChatOverlay> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void didUpdateWidget(covariant GameChatOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.open && !oldWidget.open) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _focusNode.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    final message = _controller.text.trim();
    if (message.isEmpty) return;
    context.read<WorldBloc>().process(MessageRequest(message));
    _controller.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.bottomLeft,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.fromLTRB(16, 16, 16, widget.handVisible ? 208 : 16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 390),
          child: BlocBuilder<WorldBloc, ClientWorldState>(
            buildWhen: (previous, current) =>
                previous.messages != current.messages,
            builder: (context, state) {
              final messages = state.messages.reversed
                  .take(4)
                  .toList()
                  .reversed;
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final message in messages)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: scheme.surface.withValues(alpha: 0.82),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    '${AppLocalizations.of(context).defaultPlayerName(message.author)}: ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(text: message.content),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (widget.open) ...[
                    const SizedBox(height: 8),
                    Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(12),
                      color: scheme.surfaceContainerHigh,
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context).message,
                          prefixIcon: IconButton(
                            onPressed: widget.onClose,
                            tooltip: AppLocalizations.of(context).close,
                            icon: const Icon(PhosphorIconsLight.x),
                          ),
                          suffixIcon: IconButton(
                            onPressed: _submit,
                            icon: const Icon(
                              PhosphorIconsLight.paperPlaneRight,
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                        onSubmitted: (_) => _submit(),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
