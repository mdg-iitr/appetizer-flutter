import 'package:appetizer_revamp_parts/ui/login/components/login_button.dart';
import 'package:appetizer_revamp_parts/ui/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: <Widget>[
              Image.asset('assets/images/login.png'),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/logo.png',
                  scale: 1.5,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is EnterPassword) {
                      _controller.clear();
                    }
                  },
                  builder: (context, state) {
                    if (state is Loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is CreatePassword) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Set Password',
                            style: GoogleFonts.notoSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'Create Password',
                              hintStyle: GoogleFonts.lato(
                                fontSize: 12,
                                color: const Color(0xFF111111),
                                fontWeight: FontWeight.w600,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: const Color(0xFF111111)
                                        .withOpacity(0.25)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _controller,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              hintStyle: GoogleFonts.lato(
                                fontSize: 12,
                                color: const Color(0xFF111111),
                                fontWeight: FontWeight.w600,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: const Color(0xFF111111)
                                        .withOpacity(0.25)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: Text(
                              state.error ?? '',
                              style: GoogleFonts.lato(
                                fontSize: 10,
                                color: const Color(0xFF2F2F2F),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Center(
                              child: LoginButton(
                                  text: 'Login',
                                  onPressed: () {
                                    context.read<LoginBloc>().add(LoginPressed(
                                          _controller.text,
                                        ));
                                  })),
                        ],
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login/SignUp',
                          style: GoogleFonts.notoSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _controller,
                          obscureText: state is EnterPassword
                              ? !state.showPassword
                              : false,
                          decoration: InputDecoration(
                            hintText: state is EnterPassword
                                ? "Password"
                                : 'Enrollment No.',
                            hintStyle: GoogleFonts.lato(
                              fontSize: 12,
                              color: const Color(0xFF111111),
                              fontWeight: FontWeight.w600,
                            ),
                            suffixIcon: state is EnterPassword
                                ? IconButton(
                                    onPressed: () {
                                      BlocProvider.of<LoginBloc>(context).add(
                                        ShowPasswordPressed(),
                                      );
                                    },
                                    icon: state.showPassword
                                        ? const Icon(Icons.visibility,
                                            color: Color(0xFF757575))
                                        : const Icon(Icons.visibility_off,
                                            color: Color(0xFF757575)))
                                : null,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: const Color(0xFF111111)
                                      .withOpacity(0.25)),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ),
                        state is EnterPassword
                            ? SizedBox(
                                height: 30,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      state.error ?? '',
                                      style: GoogleFonts.lato(
                                        fontSize: 10,
                                        color: const Color(0xFF2F2F2F),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Forgot Password?',
                                        style: GoogleFonts.lato(
                                          fontSize: 10,
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
                            : const SizedBox(height: 20),
                        Center(
                            child: LoginButton(
                                text: state is EnterPassword ? 'Login' : 'Next',
                                onPressed: () {
                                  state is EnterPassword
                                      ? context
                                          .read<LoginBloc>()
                                          .add(LoginPressed(
                                            _controller.text,
                                          ))
                                      : context
                                          .read<LoginBloc>()
                                          .add(NextPressed(_controller.text));
                                })),
                      ],
                    );
                  },
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Raise a Query',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF008BFF),
                    fontWeight: FontWeight.w400,
                    textStyle: const TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
