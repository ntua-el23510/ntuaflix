import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ntuaflix/shared/api_client.dart';
import 'package:ntuaflix/shared/extensions/dio_extension.dart';
import 'package:ntuaflix/shared/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

AuthState? initialState;

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(initialState ?? const Unauthorized()) {
    on<Register>(_onRegister);
    on<Login>(_onLogin);
    on<Logout>(_onLogout);
    on<UpdateUser>(_onUpdateUser);
  }

  /// Function that loads user and bearer token if these are stored in local storage
  static loadinitialState() async {
    /// Obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    var userString = prefs.getString('user');
    var token = prefs.getString('token');
    if (userString != null) {
      Map<String, dynamic> json = jsonDecode(userString);

      User user = (User.fromJson(json));
      if (token != null) {
        user.setToken = token;
        AppAPIClient().bearer = user.token;
        initialState = Authorized(await getUserData());
      } else {
        initialState = const Unauthorized();
      }
    }
  }

  static Future<User?> getUserData() async {
    var userDataRequest = await AppAPIClient().client.get("/auth/user");
    User loggedUser = User.fromJson(userDataRequest.data["data"]);
    return loggedUser;
  }

  Future _onRegister(Register event, Emitter<AuthState> emit) async {
    try {
      await AppAPIClient().client.post("/auth/register", data: {
        "name": event.nickname,
        "email": event.email,
        "password": event.password,
        "password_confirmation": event.password
      });
      event.onSuccess?.call();
    } catch (e) {
      e as DioException;
      e.showFormErrors(event.formKey);
      var responseData = e.response?.data as Map<String, dynamic>?;
      event.onError?.call(responseData?["message"]);
    }
  }

  _onLogin(Login event, Emitter<AuthState> emit) async {
    try {
      var loginRequest = await AppAPIClient().client.post("/auth/login", data: {
        "email": event.email,
        "password": event.password,
      });
      String token = loginRequest.data['token'];
      AppAPIClient().bearer = token;
      User? userData = await getUserData()
        ?..setToken = token;
      var prefs = await SharedPreferences.getInstance();
      await prefs.setString("user", jsonEncode(userData?.toJson()));
      await prefs.setString("token", token);
      event.onSuccess?.call();
      await Future.delayed(
        2000.ms,
        () {
          emit(Authorized(userData));
        },
      );
    } catch (e) {
      e as DioException;
      e.showFormErrors(event.formKey);
      var responseData = e.response?.data as Map<String, dynamic>?;
      event.onError?.call(responseData?["message"]);
    }
  }

  _onLogout(Logout event, Emitter<AuthState> emit) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.clear();
    AppAPIClient().bearer = null;
    emit(const Unauthorized());
    event.onSuccess?.call();
  }

  _onUpdateUser(UpdateUser event, Emitter<AuthState> emit) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString("user", jsonEncode(event.user.toJson()));
    emit(Authorized(event.user));
    event.onSuccess?.call();
  }
}
