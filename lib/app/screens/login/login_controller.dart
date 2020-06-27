import 'package:barberOn/app/stores/auth_store.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final AuthStore authStore;

  _LoginControllerBase(this.authStore);

  @observable
  String email;

  @observable
  String password;

  @observable
  String errorMessage;

  @action
  Future<String> signInWithGoogle() async {
    print('LoginController: Chamando login com google');
    try {
      return await authStore.signInWithGoogle();
    } catch (e) {
      print(e.toString());
      return 'Erro ao efetuar login. Tente novamente.';
    }
  }
}
