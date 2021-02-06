import 'package:firebase_auth/firebase_auth.dart';

Map<String, String> handleFirebaseError(FirebaseAuthException error) {
  switch (error.code) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
    case "account-exists-with-different-credential":
    case "email-already-in-use":
      return {
        'title': 'email já usado',
        'content': 'o email já está sendo usado em outra conta',
      };

    case "ERROR_INVALID_EMAIL":
    case "invalid-email":
      return {
        'title': 'email inválido',
        'content': 'o seu endereço de email fornecido é invalido',
      };

    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return {
        'title': 'senha inválida',
        'content': 'a senha está incorreta',
      };

    case "ERROR_USER_NOT_FOUND":
    case "user-not-found":
      return {
        'title': 'usuário não encontrado',
        'content': 'ainda não existe uma conta para o usuário informado',
      };

    case "ERROR_USER_DISABLED":
    case "user-disabled":
      return {
        'title': 'usuário bloqueado',
        'content':
            'esse usuário foi bloqueado por desrespeitar as políticas da plataforma',
      };

    case "ERROR_TOO_MANY_REQUESTS":
    case "operation-not-allowed":
      return {
        'title': 'muitas tentativas',
        'content':
            'foram realizadas muitas tentativas de login em pouco tempo, tente novamente mais tarde',
      };

    case "ERROR_OPERATION_NOT_ALLOWED":
    case "operation-not-allowed":
      return {
        'title': 'proibido',
        'content': 'o login a esta conta não é permitido',
      };

    default:
      return {
        'title': 'ocorreu uma situação inesperada',
        'content': 'tente novamente mais tarde'
      };
  }
}
