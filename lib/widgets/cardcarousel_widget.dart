import 'package:flashcards/models/card_model.dart';
import 'package:flashcards/models/tag_model.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import "dart:math";

class CardCarousel extends StatefulWidget {
  final Tag? filter;
  final List<CardModel> cards;
  const CardCarousel({super.key, required this.filter, required this.cards});

  @override
  State<CardCarousel> createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {
  bool hasAnswered = false;
  int option = 0;
  int counter = 0;
  late List<CardModel> cards;
  late CardModel card;
  final _random = Random();
  late FlipCardController flipcontroller;

  @override
  void initState() {
    if (widget.filter != null) {
      cards = widget.cards.where((element) => element.tags.contains(widget.filter)).toList();
    } else {
      cards = widget.cards;
    }
    card = widget.cards[_random.nextInt(widget.cards.length)];
    flipcontroller = FlipCardController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      controller: flipcontroller,
      onFlipDone: (isFront) {
        if (!isFront) {
          setState(() {
            card.rating += option;
            option = 0;
            card.save();
            var nocur = cards.where((element) => element != card).toList();
            nocur.sort((a, b) => a.rating.compareTo(b.rating));
            if (counter % 4 == 0) {
              // card = nocur[_random.nextInt((nocur.length / 2).ceil()) + (nocur.length / 2).floor()];
              card = nocur.getRange((nocur.length / 2).ceil(), nocur.length).toList()[_random.nextInt((nocur.length / 2).ceil())];
            } else {
              // card = nocur[_random.nextInt((nocur.length / 2).ceil())];
              card = nocur.getRange(0, (nocur.length / 2).ceil()).toList()[_random.nextInt((nocur.length / 2).ceil())];
            }
            hasAnswered = false;
            counter += 1;
          });
          flipcontroller.toggleCard();
        }
      },
      front: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue[200]),
        child: Center(
          child: Text(
            card.word,
            style: const TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      back: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue[200]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              card.word,
              style: const TextStyle(fontSize: 20),
            ),
            const Divider(
              indent: 10,
              endIndent: 10,
              color: Colors.black54,
              thickness: 2,
            ),
            Text(
              card.meaning,
              style: const TextStyle(fontSize: 20),
            ),
            const Spacer(),
            Row(
              children: [
                const Spacer(flex: 3),
                optionButton(-3, Icons.thumb_down_alt_rounded),
                const Spacer(),
                optionButton(1, Icons.back_hand_rounded),
                const Spacer(),
                optionButton(4, Icons.thumb_up_alt_rounded),
                const Spacer(flex: 3)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget optionButton(int value, IconData icon) => Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: option == value ? Colors.black54 : Colors.white,
            )),
        child: IconButton(
          onPressed: () {
            setState(() {
              option = value;
            });
          },
          icon: Icon(
            icon,
            color: option == value ? Colors.black54 : Colors.white,
          ),
        ),
      );
}
