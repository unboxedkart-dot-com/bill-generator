import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/logic/auth/auth_bloc.dart';
import 'package:unboxedkart/presentation/pages/user_main/user_main.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_alert_popup.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_bottom_button.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_input_widget.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class CreateUserPage extends StatefulWidget {
  final bool showProfile;
  final String phoneNumber;
  final String otp;

  const CreateUserPage(
      {Key key, this.phoneNumber, this.otp, this.showProfile = false})
      : super(key: key);

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String gender;
  String username = "";
  final CustomAlertPopup _customPopup = CustomAlertPopup();

   

  @override
  void initState() {
    super.initState();
    phoneNumberController.text = widget.phoneNumber;
  }

  showCustomPopup(String title) {
    return _customPopup.show(
      title: title,
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
          } else if (state is AuthErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showCustomPopup(state.message);
            });
          } else if (state is IsAuthenticatedState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.showProfile
                  ? Navigator.pushReplacementNamed(context, '/',
                      arguments: UserMain(
                        index: 4,
                      ))
                  : Navigator.pop(context);
            });
          }
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: CustomAppBar(
                  title: "Create user",
                  enableBack: true,
                )),
            bottomSheet: CustomBottomButton(
                 
                title: "Create account",
                function: () {
                  if (nameController.text.isNotEmpty &&
                      emailController.text.length > 4) {
                    BlocProvider.of<AuthBloc>(context).add(CreateUser(
                        phoneNumber: int.parse(widget.phoneNumber),
                        otp: int.parse(widget.otp),
                        emailAddress: emailController.text,
                        userName: nameController.text,
                        gender: gender));
                  } else {
                    showCustomPopup("Please enter all required details");
                  }
                }),
            body: ListView(
              children: [
                CustomInputWidget(
                  placeHolderText: "Phone Number *",
                  readOnly: true,
                  isInt: true,
                  textController: phoneNumberController,
                ),
                CustomInputWidget(
                    placeHolderText: "Name *", textController: nameController),
                CustomInputWidget(
                    placeHolderText: "Email Address *",
                    textController: emailController),
                CustomSizedTextBox(
                  textContent: "Select your gender",
                   
                  fontSize: 18,
                  paddingWidth: 12,
                  addPadding: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 37,
                      backgroundColor:
                          gender == 'male' ? Colors.blueAccent : Colors.white,
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              gender = 'male';
                            });
                          },
                          child: const CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                                'assets/images/featured_images/male.png'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    CircleAvatar(
                      radius: 37,
                      backgroundColor:
                          gender == 'female' ? Colors.blueAccent : Colors.white,
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              gender = 'female';
                            });
                          },
                          child: const CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                                'assets/images/featured_images/female.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
     
  }
}
