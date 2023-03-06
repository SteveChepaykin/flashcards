import 'package:hive/hive.dart';

part 'tag_model.g.dart';

@HiveType(typeId: 0)
class Tag extends HiveObject{
  @HiveField(0)
  late final String name;

  Tag(this.name);
}