// Dart imports:
import 'dart:async';

// Package imports:
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:syphon/global/values.dart';
import 'package:syphon/store/auth/credential/model.dart';
import 'package:syphon/store/user/model.dart';

part 'state.g.dart';

@JsonSerializable()
class AuthStore extends Equatable {
  final User user;

  @JsonKey(ignore: true)
  User get currentUser => user;

  @JsonKey(ignore: true)
  final StreamController<User> authObserver;

  @JsonKey(ignore: true)
  Stream<User> get onAuthStateChanged =>
      authObserver != null ? authObserver.stream : null;

  // Interactive Auth Data
  final String session;

  final Credential credential;
  final List<String> completed;
  final Map<String, dynamic> interactiveAuths;

  // temp state values for signup
  final String email;
  final String username;
  final String password;
  final String passwordCurrent;
  final String passwordConfirm;
  final String homeserver;
  final String loginType;
  final bool agreement;
  final bool captcha;

  // temp state statuses for signup
  final bool loading;
  final bool stopgap;
  final bool creating;
  final bool verificationNeeded;
  final bool isEmailValid;
  final bool isEmailAvailable;
  final bool isUsernameValid;
  final bool isPasswordValid;
  final bool isHomeserverValid;
  final bool isUsernameAvailable;

  const AuthStore({
    this.user = const User(),
    this.authObserver,
    this.email = '',
    this.username = '', // null
    this.password = '', // null
    this.passwordCurrent = '', // null
    this.passwordConfirm = '',
    this.agreement = false,
    this.captcha = false,
    this.session,
    this.completed = const [],
    this.homeserver = Values.homeserverDefault,
    this.loginType = 'm.login.dummy',
    this.interactiveAuths = const {},
    this.isEmailValid = false,
    this.isEmailAvailable = true,
    this.isUsernameValid = false,
    this.isUsernameAvailable = false,
    this.isPasswordValid = false,
    this.isHomeserverValid = true,
    this.credential,
    this.stopgap = false,
    this.creating = false,
    this.loading = false,
    this.verificationNeeded = false,
  });

  @override
  List<Object> get props => [
        user,
        authObserver,
        username,
        password,
        passwordConfirm,
        passwordCurrent,
        agreement,
        captcha,
        homeserver,
        completed,
        session,
        loginType,
        isEmailValid,
        isEmailAvailable,
        isUsernameValid,
        isPasswordValid,
        isHomeserverValid,
        isUsernameAvailable,
        interactiveAuths,
        credential,
        loading,
        creating,
        verificationNeeded,
      ];

  AuthStore copyWith({
    user,
    email,
    loading,
    username,
    password,
    passwordConfirm,
    passwordCurrent,
    agreement,
    homeserver,
    completed,
    captcha,
    session,
    isHomeserverValid,
    isUsernameValid,
    isUsernameAvailable,
    isPasswordValid,
    isEmailValid,
    isEmailAvailable,
    interactiveAuths,
    interactiveStages,
    credential,
    creating,
    verificationNeeded,
    authObserver,
  }) =>
      AuthStore(
        user: user ?? this.user,
        email: email ?? this.email,
        loading: loading ?? this.loading,
        authObserver: authObserver ?? this.authObserver,
        username: username ?? this.username,
        password: password ?? this.password,
        agreement: agreement ?? this.agreement,
        passwordCurrent: passwordCurrent ?? this.passwordCurrent,
        passwordConfirm: passwordConfirm ?? this.passwordConfirm,
        homeserver: homeserver ?? this.homeserver,
        completed: completed ?? this.completed,
        captcha: captcha ?? this.captcha,
        session: session ?? this.session,
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isEmailAvailable: isEmailAvailable ?? this.isEmailAvailable,
        isUsernameValid: isUsernameValid ?? this.isUsernameValid,
        isUsernameAvailable: isUsernameAvailable != null
            ? isUsernameAvailable
            : this.isUsernameAvailable,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isHomeserverValid: isHomeserverValid ?? this.isHomeserverValid,
        interactiveAuths: interactiveAuths ?? this.interactiveAuths,
        credential: credential ?? this.credential,
        creating: creating ?? this.creating,
        stopgap: stopgap ?? this.stopgap,
        verificationNeeded: verificationNeeded ?? this.verificationNeeded,
      );

  Map<String, dynamic> toJson() => _$AuthStoreToJson(this);

  factory AuthStore.fromJson(Map<String, dynamic> json) =>
      _$AuthStoreFromJson(json);
}
