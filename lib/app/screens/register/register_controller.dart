import 'package:barberOn/app/stores/auth_store.dart';
import 'package:mobx/mobx.dart';
part 'register_controller.g.dart';

class RegisterController = _RegisterControllerBase with _$RegisterController;

abstract class _RegisterControllerBase with Store {
  final AuthStore authStore;

  _RegisterControllerBase(this.authStore);

  @observable
  String email;
  @action
  changeEmail(String value) => email = value;

  @observable
  String password;
  @action
  changePassword(String value) => password = value;

  @observable
  String confirmPassword;
  @action
  changeConfirmPassword(String value) => confirmPassword = value;

  @observable
  String errorMessage;
  @action
  changeErrorMessage(String value) => errorMessage = value;

  @action
  Future<String> register() async {
    changeErrorMessage(null);
    try {
      if (!_validatePasswords()) {
        String invalidMessage = 'As senhas não coincidem';
        changeErrorMessage(invalidMessage);
        return invalidMessage;
      }
      String result =
          await authStore.registerWithEmailAndPassword(email, password);
      if (result != null) {
        changeErrorMessage(result);
      }

      return result;
    } catch (e) {
      print(e.toString());
      return 'Erro ao efetuar login. Tente novamente.';
    }
  }

  bool _validatePasswords() {
    return password == confirmPassword;
  }
}
