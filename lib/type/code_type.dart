enum CodeType {
  LOGIN,
  FIND_PASSWORD,
  CANCEL_ACCOUNT,
  UPDATE_PHONE,
}

extension CodeTypeExtention on CodeType {
  String get value =>
      ['LOGIN', 'FIND_PASSWORD', 'CANCEL_ACCOUNT', 'UPDATE_PHONE'][index];
}
