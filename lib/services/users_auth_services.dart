import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:loxcorpserv/components/functions.dart';
import 'package:loxcorpserv/config/config.dart';
import 'package:loxcorpserv/services/base_api.dart';
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
      print("###############: Login: ${resData}");
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

  /*
   * reset user password
   */
  Future forgotPasswordService(List<dynamic> data) async {
    //=====check internet===========//
    if (await getConnectionStatus() == true) {
      print("#################: ${data}");
      return data;
    }
  }
}
