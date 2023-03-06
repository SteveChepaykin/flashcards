import 'package:flashcards/models/tag_model.dart';
import 'package:hive/hive.dart';

part 'card_model.g.dart';

@HiveType(typeId: 1)
class CardModel extends HiveObject{
  @HiveField(0)
  late final String word;
  @HiveField(1)
  late final String meaning;
  @HiveField(2)
  late final int rating;
  @HiveField(3)
  late final List<Tag> tags;

  CardModel({required this.meaning, required this.rating, required this.word, required this.tags}); 
}