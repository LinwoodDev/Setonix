import 'package:material_ui/material_ui.dart';
import 'package:material_leap/material_leap.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';

class HeaderHomeView extends StatelessWidget {
  const HeaderHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMedium = constraints.maxWidth >= LeapBreakpoints.medium;
        final textColumn = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: isMedium
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context).welcome,
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: isMedium ? TextAlign.start : TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context).homeWelcomeDescription,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: isMedium ? TextAlign.start : TextAlign.center,
            ),
          ],
        );
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Flex(
              direction: isMedium ? Axis.horizontal : Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/logo.png', width: isMedium ? 132 : 96),
                if (isMedium) const SizedBox(width: 48),
                if (!isMedium) const SizedBox(height: 24),
                if (isMedium) Flexible(child: textColumn) else textColumn,
              ],
            ),
          ),
        );
      },
    );
  }
}
