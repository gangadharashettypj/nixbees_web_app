/*
 * @Author GS
 */
import 'package:firebase_database/firebase_database.dart';
import 'package:payment_gateway/main.dart';
import 'package:payment_gateway/model/response.dart';

class FirebaseCrud {
  static FirebaseCrud _instance;
  static FirebaseCrud get instance {
    _instance ??= FirebaseCrud();
    return _instance;
  }

  Future<Response> set(String path, dynamic data) async {
    logger.i('Inserting data into: $path');
    await FirebaseDatabase.instance
        .reference()
        .child(path)
        .set(data)
        .catchError((e) {
      logger.i('Error while inserting: $e');
      return Response(
        code: 400,
        status: false,
        errorMessage: e,
      );
    });
    logger.i('Data inserted successfully');
    return Response(
      code: 201,
      status: true,
      message: 'successful',
    );
  }

  Future<Response> setPush(String path, dynamic data) async {
    logger.i('Inserting data into: $path');
    await FirebaseDatabase.instance
        .reference()
        .child(path)
        .push()
        .set(data)
        .catchError((e) {
      logger.i('Error while inserting: $e');
      return Response(
        code: 400,
        status: false,
        errorMessage: e,
      );
    });
    logger.i('Data inserted successfully');
    return Response(
      code: 201,
      status: true,
      message: 'successful',
    );
  }

  Future<Response> update(String path, Map<String, dynamic> data) async {
    logger.i('Updating data into: $path');
    await FirebaseDatabase.instance
        .reference()
        .child(path)
        .update(data)
        .catchError((e) {
      logger.i('Error while updating: $e');
      return Response(
        code: 400,
        status: false,
        errorMessage: e,
      );
    });
    logger.i('Data updated successfully');
    return Response(
      code: 201,
      status: true,
      message: 'successful',
    );
  }

  Future<dynamic> read(String path, {bool cache = false}) async {
    logger.i('Getting data from: $path');
    DataSnapshot snap =
        await FirebaseDatabase.instance.reference().child(path).once();
    logger.i('Got data: ${snap.value}');
    return snap.value;
  }
}
