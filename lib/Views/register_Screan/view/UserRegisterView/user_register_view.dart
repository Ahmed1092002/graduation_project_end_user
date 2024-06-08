import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_end_user/Views/register_Screan/RegisterCubit/register_cubit.dart';
import 'package:graduation_project_end_user/Views/register_Screan/view/RefugeeRegisterView/refugge_register_view.dart';
import 'package:graduation_project_end_user/utils/navigator.dart';
import '../../../../generated/l10n.dart';

class UserRegisterView extends StatelessWidget {
  UserRegisterView({Key? key, this.personId}) : super(key: key);

  final int? personId;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is AddUserLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(S.of(context).successfully),
              ),
            );
          }
          if (state is AddUserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(S.of(context).Failed),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = RegisterCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(S.of(context).UserInformation),
            ),
            body: Padding(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                autovalidateMode: autovalidateMode,
                child: ListView(
                  children: [
                    _buildTextField(S.of(context).User_Name, userNameController, context),
                    _buildTextField(S.of(context).Password, passwordController, context),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await cubit.addUser(
                            personId: personId,
                            userName: userNameController.text,
                      passward: passwordController.text,
                          );
                          await cubit.getAllCountry();
                          navigateToScreen(context, RefuggeRegisterView(
                            countryModelList: cubit.countryModelList,
                            userid: cubit.userModel!.userId,

                          ));
                        }
                      },
                      child: Text(S.of(context).Next),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '${S.of(context).Pleaseenter} $label';
          }
          return null;
        },
      ),
    );
  }
}
