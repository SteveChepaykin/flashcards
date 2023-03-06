import 'package:flashcards/models/card_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import "dart:math";

class CardCarousel extends StatefulWidget {
  const CardCarousel({super.key});

  @override
  State<CardCarousel> createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {
  bool hasAnswered = false;
  final cards = Hive.box<CardModel>('cards').values.toList();
  late CardModel card;
  final _random = Random();

  @override
  void initState() {
    card = cards[_random.nextInt(cards.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(card.word),
              if (hasAnswered)
                const SizedBox(
                  height: 20,
                ),
              if (hasAnswered) Text(card.meaning)
            ],
          ),
        ),
        !hasAnswered
            ? ElevatedButton(
                onPressed: () {
                  setState(
                    () {
                      hasAnswered = true;
                    },
                  );
                },
                child: const Text('Показать ответ'),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          card = cards[_random.nextInt(cards.length)];
                          hasAnswered = false;
                        });
                      },
                      child: const Text('дальше'))
                ],
              ),
      ],
    );
  }
}
