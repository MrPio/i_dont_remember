import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:i_dont_remember/enum/fonts.dart';
import 'package:i_dont_remember/enum/measures.dart';
import 'package:i_dont_remember/extension/function/context_extensions.dart';
import 'package:i_dont_remember/extension/function/string_extensions.dart';
import 'package:i_dont_remember/extension/mixin/loadable.dart';
import 'package:i_dont_remember/firebase_options.dart';
import 'package:i_dont_remember/manager/account_manager.dart';
import 'package:i_dont_remember/manager/data_manager.dart';
import 'package:i_dont_remember/manager/io_manager.dart';
import 'package:i_dont_remember/view/partial/glass_button.dart';
import 'package:i_dont_remember/view/partial/glass_checkbox.dart';
import 'package:i_dont_remember/view/partial/glass_text_field.dart';
import 'package:i_dont_remember/view/partial/loading_view.dart';

import '../enum/palette.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with Loadable {
  static bool _isInitialized = false;
  late final TextEditingController _emailController, _passwordController;
  bool _passwordVisible = false, _rememberMe = true;

  @override
  void initState() {
    if (!_isInitialized) {
      _isInitialized = true;
      Future.delayed(Duration.zero, () async {
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
        IOManager().init();
        if (!await IOManager().hasInternetConnection(context)) {
          return;
        }
        // 👤👤👤 FIREBASE AUTH 👤👤👤
      if (await AccountManager().cacheSignIn()) {
        Navigator.of(context).pushNamed('/home');
        context.snackbar('Bentornato ${AccountManager().user.nickname}!',
            backgroundColor: Palette.primary, bottomMargin: Measures.bottomBarHeight);
      }

        // 📘📘📘 FIREBASE FIRESTORE 📘📘📘
        // ⚠️⚠️⚠️ DANGER ZONE ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
        // ENCHANTMENTS =========================================
        // await DummyManager().populateEnchantments();
        // await IOManager().remove('enchantments_timestamp');
        // ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️

        withLoading(() => DataManager().fetchData());
      });
    }

    _emailController = TextEditingController(text: 'valeriomorelli50@gmail.com')
      ..addListener(() {
        setState(() {});
      });
    _passwordController = TextEditingController(text: 'aaaaaa');
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                      child: Text('Bentornato!', style: Fonts.black())),
                  const SizedBox(
                    height: Measures.vMarginThin,
                  ),
                  // Subtitle
                  Text(
                      'Per favore accedi al tuo account per poter utilizzare l’app.',
                      style: Fonts.light()),
                  const SizedBox(
                    height: Measures.vMarginMed,
                  ),
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
                  const SizedBox(height: Measures.vMarginThin),
                  // Remember me & forgot password
                  Row(
                    children: [
                      GlassCheckbox(
                        value: _rememberMe,
                        onChanged: () =>
                            setState(() => _rememberMe = !_rememberMe),
                        color: Palette.primary,
                      ),
                      Text('Ricordami', style: Fonts.light(size: 14)),
                      Expanded(child: Container()),
                      GestureDetector(
                          onTap: forgotPassword,
                          child: Text('Password dimenticata',
                              style: Fonts.regular(
                                  size: 14, color: Palette.primary))),
                    ],
                  ),
                  const SizedBox(height: Measures.vMarginSmall),
                  // SignIn button
                  GlassButton(
                    'ACCEDI',
                    color: Palette.primary,
                    onTap: signIn,
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
                    'Continua con Google',
                    color: Palette.primary,
                    outlined: true,
                    iconPath: 'google',
                    onTap: signInWithGoogle,
                  ),
                  const SizedBox(height: Measures.vMarginMed),
                  // Signup line
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Non hai un account?', style: Fonts.light(size: 14)),
                      const SizedBox(width: 6),
                      GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed('/signup'),
                          child: Text('Crea un account',
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

  signIn() => withLoading(() async {
        if (!await IOManager().hasInternetConnection(context)) {
          return;
        }
        if (!_emailController.text.isEmail) {
          context.snackbar('Per favore inserisci una email valida',
              backgroundColor: Palette.primary);
        } else {
          SignInStatus status = await AccountManager()
              .signIn(_emailController.text, _passwordController.text);
          if (status == SignInStatus.wrongCredentials) {
            context.snackbar('Le credenziali sono errate!',
                backgroundColor: Palette.error);
          } else if (status == SignInStatus.userNotInDatabase) {
            context.snackbar('L\'account non è più esistente!',
                backgroundColor: Palette.error);
          } else if (status == SignInStatus.success) {
            context.snackbar('Bentornato ${AccountManager().user.nickname}!',
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

  forgotPassword() async {
    final emailController = TextEditingController();
    context.popup(
      'Reset della password',
      message:
          'Inserisci l\'email dell\'account del quale vuoi reimpostare la password:',
      backgroundColor: Palette.popup,
      positiveText: 'Invia email',
      positiveCallback: () async {
        if (emailController.text.isEmail) {
          ResetPasswordStatus status =
              await AccountManager().resetPassword(emailController.text);
          if (status == ResetPasswordStatus.success) {
            context.snackbar(
                'Controlla il tuo indirizzo per reimpostare la password',
                backgroundColor: Palette.primary);
          } else {
            context.snackbar('Errore generico!',
                backgroundColor: Palette.error);
          }
        } else {
          context.snackbar('L\'email inserita non è valida',
              backgroundColor: Palette.error);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: Measures.vMarginMed),
        child: GlassTextField(
          iconPath: 'email',
          hintText: 'Inserisci la tua email',
          textController: emailController,
          clearable: false,
          keyboardType: TextInputType.emailAddress,
        ),
      ),
    );
  }
}
