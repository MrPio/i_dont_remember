import 'package:i_dont_remember/model/user.dart' as user;

abstract class JSONSerializable {
  static Map<Type, Function> modelFactories = {
    user.User: user.User.fromJson,
  };
  factory JSONSerializable.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
  Map<String, dynamic> toJSON();
}
