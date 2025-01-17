class Token {
  final String token;
  final String refreshToken;
  final String userId;
  final DateTime expiryDate;

  const Token(
      {required this.token,
      required this.refreshToken,
      required this.expiryDate,
      required this.userId});
}
