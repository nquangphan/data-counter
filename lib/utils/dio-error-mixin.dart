import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin DioErrorHandler {
  void handleError(BuildContext context, dynamic error) {
    showDialog(
      barrierColor: Colors.white,
      context: context,
      builder: (_context) {
        if (error is DioError) {
          if (error.type == DioErrorType.response) {
            return responseError(error);
          } else {
            return otherError(error);
          }
        } else {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            contentPadding: EdgeInsets.all(12.0),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('REQUEST ERROR',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Divider()
              ],
            ),
            content: Container(
              child: Text('${error.toString()}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          );
        }
      },
    );
  }

  Widget responseError(DioError error) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      contentPadding: EdgeInsets.all(12.0),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('HTTP ERROR',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          Divider()
        ],
      ),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Error code: ${error.response!.statusCode.toString()}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('${error.message}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget otherError(DioError error) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      contentPadding: EdgeInsets.all(12.0),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('REQUEST ERROR',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          Divider()
        ],
      ),
      content: Container(
        child: Text('${error.type.name}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

extension on DioErrorType {
  String get name {
    String name = '';
    switch (this) {
      case DioErrorType.receiveTimeout:
        {
          name = 'Receive Timeout';
          break;
        }
      case DioErrorType.sendTimeout:
        {
          name = 'Send Timeout';
          break;
        }
      case DioErrorType.connectTimeout:
        {
          name = 'Connect Timeout';
          break;
        }
      case DioErrorType.response:
        {
          name = 'Response Error';
          break;
        }
      case DioErrorType.cancel:
        {
          name = 'Cancel request';
          break;
        }
      case DioErrorType.other:
        {
          name = 'Unknow error';
          break;
        }
    }
    return name;
  }
}
