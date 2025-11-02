class LocalizationMap {
  static Map<String, String> get codesEN => {
        //Root Bottom Nav
        "Home": "Home",

        "Please wait...": "Please wait...",
        "Loading...": "Loading...",
        "An error occurred while fetching data.": "An error occurred while fetching data.",
      };

  static String getTranslatedValues(String key) {
    return codesEN[key] ?? "Text not found";
  }
}
