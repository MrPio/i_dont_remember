import 'package:flutter/material.dart';
import 'package:i_dont_remember/enum/fonts.dart';
import 'package:i_dont_remember/enum/measures.dart';
import 'package:i_dont_remember/enum/palette.dart';
import 'package:i_dont_remember/extension/function/context_extensions.dart';
import 'package:i_dont_remember/extension/function/string_extensions.dart';
import 'package:i_dont_remember/extension/mixin/loadable.dart';
import 'package:i_dont_remember/manager/account_manager.dart';
import 'package:i_dont_remember/manager/io_manager.dart';
import 'package:i_dont_remember/model/user.dart';

import 'partial/glass_button.dart';
import 'partial/glass_text_field.dart';
import 'partial/loading_view.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with Loadable {
  late final TextEditingController _usernameController,
      _emailController,
      _passwordController;
  bool _passwordVisible = false;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _emailController = TextEditingController(text: 'valeriomorelli50@gmail.com')
      ..addListener(() {
        setState(() {});
      });
    _passwordController = TextEditingController(text: 'aaaaaa');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background
          Container(),
          // Header + Body
          Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Measures.hPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  SizedBox(
                      width: double.infinity,
                      child: Text('Benvenuto!', style: Fonts.black())),
                  const SizedBox(
                    height: Measures.vMarginThin,
                  ),
                  // Subtitle
                  Text(
                      'Crea un account per creare i tuoi personaggi, partecipare a campagne e molto altro!',
                      style: Fonts.light()),
                  const SizedBox(
                    height: Measures.vMarginMed,
                  ),
                  // Username TextField
                  GlassTextField(
                      iconPath: 'person',
                      hintText: 'Inserisci il tuo username',
                      textController: _usernameController,
                      clearable: true,
                      keyboardType: TextInputType.name),
                  const SizedBox(height: Measures.vMarginSmall),
                  // Email TextField
                  GlassTextField(
                      iconPath: 'email',
                      hintText: 'Inserisci la tua email',
                      textController: _emailController,
                      clearable: true,
                      keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: Measures.vMarginSmall),
                  // Password TextField
                  GlassTextField(
                    iconPath: 'password',
                    secondaryIconPath:
                        _passwordVisible ? 'visibility_on' : 'visibility_off',
                    obscureText: !_passwordVisible,
                    hintText: 'Inserisci la tua password',
                    textController: _passwordController,
                    clearable: false,
                    onSecondaryIconTap: () {
                      setState(() => _passwordVisible = !_passwordVisible);
                    },
                  ),
                  const SizedBox(height: Measures.vMarginMed),
                  // SignIn button
                  GlassButton(
                    'REGISTRATI',
                    color: Palette.primary,
                    onTap: signUp,
                  ),
                  const SizedBox(height: Measures.vMarginSmall),
                  // Or line
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Palette.card,
                          height: 1,
                        ),
                      ),
                      const SizedBox(width: Measures.hMarginMed),
                      Text('Oppure', style: Fonts.light(size: 14)),
                      const SizedBox(width: Measures.hMarginMed),
                      Expanded(
                        child: Container(
                          color: Palette.card,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Measures.vMarginSmall),
                  // Google button
                  GlassButton(
                    'Registrati con Google',
                    color: Palette.primary,
                    outlined: true,
                    iconPath: 'google',
                    onTap: signInWithGoogle,
                  ),
                  const SizedBox(height: Measures.vMarginMed),
                  // SignIn line
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Hai già un account?', style: Fonts.light(size: 14)),
                      const SizedBox(width: 6),
                      GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed('/signin'),
                          child: Text('Accedi al tuo account',
                              style: Fonts.regular(
                                  size: 14, color: Palette.primary))),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // LoadingView
          LoadingView(visible: isLoading)
        ],
      ),
    );
  }

  signUp() => withLoading(() async{
        if (!await IOManager().hasInternetConnection(context)) {
          return;
        }
        if (!_usernameController.text.isUsername) {
          context.snackbar('Per favore inserisci un nome utente valido',
              backgroundColor: Palette.primary);
        } else if (!_emailController.text.isEmail) {
          context.snackbar('Per favore inserisci una email valida',
              backgroundColor: Palette.primary);
        } else {
          SignUpStatus status = await AccountManager().signUp(
              _emailController.text,
              _passwordController.text,
              User(
                  nickname: _usernameController.text,
                  email: _emailController.text));
          if (status == SignUpStatus.weakPassword) {
            context.snackbar('La password è troppo corta!',
                backgroundColor: Palette.error);
          } else if (status == SignUpStatus.emailInUse) {
            context.snackbar('L\'email è già in uso!',
                backgroundColor: Palette.error);
          } else if (status == SignUpStatus.genericError) {
            context.snackbar('Errore generico!',
                backgroundColor: Palette.error);
          } else if (status == SignUpStatus.success) {
            context.snackbar('Benvenuto ${AccountManager().user.nickname}!',
                backgroundColor: Palette.primary, bottomMargin: Measures.bottomBarHeight);
            Navigator.of(context).pushNamed('/home');
          }
        }
      });

  signInWithGoogle() => withLoading(() async {
        if (!await IOManager().hasInternetConnection(context)) {
          return;
        }
        SignInStatus status = await AccountManager().signInWithGoogle();
        if (status == SignInStatus.googleProviderError) {
          context.snackbar('Errore nell\'accesso a Google',
              backgroundColor: Palette.error);
        } else if (status == SignInStatus.userNotInDatabase) {
          context.snackbar('L\'account non è più esistente!',
              backgroundColor: Palette.error);
        } else if (status == SignInStatus.success) {
          context.snackbar('Bentornato ${AccountManager().user.nickname}!',
              backgroundColor: Palette.primary, bottomMargin: Measures.bottomBarHeight);
          Navigator.of(context).pushNamed('/home');
        } else if (status == SignInStatus.successNewAccount) {
          context.snackbar('Benvenuto ${AccountManager().user.nickname}!',
              backgroundColor: Palette.primary, bottomMargin: Measures.bottomBarHeight);
          Navigator.of(context).pushNamed('/home');
        }
      });
}
