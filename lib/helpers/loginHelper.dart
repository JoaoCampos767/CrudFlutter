import 'package:sla/model/loginModel.dart';

class LoginHelper {
  String validaLogin(LoginModel login) {
    var _msg;

    if (login.email.isNotEmpty) {
    } else {
      _msg = "E-mail é obrigatório, por favor preencha o mesmo!";
    }

    return _msg;
  }
}
