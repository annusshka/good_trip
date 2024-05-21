import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/domain/models/account/access_level.dart';

import '../../../core/app_router/app_router.dart';
import '../../../core/presentation/bloc/auth/auth.dart';
import '../../../core/presentation/widgets/widgets.dart';
import '../../../core/theme/theme.dart';

@RoutePage()
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            if (state.user.role == AccessLevel.USER) {
              AutoRouter.of(context).push(const NavBarUserRoute());
            } else if (state.user.role == AccessLevel.ADMIN) {
              AutoRouter.of(context).push(const NavBarAdminRoute());
            }
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
                  padding: const EdgeInsets.all(10),
                  reverse: true,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      decoration: BoxDecoration(color: colors.white),
                      padding: const EdgeInsets.all(25),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome Back',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            //const SizedBox(height: 10,),
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
                                      BlocProvider.of<AuthBloc>(context).add(
                                        SignInRequested(_emailController.text,
                                            _passwordController.text),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    'Sign In',
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
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    AutoRouter.of(context)
                                        .push(const SignUpRoute());
                                  },
                                  child: const Text(
                                    "Sign Up",
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
      ),
    );
  }

  void _toggleVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
}
