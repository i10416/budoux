import 'model_data.dart';

class Model {
  const Model({required this.underlying});
  factory Model.fromJson(Map<String, double> json) => Model(underlying: json);
  const Model.jaKNBC() : this(underlying: model);
  final Map<String, double> underlying;

  bool contains(String key) => underlying.containsKey(key);
  double? get(String key) => underlying[key];
}
