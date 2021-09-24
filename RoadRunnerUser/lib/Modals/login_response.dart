class LoginResponse {
  final String access_token;
  final String refresh_token;
  final String token_type;

  LoginResponse(this.access_token, this.refresh_token,this.token_type);

  LoginResponse.fromJson(Map<String, dynamic> json)
      : access_token=json["access_token"],
          refresh_token=json["refresh_token"],
          token_type=json["token_type"];

  LoginResponse.withError(String errorValue)
      : access_token = errorValue,
        refresh_token = errorValue,
        token_type = errorValue;
}