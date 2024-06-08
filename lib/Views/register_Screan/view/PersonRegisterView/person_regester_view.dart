import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_end_user/Views/register_Screan/RegisterCubit/register_cubit.dart';
import 'package:graduation_project_end_user/Views/register_Screan/view/UserRegisterView/user_register_view.dart';
import 'package:graduation_project_end_user/utils/navigator.dart';

import '../../../../Models/PersonModel.dart';
import '../../../../generated/l10n.dart';

class PersonRegesterView extends StatefulWidget {
  PersonRegesterView({Key? key}) : super(key: key);

  @override
  State<PersonRegesterView> createState() => _PersonRegesterViewState();
}

class _PersonRegesterViewState extends State<PersonRegesterView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _firstNameController = TextEditingController();

  TextEditingController _lastNameController = TextEditingController();

  TextEditingController _addressController = TextEditingController();

  TextEditingController _phone1Controller = TextEditingController();

  TextEditingController _phone2Controller = TextEditingController();

  String _gender = '';

  DateTime _selectedDate = DateTime.now();

  TextEditingController _emailController = TextEditingController();

  String _selectedGender = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
 if (state is AddPersonSuccess) {

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(S.of(context).successfully),
            ),
          );
        }
 if (state is AddPersonError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text("${S.of(context).Failed} ${state.message}"),
            ),
          );
        }
        },
        builder: (context, state) {
          final cubit = RegisterCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(S.of(context).personal_information),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    _buildTextField(S.of(context).FirstName, _firstNameController),
                    _buildTextField(S.of(context).LastName, _lastNameController),
                    _buildRadioButtons(),
                    _buildTextField(S.of(context).Address, _addressController),
                    _buildTextField(S.of(context).PhoneNumber, _phone1Controller),

                    _buildDatePicker(context),
                    _buildTextField(S.of(context).Email, _emailController),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_gender==S.of(context).Male){
                          _selectedGender = "M";
                        }else if (_gender==S.of(context).Female){
                          _selectedGender = "F";
                        }
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          PersonModel personModel = PersonModel(
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            email: _emailController.text,
                            phone1: _phone1Controller.text,
                            address: _addressController.text,
                            dateOfBirth: _selectedDate.toIso8601String(),
                            gender: _selectedGender,



                          );

                   await       cubit.addPerson(personModel);
                   print('personModel.personId ${cubit.personModel!.personId}');
                   navigateToScreen(context, UserRegisterView(
                     personId: cubit.personModel!.personId,

                   ));


                        }else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(S.of(context).Pleasefillallields),
                            ),
                          );
                        }
                      },
                      child: Text(S.of(context).Next)
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );;
  }

  Widget _buildTextField(String label, TextEditingController controller) {
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

  Widget _buildRadioButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            S.of(context).Gender, style: TextStyle(fontSize: 16, color: Colors.blueAccent)),
        Row(
          children: <Widget>[
            Radio<String>(
              value: S.of(context).Male,
              groupValue: _gender,
              onChanged: (String? value) {
                setState(() {
                  _gender = value!;
                });
              },
            ),
            Text(S.of(context).Male),
            Radio<String>(
              value: S.of(context).Female,
              groupValue: _gender,
              onChanged: (String? value) {
                setState(() {
                  _gender = value!;
                });
              },
            ),
            Text(S.of(context).Female),
          ],
        ),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return ListTile(
      title: Text(S.of(context).Birthday),
      subtitle: Text(
          '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}'),
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        ).then((pickedDate) {
          if (pickedDate != null) {
            setState(() {
              _selectedDate = pickedDate;
            });
          }
        });
      },
    );
  }
}
