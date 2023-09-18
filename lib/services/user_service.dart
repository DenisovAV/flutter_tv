import 'package:flutter_tv/domain/user.dart';

abstract class UserService {
  Future<MoviesUser?> getUser();
}
