import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_end_user/Blocs/localizationCubit/localization_cubit.dart';
import 'package:graduation_project_end_user/Views/Login_View/LoginCubit/login_cubit.dart';
import 'package:graduation_project_end_user/Views/Login_View/widget/custom_input_login.dart';
import 'package:graduation_project_end_user/Views/MainScrean/View/main_Screen.dart';
import 'package:graduation_project_end_user/Views/register_Screan/view/PersonRegisterView/person_regester_view.dart';
import 'package:graduation_project_end_user/utils/navigator.dart';

import '../../generated/l10n.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => LoginCubit(),
  child: BlocConsumer<LoginCubit, LoginState>(
  listener: (context, state) {
if (state is LoginErrorState) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('Error',
    style: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ) ,),
    backgroundColor: Colors.red,
  ));

}
if (state is LoginSuccessState) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('Succesfull' , style: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ) ,),
    backgroundColor: Colors.green,
  ));
}
  },
  builder: (context, state) {
    var loginCubit = LoginCubit.get(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: Colors.white, actions: <Widget>[
        BlocConsumer<LocalizationCubit, LocalizationState>(
  listener: (context, state) {

  },
  builder: (context, state) {
    var localizationcubit = LocalizationCubit.get(context);

    return Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
          icon: Icon(Icons.language),
          iconSize: 30,
          color: Color(0xff64C2F5),

          onPressed: () async   {
          await   localizationcubit.ChangeLanguageConndation();

            setState(() {
            });
          }
          ),
        );
  },
),
      ]),
      body: Center(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(children: [
              Image.asset(
                'assets/image/preview-HMeq0RCYE-transformed-removebg-preview.png',
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Row(
                  children: [
                    Text(
                      S.of(context).Login,
                      style: TextStyle(color: Color(0xff64C2F5), fontSize: 20),
                    ),
                  ],
                ),
              ),
              CustomInputLogin(
                hintText: S.of( context).Email,
                controller: emailController,
                value: 'email'
              ),
              CustomInputLogin(
                hintText: S.of(context).Password,
                controller: passwordController,
                value: 'password'
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      S.of(context).Forgot_Password,
                      style: TextStyle(color: Color(0xff64C2F5)),
                    ),
                  ],
                ),
              ),
        if (state is LoginLoadingState)
          CircularProgressIndicator()
        else
        Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
                child: MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 40,
                  onPressed: ()  async{
                    
                    await loginCubit.login(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    if (State is LoginErrorState || loginCubit.loginModel==null || loginCubit.userModel==null|| loginCubit.personModel==null )
                    {
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Error',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                          ) ,),
                        backgroundColor: Colors.red,
                      ));



                    }
                    if (State is LoginSuccessState || loginCubit.loginModel!=null || loginCubit.userModel!=null|| loginCubit.personModel!=null){
                      navigateToScreenAndExit(context, MainScrean());
                  }
},
                  color: Color(0xff64C2F5),
                  child: Text(S.of(context).Login,
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  textColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 40,
                  onPressed: () {
                    //Here goes the logic for Google SignIn discussed in the next section
                  },
                  color: Color(0xff0B79B3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      SizedBox(width: 10),
                      Text(S.of(context).Login_with_Google,
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                  textColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 40,
                  onPressed: () {
                    //Here goes the logic for Google SignIn discussed in the next section
                  },
                  color: Color(0xff0B79B3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.facebook),
                      SizedBox(width: 10),
                      Text(S.of(context).Login_with_Facebook,
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                  textColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 100),
                child: GestureDetector(
                  onTap: () {
                    navigateToScreen(context, PersonRegesterView());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).Dont_have_an_account,
                        style: TextStyle(color: Color(0xff64C2F5), fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  },
),
);
  }
}