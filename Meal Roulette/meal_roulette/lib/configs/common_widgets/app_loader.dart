class AppLoader {
  static final AppLoader _instance = AppLoader._internal();

  AppLoader._internal();

  factory AppLoader() => _instance;

  void showLoader() {
    /*showDialog(
      context: rootNavigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: R.colors.transparent,
          content: Center(
            child: SizedBox(
                height: 40.h,
                width: 40.w,
                child: CircularProgressIndicator(
                  color: R.colors.progressBarDrawColor,
                  strokeWidth: 10,
                )),
          ),
        );
      },
    );*/
  }

  void hideLoader() {
    // Navigator.of(getContext(), rootNavigator: true).pop();
  }
}
