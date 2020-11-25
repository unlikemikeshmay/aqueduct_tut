import 'dart:async';

import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/model/read.dart';

class Migration1 extends Migration {
  @override
  Future upgrade() async {
    database.createTable(SchemaTable(
      "_Read",
      [
        SchemaColumn("id", ManagedPropertyType.bigInteger,
            isPrimaryKey: true,
            autoincrement: true,
            isIndexed: false,
            isNullable: false,
            isUnique: false),
        SchemaColumn("title", ManagedPropertyType.string,
            isPrimaryKey: false,
            autoincrement: false,
            isIndexed: false,
            isNullable: false,
            isUnique: true),
        SchemaColumn("author", ManagedPropertyType.string,
            isPrimaryKey: false,
            autoincrement: false,
            isIndexed: false,
            isNullable: false,
            isUnique: false),
        SchemaColumn("year", ManagedPropertyType.integer,
            isPrimaryKey: false,
            autoincrement: false,
            isIndexed: false,
            isNullable: false,
            isUnique: false),
      ],
    ));
  }

  @override
  Future downgrade() async {}

  @override
  Future seed() async {
    final List<Map> reads = [
      {'title': 'ned flanders', 'author': 'conan obrien', 'year': 6342},
      {'title': 'toby mcguire', 'author': 'stan lee', 'year': 7777},
      {'title': 'brandon fraser', 'author': 'Imotep', 'year': 2222},
      {'title': 'keifer sunderland', 'author': 'keifers mom', 'year': 3341},
      {'title': 'toby keith', 'author': 'mike jay', 'year': 3111},
      {'title': 'len trexler', 'author': 'archer writers', 'year': 1221},
      {'title': 'borat', 'author': 'sacha baron cohen', 'year': 1566},
    ];
    for (final read in reads) {
      await database.store.execute(
          'INSERT INTO _Read (title,author,year) VALUES(@title,@author,@year)',
          substitutionValues: {
            'title': read['title'],
            'author': read['author'],
            'year': read['year']
          });
    }
  }
}
