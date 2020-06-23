import 'package:mobx/mobx.dart';
part 'user.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  @observable
  String uid;

  @action
  void setUid(String uid) {
    uid = uid;
  }
}
