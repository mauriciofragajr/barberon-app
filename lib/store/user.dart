import 'package:barberOn/models/user.dart';
import 'package:mobx/mobx.dart';
part 'user.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  @observable
  User user;

  @action
  void setUser(String uid) {
    user = User(uid: uid);
  }
}
