# BudouX Dart

BudouX-Dart is a Dart port of [BudouX](https://github.com/google/budoux)

BudouX-Dart は BudouX の Dart 言語へのポートです. 日本語の文章のみためを整えて分割します.


## Install
```sh
dart pub add budoux
```


```yaml
dependencies:
  budoux: ^0.0.1
```

```sh
dart pub get
```
## example

### use default model

```dart

import 'package:budoux/budoux.dart';

void main() {
  const b = Budoux();
  // ignore: avoid_print
  print(b.parse('これはテストです。')); // => [これは, テストです。]
}

```

### use custom model

```dart
import 'package:budoux/budoux.dart';

void main() {
  const b = Budoux(model: Model.fromJson(/*your custom model json*/));
  // ignore: avoid_print
  print(b.parse('これはテストです。')); // => [これは, テストです。]
}

```

## test

```sh
dart run test
```
