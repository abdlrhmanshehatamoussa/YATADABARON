import 'package:Yatadabaron/dtos/verse-dto-collection.dart';
import 'package:Yatadabaron/services/arabic-numbers-service.dart';

import '../helpers/localization.dart';

class ChapterFullDTO {
  final int chapterId;
  final String chapterNameAR;
  final String chapterLocation;
  final int versesCount;
  final String sajdaVerseId;

  ChapterFullDTO(this.chapterId, this.chapterNameAR, this.chapterLocation,
      this.versesCount, this.sajdaVerseId);

  String get summary {
    String location = chapterLocation == "1"
        ? Localization.MECCA_LOCATION
        : Localization.MADINA_LOCATION;
    String versesCountInArabic =
        ArabicNumbersService.insance.convert(versesCount);
    String prefix = Localization.VERSE;
    if (versesCount <= 10) {
      prefix = Localization.VERSES;
    }
    return "$location | $versesCountInArabic $prefix";
  }
}
