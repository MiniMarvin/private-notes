validateEmail(value) {
  if (value.isEmpty) {
    return 'o email não pode estar vazio';
  }
  var regex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
  );

  if (regex.allMatches(value).isEmpty) {
    return 'email inválido';
  }

  return null;
}

validatePassword(value) {
  if (value.length < 6) {
    return 'A senha precisa de pelo menos 6 caracteres';
  }
  return null;
}
