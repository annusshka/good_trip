import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:good_trip/core/presentation/bloc/auth/auth_event.dart';
import 'package:good_trip/core/presentation/bloc/auth/auth_state.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';

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
      backgroundColor: AppColors.pink,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            if (state.user.role == AccessLevel.USER) {
              context.router.replace(const NavBarUserRoute());
            } else if (state.user.role == AccessLevel.ADMIN) {
              context.router.replace(const NavBarAdminRoute());
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
                    decoration: const BoxDecoration(color: AppColors.white),
                    padding: const EdgeInsets.all(25),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome Back',
                            style: AppTextTheme.semiBold20,
                          ),
                          //const SizedBox(height: 10,),
                          const Text(
                            'Please log in to your account',
                            style: AppTextTheme.normal14,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: AppColors.lightGrayEA),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              counterStyle: AppTextTheme.normal16,
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
                              hintText: 'Password',
                              //hintStyle: ,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: AppColors.lightGrayEA),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: _toggleVisibility,
                                child: Icon(
                                  _showPassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: AppColors.darkGray,
                                ),
                              ),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return value != null && value.length < 6
                                  ? 'Enter min. 6 characters'
                                  : null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              color: AppColors.pink,
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<AuthBloc>(context).add(
                                      SignInRequested(
                                        _emailController.text,
                                        _passwordController.text,
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  'Sign In',
                                  style: AppTextTheme.semiBold15.copyWith(
                                    color: AppColors.white,
                                  ),
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
                                style: AppTextTheme.normal14,
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.router.replace(const SignUpRoute());
                                },
                                child: Text(
                                  'Sign Up',
                                  style: AppTextTheme.semiBold15.copyWith(
                                    color: AppColors.pink,
                                  ),
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
