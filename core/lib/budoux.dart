import 'package:budoux/model.dart';
import 'package:budoux/unicode_blocks.dart';
import 'package:tuple/tuple.dart';

const int defaultThreshold = 1000;

class Budoux {
  const Budoux({this.model = const Model.jaKNBC()});
  final Model model;

  Iterable<String> parse(String str, {int threshold = defaultThreshold}) {
    const skipParseLimit = 3;
    if (str.runes.length <= skipParseLimit) {
      return [str];
    } else {
      final out = <String>[];

      final sb = StringBuffer()
        ..write(String.fromCharCodes(str.runes.take(skipParseLimit)));
      final runes = str.runes;
      var p1 = 'U';
      var p2 = 'U';
      var p3 = 'U';
      for (var i = 3; i < runes.length; i++) {
        final w1b1 = getUnicodeBlockAndFeature(runes, i - 3);
        final w2b2 = getUnicodeBlockAndFeature(runes, i - 2);
        final w3b3 = getUnicodeBlockAndFeature(runes, i - 1);
        final w4b4 = getUnicodeBlockAndFeature(runes, i - 0);
        final w5b5 = getUnicodeBlockAndFeature(runes, i + 1);
        final w6b6 = getUnicodeBlockAndFeature(runes, i + 2);
        final features = getFeature(
            w1b1.item1,
            w2b2.item1,
            w3b3.item1,
            w4b4.item1,
            w5b5.item1,
            w6b6.item1,
            w1b1.item2,
            w2b2.item2,
            w3b3.item2,
            w4b4.item2,
            w5b5.item2,
            w6b6.item2,
            p1,
            p2,
            p3);
        var score = 0.0;
        features.toList().forEach((f) {
          if (model.contains(f)) {
            score += model.get(f)!;
          }
        });
        if (score > threshold) {
          out.add(sb.toString());
          sb
            ..clear()
            ..write(w4b4.item1);
        } else {
          sb.write(w4b4.item1);
        }

        p1 = p2;
        p2 = p3;
        if (score > 0) {
          p3 = 'B';
        } else {
          p3 = '0';
        }
      }

      if (sb.isNotEmpty) {
        out.add(sb.toString());
      }
      return out;
    }
  }

  Tuple2<String, String> getUnicodeBlockAndFeature(Runes runes, int index) {
    if (runes.length <= index) {
      return const Tuple2('', '999');
    } else {
      final value = runes.elementAt(index);
      final i = codeBlocks.firstWhere((element) => value < element);
      return Tuple2(String.fromCharCode(value), i.toString().padLeft(3, '0'));
    }
  }

  Iterable<String> getFeature(
      String w1,
      String w2,
      String w3,
      String w4,
      String w5,
      String w6,
      String b1,
      String b2,
      String b3,
      String b4,
      String b5,
      String b6,
      String p1,
      String p2,
      String p3) {
    return [
      // UP is means unigram of previous results.
      'UP1:$p1',
      'UP2:$p2',
      'UP3:$p3',
      // BP is means bigram of previous results.
      'BP1:$p1$p2',
      'BP2:$p2$p3',
      // UW is means unigram of words.
      'UW1:$w1',
      'UW2:$w2',
      'UW3:$w3',
      'UW4:$w4',
      'UW5:$w5',
      'UW6:$w6',
      // BW is means bigram of words.
      'BW1:$w2$w3',
      'BW2:$w3$w4',
      'BW3:$w4$w5',
      // TW is means trigram of words.
      'TW1:$w1$w2$w3',
      'TW2:$w2$w3$w4',
      'TW3:$w3$w4$w5',
      'TW4:$w4$w5$w6',
      // UB is means unigram of unicode blocks.
      'UB1:$b1',
      'UB2:$b2',
      'UB3:$b3',
      'UB4:$b4',
      'UB5:$b5',
      'UB6:$b6',
      // BB is means bigram of unicode blocks.
      'BB1:$b2$b3',
      'BB2:$b3$b4',
      'BB3:$b4$b5',
      // TB is means trigram of unicode blocks.
      'TB1:$b1$b2$b3',
      'TB2:$b2$b3$b4',
      'TB3:$b3$b4$b5',
      'TB4:$b4$b5$b6',
      // UQ is combination of UP and UB.
      'UQ1:$p1$b1',
      'UQ2:$p2$b2',
      'UQ3:$p3$b3',
      // BQ is combination of UP and BB.
      'BQ1:$p2$b2$b3',
      'BQ2:$p2$b3$b4',
      'BQ3:$p3$b2$b3',
      'BQ4:$p3$b3$b4',
      // TQ is combination of UP and TB.
      'TQ1:$p2$b1$b2$b3',
      'TQ2:$p2$b2$b3$b4',
      'TQ3:$p3$b1$b2$b3',
      'TQ4:$p3$b2$b3$b4',
    ];
  }
}
