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

class SignupUsingMobileNumberPage extends StatefulWidget {
  final bool showProfile;
  const SignupUsingMobileNumberPage({Key key, this.showProfile})
      : super(key: key);

  @override
  State<SignupUsingMobileNumberPage> createState() =>
      _SignupUsingMobileNumberPageState();
}

class _SignupUsingMobileNumberPageState
    extends State<SignupUsingMobileNumberPage> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            title: "Sign up",
            enableBack: true,
            showLogo: true,
          )),
      body: BlocProvider(
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
                  showCustomPopup(state.message, state.content);
                  isErrorShown = true;
                }
              });
            }
            return SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 1,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width * 1,
                        child: CupertinoButton(
                            alignment: Alignment.center,
                            onPressed: () {
                              if (isSentOtp) {
                                if (otpController.text.length == 6 &&
                                    isSentOtp) {
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
                                  BlocProvider.of<AuthBloc>(context).add(
                                      SendOtp(
                                          phoneNumber: int.parse(
                                              phoneNumberController.text)));
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
                              textContent: isSentOtp ? "Sign up" : "Send Otp",
                              isBold: false,
                              fontSize: 18,
                              color: Colors.white,
                            )),
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
                                  text: 'Already have an account, ',
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(
                                  text: 'Login here.',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.blue)),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }
}
