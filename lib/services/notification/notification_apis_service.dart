// import 'package:dio/dio.dart';

// class NotificationApiService {
//   // final dioClient = locator<NotificationsConfig>();

//   Future<ParentApiResponse> sendNotificationToVendor(
//       {required SendNotification notification}) async {
//     Response? response;
//     DioError? error;
//     try {
//       response = await dioClient
//           .getDio()
//           .post(SEND_NOTIFICATION, data: notification.toJson());
//     } on DioError catch (e) {
//       error = e;
//     }
//     return ParentApiResponse(response: response, error: error);
//   }
// }
