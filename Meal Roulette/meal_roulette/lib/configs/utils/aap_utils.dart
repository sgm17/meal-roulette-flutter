
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meal_roulette/configs/common_models/parent_response.dart';
import 'package:meal_roulette/configs/common_widgets/app_loader.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';
import 'package:meal_roulette/configs/utils/singleton.dart';
import 'package:meal_roulette/routes/app_routes.dart';

class Utils {
  void showCustomModalBottomSheet({required BuildContext context, required Widget widget}) {
    showModalBottomSheet<void>(
      context: context,
      scrollControlDisabledMaxHeightRatio: double.infinity,
      useSafeArea: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0.w)),
      ),
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 16.h,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                  color: R.colors.veryLightGrey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.w),
                    topRight: Radius.circular(20.w),
                  )),
            ),
            widget
          ],
        );
      },
    );
  }

  static SnackBar getSnackBar(String message) {
    return SnackBar(
      backgroundColor: R.colors.veryLightGrey,
      elevation: 2.0,
      showCloseIcon: true,
      closeIconColor: R.colors.primaryColor,
      content: Center(
        child: Text(
          message,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          style: R.textStyles.font14M.copyWith(color: R.colors.primaryColor),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }


  List<T>? get5OrFullList<T>(bool flag, List<T>? list, {int sizeToGet = 5}) {
    if (list == null || list.isEmpty == true) return list;

    if (flag) {
      return list;
    } else {
      return list.take(sizeToGet).toList();
    }
  }

  Future<ParentResponse> getApiResponse({required String url, required Map<String, dynamic> body}) async {
    AppLoader().showLoader();
    var commonResponse = ParentResponse();
    var response = Response(requestOptions: RequestOptions());
    final Dio dio = Dio();

    try {
      response = await dio.get(
        url,
        data: body,
        options: Options(method: 'GET', headers: Singleton.header, contentType: 'application/json'),
      );

      if (response.statusCode == 200) {
        commonResponse = ParentResponse.fromJson(response.data);

        if (commonResponse.status != 200 || response.data == null) {
          final errorMessage = response.data['message'] ?? R.strings.anErrorOccurredWhileFetchingData;
          ScaffoldMessenger.of(rootNavigatorKey.currentContext!).showSnackBar(
            Utils.getSnackBar(errorMessage),
          );
        }
      } else {
        final errorMessage = response.data['message'] ?? R.strings.anErrorOccurredWhileFetchingData;
        ScaffoldMessenger.of(rootNavigatorKey.currentContext!).showSnackBar(
          Utils.getSnackBar(errorMessage),
        );
      }
    } catch (e) {
      // Cast 'e' to DioException to access the 'response' field
      if (e is DioException && e.response != null && e.response?.data != null) {
        // Extract the error message from the response data
        var errorMessage = "";
        try {
          errorMessage = e.response?.data['message'] ?? R.strings.anErrorOccurredWhileFetchingData;
        } catch (error) {
          errorMessage = e.response?.statusMessage ?? R.strings.anErrorOccurredWhileFetchingData;
        }
        ScaffoldMessenger.of(rootNavigatorKey.currentContext!).showSnackBar(
          Utils.getSnackBar(errorMessage),
        );
      } else {
        // Fallback for cases where the exception is not a DioException or no response data is available
        ScaffoldMessenger.of(rootNavigatorKey.currentContext!).showSnackBar(
          Utils.getSnackBar(e.toString()),
        );
      }
    } finally {
      AppLoader().hideLoader();
    }
    return commonResponse;
  }
}

extension StringUtils on String? {

  String? changeDateFormat(String outputFormat) {
    if (this == null || this?.isEmpty == true) return "";

    // Parse the date string into a DateTime object
    DateTime parsedDateTime = DateTime.parse(this!);

    // Format the time to outputFormat
    return DateFormat(outputFormat).format(parsedDateTime);
  }

  double? convertStringToDouble() {
    if (this == null || this?.isEmpty == true) return 0;
    return double.tryParse(this ?? "0.0");
  }

  int? convertStringToInt() {
    if (this == null || this?.isEmpty == true) return 0;
    return int.tryParse(this ?? "0.0");
  }

  Color getHexStringToColor() {
    if (this == null || this?.isEmpty == true) return R.colors.transparent;

    var hexColor = this?.toUpperCase().replaceAll("#", "");
    if (hexColor?.length == 6) {
      hexColor = "FF$hexColor"; // Add 100% opacity if not specified
    }
    return Color(int.parse(hexColor!, radix: 16));
  }

}

