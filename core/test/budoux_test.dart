import 'package:budoux/budoux.dart';
import 'package:test/test.dart';

void main() {
  group('budouX', () {
    group('ja knbc', () {
      const b = Budoux();
      test('parse `これはテストです。` into [これは, テストです。]', () {
        expect(b.parse('これはテストです。'), ['これは', 'テストです。']);
      });
      test('parse `日本語の文章をいい感じに分割します。` into [日本語の,文章を,いい感じに,分割します。]', () {
        expect(
            b.parse('日本語の文章をいい感じに分割します。'), ['日本語の', '文章を', 'いい感じに', '分割します。']);
      });
    });
  });
}
