import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nusantara/features/login/viewmodel/login_viewmodel.dart';
import 'package:flutter_nusantara/widgets/button_custom.dart';
import 'package:flutter_nusantara/widgets/formfield_custom.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginViewModel vm;
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final ValueNotifier<bool> _isVisible = ValueNotifier(true);

  void login(context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    vm.login(_emailController.text, _passwordController.text, context);
  }

  @override
  void initState() {
    vm = Provider.of<LoginViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.home_outlined, size: 100),
                const SizedBox(height: 20),
                const Text(
                  'Login',
                ),
                const SizedBox(height: 15),
                const Text(
                  'Welcome home, have a nice day!',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormCustom(
                          controller: _emailController,
                          hintText: 'Email',
                          validator: (email) {
                            if (email != null &&
                                !EmailValidator.validate(email)) {
                              return 'Enter a valid email';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: ValueListenableBuilder(
                          valueListenable: _isVisible,
                          builder: ((context, value, child) {
                            return TextFormCustom(
                              controller: _passwordController,
                              hintText: 'Password',
                              validator: (value) {
                                if (value != null && value.length < 8) {
                                  return 'Enter min 8 characters';
                                } else {
                                  return null;
                                }
                              },
                              valueListenablePass: _isVisible,
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Consumer<LoginViewModel>(
                          builder: (context, value, child) {
                        if (value.isLoading) {
                          return ButtonFormCustom(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Loading',
                                  )
                                ],
                              ));
                        }
                        return ButtonFormCustom(
                          child: Text('Login'),
                          onPressed: () => login(context),
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Dont have an account? '),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text('Sign Up'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
