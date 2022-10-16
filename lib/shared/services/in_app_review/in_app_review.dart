import 'package:in_app_review/in_app_review.dart';

class AppReviewServ {
  static final InAppReview inAppReview = InAppReview.instance;

  static void requestReview() async {
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  static void openStoreListing() async {
    if (await inAppReview.isAvailable()) {
      inAppReview.openStoreListing();
    }
  }
}
