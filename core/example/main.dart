import 'package:budoux/budoux.dart';

void main() {
  const b = Budoux();
  // ignore: avoid_print
  print(b.parse('これはテストです。')); // => [これは, テストです。]
}
