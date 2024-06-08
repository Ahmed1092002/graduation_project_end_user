import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_end_user/Views/EditProfile/ChangePassword/UserCubit/user_cubit.dart';
import 'package:graduation_project_end_user/Views/MainScrean/View/main_Screen.dart';
import 'package:graduation_project_end_user/utils/navigator.dart';

class ChangePasswordView extends StatelessWidget {
   ChangePasswordView({Key? key}) : super(key: key);
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..getUserByID(),
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
     if (state is UserSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password Changed Successfully'),
            ),
          );
        } else if (state is UserError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Error"),
            ),
          );
     }
        },
        builder: (context, state) {
          final cubit = UserCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white, // Set background color to white
            appBar: AppBar(
              title: const Text('Change Password'),
            ),
            body: Column(
              children: [
                _buildTextFieldWithIcon(
                  oldPasswordController,
                  Icons.lock,
                  'Old Password',
                ),
                _buildTextFieldWithIcon(
                  newPasswordController,
                  Icons.lock,
                  'New Password',
                ),
                ElevatedButton(
                  onPressed: () async {
                    await cubit.changePassword(
                      password:newPasswordController.text,
                    );
                    if (state is UserSuccess) {
                      oldPasswordController.clear();
                      newPasswordController.clear();
                      navigateToScreen(context, MainScrean());
                    }


                  },
                  child: const Text('Change Password'),
                ),

              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextFieldWithIcon(TextEditingController controller,
      IconData icon, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controller,
          style: TextStyle(color: Colors.blue), // Set text color to blue
          decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: Icon(
              icon,
              color: Colors.blue, // Set icon color to blue
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            labelStyle: TextStyle(
                color: Colors.blue), // Set label color to blue
          ),
        ),
      ),
    );
  }
}
