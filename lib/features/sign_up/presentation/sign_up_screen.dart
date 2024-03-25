import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/presentation/bloc/auth/auth_state.dart';
import 'package:good_trip/core/presentation/widgets/nav_bar/navigation_bar.dart';
import 'package:good_trip/core/theme/theme.dart';
import 'package:good_trip/features/sign_in/presentation/sign_in_screen.dart';

import '../../../core/domain/models/user.dart';
import '../../../core/presentation/bloc/auth/auth_bloc.dart';
import '../../../core/presentation/bloc/auth/auth_event.dart';
import '../../../core/presentation/widgets/screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticatedState) {
              // Navigating to the dashboard screen if the user is authenticated
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const AppNavigationBar(),
                ),
              );
            }
            if (state is AuthErrorState) {
              // Displaying the error message if the user is not authenticated
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            if (state is AuthLoadingState) {
              // Displaying the loading indicator while the user is signing up
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AuthUnauthenticatedState) {
              // Displaying the sign up form if the user is not authenticated
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
                                  Text('Register new account',
                                    style:
                                    Theme.of(context).textTheme.labelLarge,),
                                  Text('Please log in to your account',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400, //regular
                                      color: colors.gray,
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
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
                                      return value != null && value.length < 2
                                          ? 'Enter a valid name'
                                          : null;
                                    },
                                  ),
                                  const SizedBox(height: 10,),
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
                                      return value != null && value.length < 2
                                          ? 'Enter a valid surname'
                                          : null;
                                    },
                                  ),
                                  const SizedBox(height: 10,),
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
                                    keyboardType: TextInputType.phone,
                                    controller: _phoneController,
                                    decoration: InputDecoration(
                                      hintText: "Phone",
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
                                      return value == null
                                          ? 'Enter a valid phone'
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
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 1, color: colors.lightGray2),
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
                                        child: const Text('Sign Up',
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
                                      const Text("Already have an account? ",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const SignIn()
                                            ),
                                          );
                                        },
                                        child: const Text("Sign In",),
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
      User user = User(firstName: _nameController.text,
          lastName: _surnameController.text,
          email: _emailController.text, phone: _phoneController.text,
          password: _passwordController.text, id: 1, accessToken: '', refreshToken: '');
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