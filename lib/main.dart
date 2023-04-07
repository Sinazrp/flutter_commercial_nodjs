import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/constants/global_variable.dart';
import 'package:flutter_commercial_nodjs/features/auth/screens/auth_screen.dart';
import 'package:flutter_commercial_nodjs/router.dart';

import 'logic/bloc_token/token_bloc.dart';
import 'logic/bloc_user/user_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => UserBloc(),
      ),
      BlocProvider(
        create: (context) => TokenBloc(),
      ),
    ],
    child: BlocBuilder<TokenBloc, TokenState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              useMaterial3: true,
              colorScheme: const ColorScheme.light(
                  primary: GlobalVariables.secondaryColor)),
          darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: const ColorScheme.dark(
                  primary: GlobalVariables.secondaryColor)),
          themeMode: ThemeMode.light,
          onGenerateRoute: (settings) => generateRoute(settings),
          home: const AuthScreen(),
        );
      },
    ),
  ));
}
