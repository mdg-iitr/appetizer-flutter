import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/presentation/app/bloc/app_bloc.dart';
import 'package:appetizer/presentation/components/app_formfield.dart';
import 'package:appetizer/presentation/components/app_textfield.dart';
import 'package:appetizer/presentation/components/loading_indicator.dart';
import 'package:appetizer/presentation/components/made_by_mdg.dart';
import 'package:appetizer/presentation/components/raise_query_button.dart';
import 'package:appetizer/presentation/login/components/channeli_button.dart';
import 'package:appetizer/presentation/login/components/login_button.dart';
import 'package:appetizer/presentation/login/bloc/login_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class LoginWrapper extends StatelessWidget {
  const LoginWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}

class NoOverScroll extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

@RoutePage()
class LoginScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(userRepository: context.read()),
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 32.toAutoScaledHeight),
          child: const MadeByMDG(),
        ),
        body: ScrollConfiguration(
          behavior: NoOverScroll(),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'assets/images/login.png',
                  width: 360.toAutoScaledWidth,
                ),
                20.toVerticalSizedBox,
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  height: 63.toAutoScaledHeight,
                  width: 168.toAutoScaledWidth,
                ),
                30.toVerticalSizedBox,
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.toAutoScaledWidth),
                  child: BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        context.read<AppBloc>().add(const GetUser());
                      }
                      if (state is LoginInitial && state.error != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error!),
                          ),
                        );
                        _controller.clear();
                        _controller2.clear();
                      }
                    },
                    builder: (context, state) {
                      if (state is Loading || state is LoginSuccess) {
                        _controller.clear();
                        _controller2.clear();
                        return const Center(child: LoadingIndicator());
                      }
                      if (state is CreatePassword) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppFormField(
                              controller: _controller,
                              hintText: 'Create Password',
                              obscureText: !state.showPassword,
                              suffix: IconButton(
                                onPressed: () {
                                  context.read<LoginBloc>().add(
                                        ToggleObscureCreatePassword(
                                          showPassword: !state.showPassword,
                                          showConfirmPassword:
                                              state.showConfirmPassword,
                                        ),
                                      );
                                },
                                icon: Icon(
                                  state.showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: const Color(0xFF757575),
                                ),
                              ),
                              title: 'Set Password',
                            ),
                            10.toVerticalSizedBox,
                            AppTextField(
                              controller: _controller2,
                              hintText: 'Confirm Password',
                              obscureText: !state.showConfirmPassword,
                              suffix: IconButton(
                                onPressed: () {
                                  context.read<LoginBloc>().add(
                                        ToggleObscureCreatePassword(
                                          showPassword: state.showPassword,
                                          showConfirmPassword:
                                              !state.showConfirmPassword,
                                        ),
                                      );
                                },
                                icon: Icon(
                                  state.showConfirmPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: const Color(0xFF757575),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.toAutoScaledHeight,
                              child: Text(
                                state.error ?? '',
                                style: GoogleFonts.lato(
                                  fontSize: 10.toAutoScaledFont,
                                  color: const Color(0xFF2F2F2F),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Center(
                              child: LoginButton(
                                text: 'Login',
                                onPressed: () {
                                  context.read<LoginBloc>().add(
                                        SetPassword(
                                          _controller.text,
                                          _controller2.text,
                                          state.enrollmentNo,
                                          state.user,
                                        ),
                                      );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppFormField(
                            hintText: state is EnterPassword
                                ? "Password"
                                : state is ForgotPasswordState
                                    ? "Email id"
                                    : 'Enrollment No.',
                            title: state is ForgotPasswordState
                                ? 'Forgot Password'
                                : 'Login/SignUp',
                            controller: _controller,
                            obscureText: state is EnterPassword
                                ? !state.showPassword
                                : false,
                            suffix: state is EnterPassword
                                ? IconButton(
                                    onPressed: () {
                                      context
                                          .read<LoginBloc>()
                                          .add(ShowPasswordPressed());
                                    },
                                    icon: Icon(
                                      state.showPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: const Color(0xFF757575),
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                          state is EnterPassword
                              ? SizedBox(
                                  height: 30.toAutoScaledHeight,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.error ?? '',
                                        style: GoogleFonts.lato(
                                          fontSize: 10.toAutoScaledFont,
                                          color: const Color(0xFF2F2F2F),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      if (state is! ForgotPasswordState)
                                        TextButton(
                                          onPressed: () {
                                            // TODO: send to fogot password screen
                                            context
                                                .read<LoginBloc>()
                                                .add(ForgotPasswordPressed());
                                          },
                                          child: Text(
                                            'Forgot Password?',
                                            style: GoogleFonts.lato(
                                              fontSize: 10.toAutoScaledFont,
                                              color: const Color(0xFF2F2F2F),
                                              fontWeight: FontWeight.w400,
                                              textStyle: const TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                )
                              : 20.toVerticalSizedBox,
                          Center(
                            child: LoginButton(
                              text: state is EnterPassword ? 'Login' : 'Next',
                              onPressed: () {
                                state is EnterPassword
                                    ? context.read<LoginBloc>().add(
                                        LoginPressed(_controller.text,
                                            state.enrollmentNo))
                                    : state is ForgotPasswordState
                                        ? context.read<LoginBloc>().add(
                                            SendPasswordResetInstructions(
                                                emailId: _controller.text))
                                        : context
                                            .read<LoginBloc>()
                                            .add(NextPressed(_controller.text));
                              },
                            ),
                          ),
                          state is LoginInitial
                              ? Center(
                                  child: ChanneliButton(
                                    callback: (code) {
                                      context
                                          .read<LoginBloc>()
                                          .add(NewUserSignUp(code: code));
                                    },
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      );
                    },
                  ),
                ),
                const RaiseQueryButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
