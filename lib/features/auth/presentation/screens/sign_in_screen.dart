// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:streamskit_mobile/core/app/colors/app_color.dart';
import 'package:streamskit_mobile/core/util/sizer_custom/sizer.dart';
import 'package:streamskit_mobile/core/util/styles/style.dart';
import 'package:streamskit_mobile/features/app/bloc/app_bloc.dart';
import 'package:streamskit_mobile/features/app/screens/scaffold_wrapper.dart';
import 'package:streamskit_mobile/features/auth/domain/entities/auth_type.dart';
import 'package:streamskit_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:streamskit_mobile/features/auth/presentation/widgets/sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return ScaffoldWrapper(
          isLoading: state is Authenticating,
          child: Scaffold(
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10.sp),
                  Image.asset(
                    appIcon,
                    height: 60.sp,
                    width: 60.sp,
                  ),
                  SizedBox(height: 38.sp),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.sp,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w700,
                                    height: 1.46,
                                  ),
                              children: [
                                const TextSpan(
                                  text: 'Watch Your \nFavourite Creators ',
                                ),
                                TextSpan(
                                  text: 'LIVE',
                                  style: TextStyle(color: colorPurple),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.sp),
                          Text(
                            'Watch your favourite creators live. \nChat, Interact and unlimited fun.',
                            softWrap: true,
                            strutStyle: StrutStyle.disabled,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w300,
                                  height: 1.4,
                                ),
                          ),
                          SizedBox(height: 100.sp),
                          SignInButton(
                            title: 'Continue with Google',
                            iconAsset: logoGoogle,
                            onPressed: () {
                              AppBloc.authBloc.add(
                                const SignInEvent(
                                  authType: AuthType.google,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 40.sp),
                          RichText(
                            text: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    fontSize: 11.5.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                              children: [
                                const TextSpan(
                                  text: 'By signing up, you agree to our ',
                                ),
                                TextSpan(
                                  text: 'Terms, Privacy Policy',
                                  style: TextStyle(color: colorPink),
                                ),
                                const TextSpan(
                                  text: ' and ',
                                ),
                                TextSpan(
                                  text: 'Cookie Use.',
                                  style: TextStyle(color: colorPink),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30.sp),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
