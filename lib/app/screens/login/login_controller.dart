import 'package:barberOn/app/stores/auth_store.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final AuthStore authStore;

  _LoginControllerBase(this.authStore);

  @observable
  String email;
  @action
  changeEmail(String value) => email = value;

  @observable
  String password;
  @action
  changePassword(String value) => password = value;

  @observable
  String errorMessage;
  @action
  changeErrorMessage(String value) => errorMessage = value;

  @action
  Future<String> signInWithGoogle() async {
    changePassword(null);
    changeErrorMessage(null);
    try {
      String result = await authStore.signInWithGoogle();
      if (result != null) {
        changeErrorMessage(result);
      }
      return result;
    } catch (e) {
      print(e.toString());
      return 'Erro ao efetuar login. Tente novamente.';
    }
  }

  @action
  Future<String> signIn() async {
    changeErrorMessage(null);
    try {
      String result =
          await authStore.signInWithEmailAndPassword(email, password);
      if (result != null) {
        changeErrorMessage(result);
      }
      changePassword(null);
      return result;
    } catch (e) {
      print(e.toString());
      changePassword(null);
      return 'Erro ao efetuar login. Tente novamente.';
    }
  }
}
