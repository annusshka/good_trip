import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/presentation/bloc/auth/auth_state.dart';
import 'package:good_trip/core/presentation/widgets/nav_bar/navigation_bar.dart';
import 'package:good_trip/core/presentation/widgets/screen.dart';
import 'package:good_trip/core/theme/theme.dart';
import 'package:good_trip/features/sign_up/presentation/sign_up_screen.dart';

import '../../../core/domain/models/user.dart';
import '../../../core/presentation/bloc/auth/auth_bloc.dart';
import '../../../core/presentation/bloc/auth/auth_event.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.pink_,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticatedState) {
              // Navigating to the dashboard screen if the user is authenticated
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const AppNavigationBar()));
            }
            if (state is AuthErrorState) {
              // Showing the error message if the user has entered invalid credentials
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoadingState) {
                // Showing the loading indicator while the user is signing in
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is AuthUnauthenticatedState) {
                // Showing the sign in form if the user is not authenticated
                return Stack(
                  children: [
                    const Screen(),
                    Container(
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
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
                                    Text('Welcome Back',
                                      style:
                                      Theme.of(context).textTheme.labelLarge,),
                                    //const SizedBox(height: 10,),
                                    Text('Please log in to your account',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400, //regular
                                        color: colors.gray,
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
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
                                              width: 1,
                                              color: colors.lightGray2
                                          ),
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
                                    const SizedBox(height: 10,),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      controller: _passwordController,
                                      obscureText: !_showPassword,
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        //hintStyle: ,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: colors.lightGray2
                                          ),
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            _toggleVisibility();
                                          },
                                          child: Icon(_showPassword
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
                                    const SizedBox(height: 20,),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Container(
                                        color: colors.pink_,
                                        width: double.infinity,
                                        child: TextButton(
                                          onPressed: () {
                                            if (_formKey.currentState!.validate()) {
                                              _authenticateWithEmailAndPassword(context);
                                            }
                                          },
                                          child: const Text('Sign In',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text("Don't have an account? ",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                  const SignUp()
                                              ),
                                            );
                                          },
                                          child: const Text("Sign Up",),
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
                  ]
                );
            }
              return Container();
              },
          ),
        ));
  }

  void _toggleVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _authenticateWithEmailAndPassword(context) {
      User user = User(id: 1, email: _emailController.text,
          firstName: 'firstName', lastName: 'lastName',
          phone: 'phone', password: _passwordController.text,
          accessToken: '', refreshToken: '');
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(user),
      );
  }
}