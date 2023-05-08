import 'package:flutter/material.dart';
import 'package:qeck/logic/state.dart';

class CardView extends StatelessWidget {
  final GameCard card;

  const CardView({required this.card, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      width: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.primaryContainer,
          width: 2,
        ),
      ),
      alignment: Alignment.center,
      child: Text(card.toString(), style: const TextStyle(fontSize: 10)),
    );
  }
}
