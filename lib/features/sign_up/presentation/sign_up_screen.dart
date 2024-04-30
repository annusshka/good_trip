import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/domain/models/access_level.dart';
import 'package:good_trip/core/presentation/bloc/auth/auth_state.dart';
import 'package:good_trip/core/theme/theme.dart';

import '../../../core/domain/models/user.dart';
import '../../../core/presentation/bloc/auth/auth_bloc.dart';
import '../../../core/presentation/bloc/auth/auth_event.dart';
import '../../../core/presentation/widgets/logo.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _showPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.pink_,
        //resizeToAvoidBottomInset: , не меняет размер под клавиатурой
        // вручную исп viewingsets
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthenticatedState) {
              AutoRouter.of(context).push(const AppNavigationRoute());
            }
            if (state is AuthErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is UnauthenticatedState) {
              return Stack(children: [
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      top: MediaQuery.sizeOf(context).height * 0.1,
                    ),
                    child: const Logo()),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(10.0),
                    reverse: true,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        decoration: BoxDecoration(color: colors.white),
                        padding: const EdgeInsets.all(25.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Register new account',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Text(
                                'Please log in to your account',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400, //regular
                                  color: colors.gray,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.name,
                                controller: _nameController,
                                decoration: InputDecoration(
                                  hintText: "Name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: colors.lightGray2),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  counterStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null && value.length < 2
                                      ? 'Enter a valid name'
                                      : null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.name,
                                controller: _surnameController,
                                decoration: InputDecoration(
                                  hintText: "Surname",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: colors.lightGray2),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  counterStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null && value.length < 2
                                      ? 'Enter a valid surname'
                                      : null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: colors.lightGray2),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  counterStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null &&
                                          !EmailValidator.validate(value)
                                      ? 'Enter a valid email'
                                      : null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                controller: _phoneController,
                                decoration: InputDecoration(
                                  hintText: "Phone",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: colors.lightGray2),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  counterStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value == null
                                      ? 'Enter a valid phone'
                                      : null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _passwordController,
                                obscureText: !_showPassword,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: colors.lightGray2),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      _toggleVisibility();
                                    },
                                    child: Icon(
                                      _showPassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: colors.darkGray,
                                    ),
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null && value.length < 6
                                      ? "Enter min. 6 characters"
                                      : null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  color: colors.pink_,
                                  width: double.infinity,
                                  child: TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _authenticateWithEmailAndPassword(
                                            context);
                                      }
                                    },
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Already have an account? ",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      AutoRouter.of(context)
                                          .push(const SignInRoute());
                                      /*
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const SignInScreen()
                                            ),
                                          );*/
                                    },
                                    child: const Text(
                                      "Sign In",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]);
            }
            return Container();
          },
        ));
  }

  void _toggleVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _authenticateWithEmailAndPassword(context) {
    //if (_formKey.currentState!.validate()) {
    // If email is valid adding new event [SignUpRequested].
    User user = User(
        name: _nameController.text,
        surname: _surnameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
        role: AccessLevel.user,
        id: '',
        accessToken: '',
        refreshToken: '');
    BlocProvider.of<AuthBloc>(context).add(
      SignUpRequested(user),
    );
    //}
  }
/*
  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }

   */
}
