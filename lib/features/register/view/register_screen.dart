import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_nusantara/features/register/viewmodel/register_viewmodel.dart';
import 'package:flutter_nusantara/widgets/button_custom.dart';
import 'package:flutter_nusantara/widgets/formfield_custom.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  final ValueNotifier<bool> _isVisible = ValueNotifier(true);

  final ValueNotifier<bool> _isVisible2 = ValueNotifier(true);

  late RegisterViewModel vm;

  void register(context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    vm.register(_nameController.text, _emailController.text,
        _passwordController.text, _confirmPasswordController.text, context);
  }

  @override
  void initState() {
    super.initState();
    vm = Provider.of<RegisterViewModel>(context, listen: false);

    /// Run method on Widget build complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // FocusScope.of(context).requestFocus(_initialFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.home, size: 100),
                    const SizedBox(height: 20),
                    const Text(
                      'Register',
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Lets Started!',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextFormCustom(
                              controller: _nameController,
                              hintText: 'Name',
                              validator: (value) {
                                if (value == '') {
                                  return 'Tidak boleh kosong';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormCustom(
                                controller: _emailController,
                                validator: (email) {
                                  if (email != null &&
                                      !EmailValidator.validate(email)) {
                                    return 'Enter a valid email';
                                  } else {
                                    return null;
                                  }
                                },
                                hintText: 'Email',
                              )),
                          const SizedBox(height: 10),
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
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: ValueListenableBuilder(
                              valueListenable: _isVisible2,
                              builder: ((context, value, child) {
                                return TextFormCustom(
                                  controller: _confirmPasswordController,
                                  hintText: 'Confirm Password',
                                  validator: (value) {
                                    if (value != null &&
                                        value != _passwordController.text) {
                                      return 'Password not match';
                                    } else {
                                      return null;
                                    }
                                  },
                                  valueListenablePass: _isVisible2,
                                );
                              }),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Consumer<RegisterViewModel>(
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
                              onPressed: () => register(context),
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: const Icon(Icons.arrow_back),
        ));
  }
}
