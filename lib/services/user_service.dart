import 'package:flutter_tv/domain/user.dart';

abstract class UserService {
  Stream<MoviesUser?> getUser();
}
