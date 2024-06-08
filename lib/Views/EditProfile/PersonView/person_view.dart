import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_end_user/Models/PersonModel.dart';
import 'package:graduation_project_end_user/Views/EditProfile/PersonView/PersonCubit/person_cubit.dart';

import '../../../generated/l10n.dart';

class PersonView extends StatefulWidget {
   PersonView({Key? key,this.personModel }) : super(key: key);
  PersonModel? personModel;

  @override
  State<PersonView> createState() => _PersonViewState();
}

class _PersonViewState extends State<PersonView> {
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
@override
  void initState() {
  if (widget.personModel != null) {
    _firstNameController.text = widget.personModel!.firstName!;
    _lastNameController.text = widget.personModel!.lastName!;
    _addressController.text = widget.personModel!.address!;
    _phone1Controller.text = widget.personModel!.phone1!;
    _emailController.text = widget.personModel!.email!;
    _gender = widget.personModel!.gender!;
    _selectedDate = DateTime.parse(widget.personModel!.dateOfBirth!);
    _emailController.text = widget.personModel!.email!;
  }
}
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => PersonCubit(),
  child: BlocConsumer<PersonCubit, PersonState>(
  listener: (context, state) {
    if (state is EditPersonSuccessState) {
PersonCubit.get(context).getPersonById();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(S.of(context).successfully)
        ),
      );
    }
    if (state is EditPersonErrorState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(S.of(context).Failed),
        ),
      );
    }

  },
  builder: (context, state) {
    var cubit = PersonCubit.get(context);

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
if (state is EditPersonLoadingState)
  Center(child: CircularProgressIndicator())
              else
              ElevatedButton(
                onPressed: () async {
                  if (_gender==S.of(context).Male){
                    _selectedGender = "M";
                  }else if (_gender==S.of(context).Female){
                    _selectedGender = "F";
                  }
                  if (_formKey.currentState!.validate())  {
                    _formKey.currentState!.save();
                    PersonModel personModel = PersonModel(
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      email: _emailController.text,
                      phone1: _phone1Controller.text,
                      address: _addressController.text,
                      dateOfBirth: _selectedDate.toIso8601String(),
                      gender: _selectedGender,
                      personId: widget.personModel!.personId,


                    );
                   await  cubit.editPerson(personModel: personModel);

                  }
                },
                child: Text(S.of(context).edit),
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
            return 'Please enter $label';
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
        Text(S.of(context).Gender, style: TextStyle(fontSize: 16 , color:Colors.blueAccent ) ),
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
      subtitle: Text('${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}'),
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
