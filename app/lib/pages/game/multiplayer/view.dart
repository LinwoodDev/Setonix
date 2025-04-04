part of 'dialog.dart';

class ViewMultiplayerDialog extends StatelessWidget {
  final MultiplayerConnectedState state;

  const ViewMultiplayerDialog({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final info = FutureBuilder<Uri>(
      future: Future.value(state.getShareAddress()),
      builder: (context, snapshot) {
        final address = snapshot.data?.toString() ?? '?';
        final connect = getConnectUri(address).toString();
        final qr = Barcode.qrCode();
        final svg = qr.toSvg(connect, width: 256, height: 256);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                height: 208,
                width: 208,
                child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    radius: 12,
                    onTap: () {
                      exportFile(
                        context: context,
                        bytes: svg.codeUnits,
                        fileExtension: 'svg',
                        mimeType: 'image/svg',
                        uniformTypeIdentifier: 'public.svg-image',
                        share: true,
                        fileName: 'output',
                        label: AppLocalizations.of(context).export,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                          alignment: Alignment.center,
                          fit: StackFit.expand,
                          children: [
                            ColoredBox(color: Colors.white),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: SvgPicture.string(svg),
                            ),
                          ]),
                    ))),
            const SizedBox(height: 8),
            ListTile(
              title: Text(AppLocalizations.of(context).url),
              subtitle: Text(address),
              onTap: () => saveToClipboard(context, connect),
            ),
          ],
        );
      },
    );
    final userList = StreamBuilder<Set<Channel>>(
        stream: state.clientChange,
        builder: (context, snapshot) {
          final connections = snapshot.data ?? {};
          if (connections.isEmpty) {
            return Text(
              AppLocalizations.of(context).noConnections,
              textAlign: TextAlign.center,
            );
          }
          return ListView.builder(
            itemCount: connections.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final channel = connections.elementAt(index);
              final defaultName =
                  AppLocalizations.of(context).defaultUserName(channel);

              return ListTile(
                title: Text(defaultName),
              );
            },
          );
        });
    final size = MediaQuery.sizeOf(context);
    final isMobile = size.width < LeapBreakpoints.medium;
    return ResponsiveAlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalizations.of(context).multiplayer),
          Text(
            state.isServer
                ? AppLocalizations.of(context).server
                : AppLocalizations.of(context).client,
            style: TextTheme.of(context).labelLarge,
          ),
        ],
      ),
      leading: IconButton.outlined(
        icon: const Icon(PhosphorIconsLight.x),
        onPressed: () => Navigator.of(context).pop(),
        tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
      ),
      constraints:
          BoxConstraints(maxWidth: LeapBreakpoints.medium, maxHeight: 500),
      content: isMobile
          ? ListView(
              children: [
                info,
                const Divider(),
                userList,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: Center(child: SingleChildScrollView(child: info))),
                const VerticalDivider(),
                Expanded(child: SingleChildScrollView(child: userList)),
              ],
            ),
      actions: [
        OutlinedButton(
          child: Text(AppLocalizations.of(context).stop),
          onPressed: () {
            context.read<MultiplayerCubit>().close();
          },
        ),
        TextButton(
          child: Text(MaterialLocalizations.of(context).closeButtonLabel),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
