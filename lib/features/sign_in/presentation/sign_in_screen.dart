import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:good_trip/core/presentation/bloc/auth/auth_event.dart';
import 'package:good_trip/core/presentation/bloc/auth/auth_state.dart';
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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/splash.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10.0),
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
                            'Добро пожаловать',
                            style: AppTextTheme.semiBold20,
                          ),
                          Text(
                            'Пожалуйста, войдите в свой аккаунт',
                            style: AppTextTheme.semiBold14.copyWith(
                              color: AppColors.lightGray,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            cursorColor: AppColors.gray,
                            cursorErrorColor: AppColors.red,
                            cursorRadius: const Radius.circular(3.0),
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: AppTextTheme.semiBold18.copyWith(
                                color: AppColors.lightGray,
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1.0,
                                  color: AppColors.lightGray,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1.0,
                                  color: AppColors.lightGray,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.red,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.red,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              errorStyle: AppTextTheme.semiBold10,
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            style: AppTextTheme.semiBold18.copyWith(
                              color: AppColors.gray,
                            ),
                            validator: (value) {
                              return value != null && !EmailValidator.validate(value) ? 'Неправильный email' : null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _passwordController,
                            obscureText: !_showPassword,
                            cursorColor: AppColors.gray,
                            cursorErrorColor: AppColors.red,
                            cursorRadius: const Radius.circular(3.0),
                            decoration: InputDecoration(
                              hintText: 'Пароль',
                              hintStyle: AppTextTheme.semiBold18.copyWith(
                                color: AppColors.lightGray,
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
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1.0,
                                  color: AppColors.lightGray,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1.0,
                                  color: AppColors.lightGray,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.red,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.red,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              errorStyle: AppTextTheme.semiBold10,
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            style: AppTextTheme.semiBold18.copyWith(
                              color: AppColors.gray,
                            ),
                            validator: (value) {
                              return value != null && value.length < 6 ? 'Введите минимум 6 символов' : null;
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
                                  'Войти',
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
                              Text(
                                'Ещё нет аккаунта? ',
                                style: AppTextTheme.semiBold14.copyWith(
                                  color: AppColors.lightGray,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.router.popAndPush(const SignUpRoute());
                                },
                                child: Text(
                                  'Зарегистрироваться',
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
            );
          },
        ),
      ),
    );
  }

  void _toggleVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
}
