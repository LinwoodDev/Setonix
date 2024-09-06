import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quokka/bloc/world/bloc.dart';
import 'package:quokka_api/quokka_api.dart';

class GameChatDialog extends StatefulWidget {
  const GameChatDialog({super.key});

  @override
  State<GameChatDialog> createState() => _GameChatDialogState();
}

class _GameChatDialogState extends State<GameChatDialog> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _messageController.dispose();
    _messageFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      constraints: const BoxConstraints(
          maxWidth: LeapBreakpoints.compact, maxHeight: 500),
      leading: IconButton.outlined(
        icon: const Icon(PhosphorIconsLight.x),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(AppLocalizations.of(context).chat),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: BlocConsumer<WorldBloc, WorldState>(
              listener: (context, state) => _scrollController.jumpTo(
                _scrollController.position.maxScrollExtent,
              ),
              builder: (context, state) {
                final messages = state.messages;
                return ListView.builder(
                  itemCount: messages.length,
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return Card.filled(
                      color: message.author == state.id
                          ? Theme.of(context).colorScheme.primaryContainer
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  message.author.toString(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  DateFormat.Hms(Localizations.localeOf(context)
                                          .languageCode)
                                      .format(message.timestamp),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            Text(message.content),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Flexible(
                child: TextField(
                  controller: _messageController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context).message,
                    filled: true,
                    suffixIcon: ListenableBuilder(
                        listenable: _messageController,
                        builder: (context, _) {
                          return IconButton(
                            icon:
                                const Icon(PhosphorIconsLight.paperPlaneRight),
                            onPressed: _messageController.text.isEmpty
                                ? null
                                : _onSubmit,
                          );
                        }),
                  ),
                  focusNode: _messageFocus,
                  autofocus: true,
                  onSubmitted: (_) {
                    _onSubmit();
                    _messageFocus.requestFocus();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onSubmit() {
    final message = _messageController.text;
    if (message.isNotEmpty) {
      context.read<WorldBloc>().process(MessageRequest(message));
      _messageController.clear();
    }
  }
}
