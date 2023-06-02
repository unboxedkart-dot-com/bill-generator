 import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/logic/auth/auth_bloc.dart';
import 'package:unboxedkart/presentation/pages/authentication/create_user_page.dart';
import 'package:unboxedkart/presentation/pages/authentication/signup_using_mobile_number.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_alert_popup.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_input_widget.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class LoginUsingMobileNumberPageUpdated extends StatefulWidget {
  final bool showProfile;

  const LoginUsingMobileNumberPageUpdated({Key key, this.showProfile = false})
      : super(key: key);
  @override
  State<LoginUsingMobileNumberPageUpdated> createState() =>
      _LoginUsingMobileNumberPageUpdatedState();
}

class _LoginUsingMobileNumberPageUpdatedState
    extends State<LoginUsingMobileNumberPageUpdated> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final CustomAlertPopup _customPopup = CustomAlertPopup();
  bool isSentOtp = false;
  bool isErrorShown = false;
  Timer countDownTimer;
  Duration myDuration = const Duration(seconds: 15);

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

  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    if (countDownTimer != null) {
      countDownTimer.cancel();
    }
  }

  showCustomPopUp(String title) {
    return _customPopup.show(
      title: title,
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

  void _handleSendOtp(int phoneNumber) {
    BlocProvider.of<AuthBloc>(context).add(SendOtp(phoneNumber: phoneNumber));
    setState(() {
      isSentOtp = true;
    });
  }

  void _handleResendOtp(int phoneNumber) {
    BlocProvider.of<AuthBloc>(context).add(ResendOtp(phoneNumber: phoneNumber));
  }

  void _handleValidateMobileNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      int phoneNumberInInt = int.parse(phoneNumber);
      if (isSentOtp) {
        BlocProvider.of<AuthBloc>(context)
            .add(ResendOtp(phoneNumber: phoneNumberInInt));
        _handleResendOtp(phoneNumberInInt);
      } else {
        BlocProvider.of<AuthBloc>(context)
            .add(SendOtp(phoneNumber: phoneNumberInInt));
        _handleSendOtp(phoneNumberInInt);
      }
    } else {
      showInvalidPhoneNumberPopup();
    }
  }

  void _handleValidateOtp({int otp, Function function}) {
    if (otp.bitLength == 6) {
      function();
    }
  }

  void _handleLogin(int phoneNumber, int otp) async {
    BlocProvider.of<AuthBloc>(context)
        .add(LoginUser(phoneNumber: phoneNumber, otp: otp));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            title: "Login",
            enableBack: true,
            showLogo: true,
          )),
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is IsAuthLoadingState) {
              return const LoadingSpinnerWidget();
            } else if (state is IsAuthenticatedState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                stopTimer();
                BlocProvider.of<AuthBloc>(context).add(LoadAuthStatus());
                Navigator.pop(context, true);
              });
            } else if (state is AuthErrorState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!isErrorShown) {
                  stopTimer();
                  if (state.message ==
                      "user does not exits, please create user") {
                    Navigator.pushReplacementNamed(context, '/create-user',
                        arguments: CreateUserPage(
                          showProfile: widget.showProfile,
                          phoneNumber: phoneNumberController.text,
                          otp: otpController.text,
                        ));
                  } else {
                    showCustomPopUp(state.message);
                  }

                  isErrorShown = true;
                }
              });
            }
            return SizedBox(
                // height: MediaQuery.of(context).size.height * 0.,
                width: MediaQuery.of(context).size.width * 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      // SizedBox(
                      //   height: 20,
                      // ),
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
                                  setState(() {
                                    isErrorShown = false;
                                  });
                                  BlocProvider.of<AuthBloc>(context).add(
                                      LoginUser(
                                          phoneNumber: int.parse(
                                              phoneNumberController.text),
                                          otp: int.parse(otpController.text)));
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
                            },
                            color: CustomColors.blue,
                            disabledColor: Colors.blue,
                            child: CustomSizedTextBox(
                              textContent: isSentOtp ? "Login" : "Send otp",
                              isBold: false,
                              fontSize: 18,
                              color: Colors.white,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () async {
                            Navigator.pushReplacementNamed(context, '/signup',
                                arguments: const SignupUsingMobileNumberPage(
                                  showProfile: true,
                                ));
                          },
                          child: RichText(
                            text: const TextSpan(children: [
                              TextSpan(
                                  text: 'Don\'t have an account, ',
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(
                                  text: 'Sign up here.',
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
