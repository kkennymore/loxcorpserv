import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:loxcorpserv/components/functions.dart';
import 'package:loxcorpserv/config/config.dart';
import 'package:loxcorpserv/services/base_api.dart';
import 'package:loxcorpserv/services/local_storage.dart';
import 'package:loxcorpserv/services/string_sanitizer.dart';

class UserAuthService extends BaseApi {
  /*
   * process user login request
   */
  Future userLoginService(
    BuildContext context,
    emailController,
    passwordController,
  ) async {
    //=====check internet===========//
    if (await getConnectionStatus() == true) {
      /**make a post request*/
      var serverResp = await api.httpPost(
        login,
        postBodyData: {
          "email": await StringSanitizer()
              .spaceRemover(emailController.text.toString()),
          "password": await StringSanitizer()
              .spaceRemover(passwordController.text.toString()),
        },
        header: {
          "API_KEY": apiKey,
        },
      );
      /* decode the data received from the server
       */
      var resData = json.decode(serverResp.body);
      /*save to local storage */
      if (resData['status'] == true) {
        await LocalStorage().set('id', resData['data']['id'].toString());
        await LocalStorage()
            .set('username', resData['data']['username'].toString());
        await LocalStorage().set('email', resData['data']['email'].toString());
        await LocalStorage()
            .set('accountType', resData['data']['account_type'].toString());
        await LocalStorage()
            .set('date_joined', resData['data']['created_at'].toString());
        await LocalStorage().set(
            'date_verified', resData['data']['email_verified_at'].toString());
      }
      return resData;
    }
    return notInternet();
  }

  /*change the password */
  Future resetPasswordService(
    context,
    emailData,
    smsCodeController,
    passwordController,
  ) async {
    //=====check internet===========//
    if (await getConnectionStatus() == true) {
      /**make a post request*/
      var serverResp = await api.httpPost(
        resetPassword,
        postBodyData: {
          "email": emailData.toString(),
          "smsCode": smsCodeController.text.toString(),
          "password": passwordController!.text.toString(),
        },
        header: {
          "API_KEY": apiKey,
        },
      );
      /* decode the data received from the server
       */
      var resData = json.decode(serverResp.body);
      return resData;
    }
    return notInternet();
  }

  /*
   * process user registration request
   */
  Future userRegisterationService(
    BuildContext context,
    nameController,
    emailController,
    passwordController,
    agree,
    smsCode,
  ) async {
    //=====check internet===========//
    if (await getConnectionStatus() == true) {
      /**make a post request*/
      var serverResp = await api.httpPost(
        register,
        postBodyData: {
          "username": await StringSanitizer()
              .spaceRemover(nameController.text.toString()),
          "email": await StringSanitizer()
              .spaceRemover(emailController.text.toString()),
          "password": await StringSanitizer()
              .spaceRemover(passwordController.text.toString()),
          "smsCode": await StringSanitizer().spaceRemover(smsCode),
          "accountType": 0.toString(),
        },
        header: {
          "API_KEY": apiKey,
        },
      );
      /* decode the data received from the server
       */
      var resData = json.decode(serverResp.body);
      return resData;
    }
    return notInternet();
  }

  /* forgot password */
  Future forgotPasswordService(
    BuildContext context,
    TextEditingController? emailController,
    String? smsCode,
  ) async {
    //=====check internet===========//
    if (await getConnectionStatus() == true) {
      /**make a post request*/
      var serverResp = await api.httpPost(
        forgotPassword,
        postBodyData: {
          "email": await StringSanitizer()
              .spaceRemover(emailController!.text.toString()),
          "smsCode": smsCode,
        },
        header: {
          "API_KEY": apiKey,
        },
      );
      /* decode the data received from the server
       */
      var resData = json.decode(serverResp.body);
      return resData;
    }
    return notInternet();
  }

  Future logout(context) async {
    if (await LocalStorage().get("email") != "" ||
        await LocalStorage().get("email") != null) {
      /**delete all local data */
      await LocalStorage().delete(isAll: true);
    }
  }

  /*
   * verify user account
   */
  Future verifyAccountService(
    BuildContext context,
    emailController,
    smsCodeController,
    passwordController,
  ) async {
    //=====check internet===========//
    if (await getConnectionStatus() == true) {
      /**make a post request*/
      var serverResp = await api.httpPost(
        verify,
        postBodyData: {
          "email": await StringSanitizer().spaceRemover(emailController),
          "smsCode": await StringSanitizer()
              .spaceRemover(smsCodeController.text.toString()),
          "password": await StringSanitizer()
              .spaceRemover(passwordController.text.toString()),
        },
        header: {
          "API_KEY": apiKey,
        },
      );
      /* decode the data received from the server
       */

      var resData = json.decode(serverResp.body);
      return resData;
    }
    return notInternet();
  }
}
