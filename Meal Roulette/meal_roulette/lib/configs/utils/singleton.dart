class Singleton {
  static String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9";
  static Map<String, String> header = {"token": token};
  static Map<String, String> headerNoAuth = {'Accept': 'application/json'};

  static int? selectedMensaId = 0;

}
