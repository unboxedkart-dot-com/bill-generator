import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/logic/auth/auth_bloc.dart';
import 'package:unboxedkart/presentation/pages/authentication/create_user_page.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_alert_popup.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_input_widget.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class LoginUsingPopup extends StatefulWidget {
  final bool showProfile;
  const LoginUsingPopup({Key key, this.showProfile}) : super(key: key);

  @override
  State<LoginUsingPopup> createState() => _LoginUsingPopupState();
}

class _LoginUsingPopupState extends State<LoginUsingPopup> {
  final CustomAlertPopup _customPopup = CustomAlertPopup();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool isSentOtp = false;
  Timer countDownTimer;
  Duration myDuration = const Duration(seconds: 15);
  bool isErrorShown = false;

  startTimer() {
    countDownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setCountDown();
    });
  }

  stopTimer() {}

  resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(seconds: 15));
  }

  @override
  dispose() {
    super.dispose();
    if (countDownTimer != null) {
      countDownTimer.cancel();
    }
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countDownTimer.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  showCustomPopup(String title, String content) {
    return _customPopup.show(
      title: title,
      subTitle: content,
      buttonOneText: "Dismiss",
      buttonTwoText: "Okay",
      context: context,
    );
  }

  showInvalidPhoneNumberPopup() {
    return _customPopup.show(
      title: "Please enter valid mobile number",
      buttonOneText: "Dismiss",
      buttonTwoText: "Okay",
      context: context,
    );
  }

  showInvalidOtpPopup() {
    return _customPopup.show(
      title: "Please enter valid OTP",
      buttonOneText: "Dismiss",
      buttonTwoText: "Okay",
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is IsAuthLoadingState) {
            return const LoadingSpinnerWidget();
          } else if (state is CreateUserDetailsState) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              stopTimer();
              Navigator.pushReplacementNamed(context, '/create-user',
                  arguments: CreateUserPage(
                    showProfile: true,
                    phoneNumber: phoneNumberController.text,
                    otp: otpController.text,
                  ));
            });
          } else if (state is AuthErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!isErrorShown) {
                stopTimer();
                if (state.message ==
                    "User already exists with this mobile number.") {
                  BlocProvider.of<AuthBloc>(context).add(LoginUser(
                      phoneNumber: int.parse(phoneNumberController.text),
                      otp: int.parse(otpController.text)));
                } else {
                  // showCustomPopUp(state.message);
                }
                isErrorShown = true;
              }
            });
          } else if (state is IsAuthenticatedState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              stopTimer();
              BlocProvider.of<AuthBloc>(context).add(LoadAuthStatus());
              Navigator.pop(context, true);
            });
          }
          return Container(
              color: Colors.white,
              // height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 1,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image(
                          width: MediaQuery.of(context).size.width * 0.9,
                          image: const AssetImage(
                              'assets/images/featured_images/welcome-bonus.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // CustomSizedTextBox(
                          //   // addPadding: true,
                          //   textContent: "Login to get started",
                          //   isBold: true,
                          // ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomSizedTextBox(
                            // addPadding: true,
                            textContent:
                                "Explore a whole new way to purchase high-quality used products.",
                          ),
                        ],
                      ),
                    ),
                    CustomInputWidget(
                        placeHolderText: "Phone Number",
                        readOnly: isSentOtp ? true : false,
                        isInt: true,
                        minLength: 10,
                        maxLength: 10,
                        textController: phoneNumberController,
                        hasPrefix: true,
                        prefixText: "+91"),
                    isSentOtp
                        ? Container(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () => {
                                if (phoneNumberController.text.length == 10 &&
                                    myDuration.inSeconds == 0)
                                  {
                                    resetTimer(),
                                    startTimer(),
                                    BlocProvider.of<AuthBloc>(context).add(
                                        const ResendOtp(
                                            phoneNumber: 9494111131, type: 0))
                                  }
                                else
                                  {showInvalidPhoneNumberPopup()}
                              },
                              child: CustomSizedTextBox(
                                textContent: myDuration.inSeconds == 0
                                    ? "Resend otp"
                                    : "Resend otp in 00 : ${myDuration.inSeconds}",
                                color: Colors.black,
                                fontSize: 14,
                                addPadding: true,
                                paddingWidth: 4,
                              ),
                            ))
                        : const SizedBox(),
                    isSentOtp
                        ? CustomInputWidget(
                            placeHolderText: "Otp",
                            isInt: true,
                            minLength: 6,
                            maxLength: 6,
                            textController: otpController)
                        : const SizedBox(),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                                text:
                                    'By continuing, you agree to Unboxedkart\'s ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'T MS',
                                )),
                            TextSpan(
                                text: 'Terms of Use ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'T MS',
                                    color: CustomColors.blue)),
                            TextSpan(
                                text: 'and ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'T MS',
                                )),
                            TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.blue,
                                  fontFamily: 'T MS',
                                )),
                          ]),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width * 1,
                      child: CupertinoButton(
                          alignment: Alignment.center,
                          onPressed: () {
                            if (isSentOtp) {
                              if (otpController.text.length == 6 && isSentOtp) {
                                BlocProvider.of<AuthBloc>(context).add(
                                    ValidateOtp(phoneNumberController.text,
                                        otpController.text));
                                setState(() {
                                  isErrorShown = false;
                                });
                              } else {
                                showInvalidOtpPopup();
                              }
                            } else {
                              if (phoneNumberController.text.length == 10) {
                                setState(() {
                                  isSentOtp = true;
                                });
                                startTimer();
                                BlocProvider.of<AuthBloc>(context).add(SendOtp(
                                    phoneNumber:
                                        int.parse(phoneNumberController.text)));
                              } else {
                                showInvalidPhoneNumberPopup();
                              }
                            }

                            if (otpController.text.length == 6) {
                              BlocProvider.of<AuthBloc>(context).add(
                                  ValidateOtp(phoneNumberController.text,
                                      otpController.text));
                            }
                          },
                          color: CustomColors.blue,
                          disabledColor: Colors.blue,
                          child: CustomSizedTextBox(
                            textContent: isSentOtp ? "Login" : "Send Otp",
                            isBold: false,
                            fontSize: 18,
                            color: Colors.white,
                          )),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(10),
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Navigator.pushReplacementNamed(context, '/login');
                    //     },
                    //     child: RichText(
                    //       text: const TextSpan(children: [
                    //         TextSpan(
                    //             text: 'Already have an account, ',
                    //             style: TextStyle(
                    //               color: Colors.black,
                    //               fontFamily: 'T MS',
                    //             )),
                    //         TextSpan(
                    //             text: 'Login here.',
                    //             style: TextStyle(
                    //                 fontWeight: FontWeight.bold,
                    //                 fontFamily: 'T MS',
                    //                 color: CustomColors.blue)),
                    //       ]),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
