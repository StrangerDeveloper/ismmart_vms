import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ismmart_vms/helper/common_function.dart';
import 'package:ismmart_vms/helper/errors.dart';
import 'package:ismmart_vms/helper/global_variables.dart';
import 'package:ismmart_vms/helper/urls.dart';
import 'package:ismmart_vms/widgets/custom_snackbar.dart';

import 'constants.dart';

class ApiBaseHelper {
  final String _baseUrl = Urls.baseUrl;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${GlobalVariable.token}',
  };

  Future<dynamic> getMethod({required String url}) async {
    try {
      Uri urlValue = Uri.parse(_baseUrl + url);
      CommonFunction.debugPrint(
          '*********************** Request ********************************');
      CommonFunction.debugPrint(urlValue);

      http.Response response = await http
          .get(urlValue, headers: header)
          .timeout(const Duration(seconds: 30));

      CommonFunction.debugPrint(
          '*********************** Response ********************************');
      CommonFunction.debugPrint(urlValue);
      CommonFunction.debugPrint(response.body);
      CommonFunction.colorConsole(
          '****************************************************************************************');

      Map<String, dynamic> parsedJSON = jsonDecode(response.body);
      return parsedJSON;
    } on SocketException catch (e) {
      debugPrint("$e");
      GlobalVariable.showLoader.value = false;
      CustomSnackBar.showSnackBar(
          title: 'Error', message: AppErrors.noInternetError);
      throw AppErrors.noInternetError;
    } on TimeoutException catch (_) {
      GlobalVariable.showLoader.value = false;
      CustomSnackBar.showSnackBar(
          title: 'Error', message: AppErrors.timeOutException);
      throw AppErrors.timeOutException;
    } on FormatException catch (_) {
      GlobalVariable.showLoader.value = false;
      CustomSnackBar.showSnackBar(
          title: 'Error', message: AppErrors.formatException);
      throw AppErrors.formatException;
    } catch (e) {
      GlobalVariable.showLoader.value = false;
      CustomSnackBar.showSnackBar(
          title: 'Error', message: AppErrors.generalApiError);
      throw e.toString();
    }
  }

  Future<dynamic> deleteMethod({required String url}) async {
    try {
      Uri urlValue = Uri.parse(_baseUrl + url);
      CommonFunction.debugPrint(
          '*********************** Request ********************************');
      CommonFunction.debugPrint(urlValue);

      http.Response response = await http
          .delete(urlValue, headers: header)
          .timeout(const Duration(seconds: 30));

      CommonFunction.debugPrint(
          '*********************** Response ********************************');
      CommonFunction.debugPrint(urlValue);
      CommonFunction.debugPrint(response.body);
      CommonFunction.colorConsole(
          '****************************************************************************************');

      Map<String, dynamic> parsedJSON = jsonDecode(response.body);
      return parsedJSON;
    } on SocketException catch (e) {
      debugPrint("$e");
      GlobalVariable.showLoader.value = false;
      CustomSnackBar.showSnackBar(
          title: 'Error', message: AppErrors.noInternetError);
      throw AppErrors.noInternetError;
    } on TimeoutException catch (_) {
      GlobalVariable.showLoader.value = false;
      CustomSnackBar.showSnackBar(
          title: 'Error', message: AppErrors.timeOutException);
      throw AppErrors.timeOutException;
    } on FormatException catch (_) {
      GlobalVariable.showLoader.value = false;
      CustomSnackBar.showSnackBar(
          title: 'Error', message: AppErrors.formatException);
      throw AppErrors.formatException;
    } catch (e) {
      GlobalVariable.showLoader.value = false;
      CustomSnackBar.showSnackBar(
          title: 'Error', message: AppErrors.generalApiError);
      throw e.toString();
    }
  }

  Future<dynamic> postMethod({
    required String url,
    Object? body,
  }) async {
    try {
      if (body != null) {
        body = jsonEncode(body);
      }
      Uri urlValue = Uri.parse(_baseUrl + url);
      CommonFunction.debugPrint(
          '*********************** Request ********************************');
      CommonFunction.debugPrint(urlValue);
      CommonFunction.debugPrint(body);

      http.Response response = await http
          .post(urlValue, headers: header, body: body)
          .timeout(const Duration(seconds: 30));

      CommonFunction.debugPrint(
          '*********************** Response ********************************');
      CommonFunction.debugPrint(urlValue);
      CommonFunction.debugPrint(response.body);
      CommonFunction.colorConsole(
          '****************************************************************************************');

      Map<String, dynamic> parsedJSON = jsonDecode(response.body);
      return parsedJSON;
    } on SocketException catch (_) {
      GlobalVariable.showLoader.value = false;
      CustomSnackBar.showSnackBar(
          title: 'Error', message: AppErrors.noInternetError);
      throw AppErrors.noInternetError;
    } on TimeoutException catch (_) {
      GlobalVariable.showLoader.value = false;
      CustomSnackBar.showSnackBar(
          title: 'Error', message: AppErrors.timeOutException);
      throw AppErrors.timeOutException;
    } on FormatException catch (_) {
      GlobalVariable.showLoader.value = false;
      CustomSnackBar.showSnackBar(
          title: 'Error', message: AppErrors.formatException);
      throw AppErrors.formatException;
    } catch (e) {
      GlobalVariable.showLoader.value = false;
      CustomSnackBar.showSnackBar(
          title: 'Error', message: AppErrors.generalApiError);
      throw e.toString();
    }
  }

  Future<dynamic> putMethod({
    required String url,
    Object? body,
  }) async {
    try {
      if (body != null) {
        body = jsonEncode(body);
      }
      Uri urlValue = Uri.parse(_baseUrl + url);
      CommonFunction.debugPrint(
          '*********************** Request ********************************');
      CommonFunction.debugPrint(urlValue);
      CommonFunction.debugPrint(body);

      http.Response response = await http
          .put(urlValue, headers: header, body: body)
          .timeout(const Duration(seconds: 30));

      CommonFunction.debugPrint(
          '*********************** Response ********************************');
      CommonFunction.debugPrint(urlValue);
      CommonFunction.debugPrint(response.body);
      CommonFunction.colorConsole(
          '****************************************************************************************');

      Map<String, dynamic> parsedJSON = jsonDecode(response.body);
      return parsedJSON;
    } on SocketException catch (_) {
      GlobalVariable.showLoader.value = false;
      CustomSnackBar.showSnackBar(
          title: 'Error', message: AppErrors.noInternetError);
      throw AppErrors.noInternetError;
    } on TimeoutException catch (_) {
      GlobalVariable.showLoader.value = false;
      CustomSnackBar.showSnackBar(
          title: 'Error', message: AppErrors.timeOutException);
      throw AppErrors.timeOutException;
    } on FormatException catch (_) {
      GlobalVariable.showLoader.value = false;
      CustomSnackBar.showSnackBar(
          title: 'Error', message: AppErrors.formatException);
      throw AppErrors.formatException;
    } catch (e) {
      GlobalVariable.showLoader.value = false;
      CustomSnackBar.showSnackBar(
          title: 'Error', message: AppErrors.generalApiError);
      throw e.toString();
    }
  }


  Future<dynamic> postMethodForImage({
    required String url,
    required List<http.MultipartFile> files,
    required Map<String, String> fields,
  }) async {
    try {
      Uri urlValue = Uri.parse(_baseUrl + url);
      debugPrint('*********************** Request ********************************');
      debugPrint("$urlValue");

      http.MultipartRequest request = http.MultipartRequest('POST', urlValue);
      request.headers.remove('Content-Type');
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer ${GlobalVariable.token}',
      });
      request.fields.addAll(fields);
      request.files.addAll(files);

      http.StreamedResponse response = await request.send();
      Map<String, dynamic> parsedJson =
          await jsonDecode(await response.stream.bytesToString());

      debugPrint(
          '*********************** Response ********************************');
      debugPrint("$urlValue");
      debugPrint(parsedJson.toString());
      AppConstant.colorConsole(
          '****************************************************************************************');
      return parsedJson;
    } on SocketException catch (_) {
      GlobalVariable.showLoader.value = false;
      GlobalVariable.noInternet(true);
      //AppConstant.displaySnackBar(titlege)(title, message: AppErrors.noInternetError);
      throw AppErrors.noInternetError;
    } on TimeoutException catch (_) {
      GlobalVariable.showLoader.value = false;
      AppConstant.displaySnackBar('Error', AppErrors.timeOutException);
      throw AppErrors.timeOutException;
    } on FormatException catch (_) {
      GlobalVariable.showLoader.value = false;
      AppConstant.displaySnackBar('Error', AppErrors.formatException);
      throw AppErrors.formatException;
    } catch (e) {
      GlobalVariable.showLoader.value = false;
      AppConstant.displaySnackBar('Error', AppErrors.generalApiError);
      throw e.toString();
    }
  }

  Future<dynamic> putMethodForImage({
    required String url,
    required List<http.MultipartFile> files,
    required Map<String, String> fields,
  }) async {
    try {
      Uri urlValue = Uri.parse(_baseUrl + url);
      debugPrint('*********************** Request ********************************');
      debugPrint("$urlValue");

      http.MultipartRequest request = http.MultipartRequest('PUT', urlValue);
      request.headers.addAll(header);
      request.fields.addAll(fields);
      request.files.addAll(files);
      http.StreamedResponse response = await request.send();
      Map<String, dynamic> parsedJson =
      await jsonDecode(await response.stream.bytesToString());

      debugPrint(
          '*********************** Response ********************************');
      debugPrint("$urlValue");
      debugPrint(parsedJson.toString());
      AppConstant.colorConsole(
          '****************************************************************************************');
      return parsedJson;
    } on SocketException catch (_) {
      GlobalVariable.showLoader.value = false;
      GlobalVariable.noInternet(true);
      //AppConstant.displaySnackBar(titlege)(title, message: AppErrors.noInternetError);
      throw AppErrors.noInternetError;
    } on TimeoutException catch (_) {
      GlobalVariable.showLoader.value = false;
      AppConstant.displaySnackBar('Error', AppErrors.timeOutException);
      throw AppErrors.timeOutException;
    } on FormatException catch (_) {
      GlobalVariable.showLoader.value = false;
      AppConstant.displaySnackBar('Error', AppErrors.formatException);
      throw AppErrors.formatException;
    } catch (e) {
      GlobalVariable.showLoader.value = false;
      AppConstant.displaySnackBar('Error', AppErrors.generalApiError);
      throw e.toString();
    }
  }

  // Future<dynamic> patchMethodForImage({
  //   required String url,
  //   required List<http.MultipartFile> files,
  //   required Map<String, String> fields,
  //   bool withBearer = false,
  //   bool withAuthorization = false,
  // }) async {
  //   try {
  //     Map<String, String> header = {'Content-Type': 'multipart/form-data'};
  //
  //     if (withAuthorization) {
  //       header['Authorization'] = withBearer ? 'Bearer $token' : token;
  //     }
  //     Uri urlValue = Uri.parse(_baseUrl + url);
  //     print('*********************** Request ********************************');
  //     print(urlValue);
  //
  //     http.MultipartRequest request = http.MultipartRequest('PATCH', urlValue);
  //
  //     request.headers.addAll(header);
  //     request.fields.addAll(fields);
  //     request.files.addAll(files);
  //     http.StreamedResponse response = await request.send();
  //     Map<String, dynamic> parsedJson =
  //         await jsonDecode(await response.stream.bytesToString());
  //
  //     print(
  //         '*********************** Response ********************************');
  //     print(urlValue);
  //     print(parsedJson.toString());
  //     AppConstant.colorConsole(
  //         '****************************************************************************************');
  //     return parsedJson;
  //   } on SocketException catch (_) {
  //     GlobalVariable.showLoader.value = false;
  //     GlobalVariable.internetErr(true);
  //     //AppConstant.displaySnackBar(titlege)(title, message: AppErrors.noInternetError);
  //    // throw AppErrors.noInternetError;
  //   } on TimeoutException catch (_) {
  //     GlobalVariable.showLoader.value = false;
  //     AppConstant.displaySnackBar('Error', AppErrors.timeOutException);
  //     throw AppErrors.timeOutException;
  //   } on FormatException catch (_) {
  //     GlobalVariable.showLoader.value = false;
  //     AppConstant.displaySnackBar('Error', AppErrors.formatException);
  //     throw AppErrors.formatException;
  //   } catch (e) {
  //     GlobalVariable.showLoader.value = false;
  //     AppConstant.displaySnackBar('Error', AppErrors.generalApiError);
  //     throw e.toString();
  //   }
  // }
}
