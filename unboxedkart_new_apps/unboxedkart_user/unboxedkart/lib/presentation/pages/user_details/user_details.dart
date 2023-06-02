import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/logic/user/user_bloc.dart';
import 'package:unboxedkart/models/user/user.model.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_alert_popup.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_bottom_button.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_input_widget.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_scaffold.dart';

class UserDetails extends StatefulWidget {
  final String phoneNumber;
  final String otp;

  const UserDetails({Key key, this.phoneNumber, this.otp}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
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

  showCustomPopUp({String title, String content}) {
    return _customPopup.show(
      title: title,
      buttonOneText: "Dismiss",
      buttonTwoText: "Okay",
      context: context,
    );
  }

  setValues(UserModel user) {
    nameController.text = user.name;
    emailController.text = user.emailId;
    phoneNumberController.text = user.phoneNumber.toString();
     
    gender = user.gender;
     
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(LoadUserDetails()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserDetailsUpdated) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
               
              Navigator.pop(context);
            });
          } else if (state is UserDetailsLoaded) {
             
             
             
             
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              setValues(state.user);
            });
             
            return Scaffold(
              appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: CustomAppBar(
                    title: "User details",
                    enableBack: true,
                  )),
              bottomSheet: CustomBottomButton(
                   
                  title: "Update details",
                  function: () {
                    if (state.user.name.isNotEmpty &&
                         
                        state.user.gender != null) {
                      BlocProvider.of<UserBloc>(context).add(UpdateUserDetails(
                          nameController.text, state.user.gender));
                    } else {
                      showCustomPopUp(
                          title: "Please enter all required details");
                    }
                  }),
              body: Container(
                margin: const EdgeInsets.all(8),
                child: ListView(
                  children: [
                    CustomInputWidget(
                        placeHolderText: "Phone Number",
                         
                        readOnly: true,
                        isInt: true,
                        textController: TextEditingController(
                            text: '${state.user.phoneNumber}')
                         
                        ),
                    CustomInputWidget(
                      readOnly: true,
                      placeHolderText: "Email Address",
                       
                      textController:
                          TextEditingController(text: state.user.emailId),
                       
                       
                    ),
                    CustomInputWidget(
                      placeHolderText: "Name",
                       
                       
                      textController: nameController,
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                    ),
                    
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
                          backgroundColor: state.user.gender == 'male'
                              ? Colors.blueAccent
                              : Colors.white,
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                   
                                  state.user.gender = 'male';
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
                          backgroundColor: state.user.gender == 'female'
                              ? Colors.blueAccent
                              : Colors.white,
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  state.user.gender = 'female';
                                   
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
              ),
            );
          }
          return const LoadingScaffold(
            title: "User details",
            enableBack: true,
          );
        },
      ),
    );
  }
}
