import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:material_leap/material_leap.dart';
import 'package:networker/networker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:setonix/api/open.dart';
import 'package:setonix/bloc/multiplayer.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/bloc/settings.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:rxdart/rxdart.dart';

part 'start.dart';
part 'view.dart';

class MultiplayerDialog extends StatelessWidget {
  const MultiplayerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultiplayerCubit, MultiplayerState>(
      builder: (context, state) {
        if (state is MultiplayerConnectedState) {
          return ViewMultiplayerDialog(state: state);
        } else {
          return StartMultiplayerDialog();
        }
      },
    );
  }
}
