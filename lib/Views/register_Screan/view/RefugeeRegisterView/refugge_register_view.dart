import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project_end_user/utils/navigator.dart';
import 'package:intl/intl.dart';


import '../../../../Models/CountryModel.dart';
import '../../../../generated/l10n.dart';
import '../../../MainScrean/View/main_Screen.dart';
import '../../RegisterCubit/register_cubit.dart';


class RefuggeRegisterView extends StatefulWidget {
   RefuggeRegisterView({Key? key ,
    this.countryModelList,
    this.userid

   }) : super(key: key);
   List<CountryModel>? countryModelList;
   int?userid;

  @override
  State<RefuggeRegisterView> createState() => _RefuggeRegisterViewState();
}

class _RefuggeRegisterViewState extends State<RefuggeRegisterView> {
  late TextEditingController _refugeeCardNoController = TextEditingController();

  late TextEditingController _nationaltyIdController = TextEditingController();

  late TextEditingController _cardStartDateController = TextEditingController();

  late TextEditingController _cardEndDateController = TextEditingController();

  CountryModel? _selectedCountry;

  String? decodedFileName;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => RegisterCubit(),
  child: BlocConsumer<RegisterCubit, RegisterState>(
  listener: (context, state) {
    if (state is AddRefugeeLoaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(S.of(context).successfully),
        ),
      );
    }
    if (state is AddRefugeeError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("${S.of(context).Failed} "),
        ),
      );
    }

  },
  builder: (context, state) {
    final cubit = RegisterCubit.get(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(S.of(context).Refugee_inf),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: ListView(
            children: [
              Container(

                decoration: BoxDecoration(

                  shape: BoxShape.circle,

                  border: Border.all(color: Colors.blue),
                ),
                child: cubit.profileImage==null?
                    Center(
                  child: Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo),
                      onPressed: () async {
                         await cubit.pickCameraImage();
                      },
                    ),
                  ),
                ):Container(

                height:130.h ,decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue),
                  image: DecorationImage(
                    image: FileImage(cubit.profileImage!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 10,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: IconButton(
                          color: Colors.white
                         , icon: Icon(Icons.add_a_photo),
                          onPressed: () async {
                            await cubit.pickCameraImage();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 if(cubit.pdfFile==null)
                   Text(
                     'upload cv',
                     style: TextStyle(color: Colors.blue),
                   )
                  else
                    
                    Flexible(
                      child: Text(
                        cubit.fileName!,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  MaterialButton(
                    onPressed: () async {
                      await cubit.pickFilePdf();
                    },
                    color: Colors.blue,
                    child: Text(S.of(context).Upload, style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),



              _buildTextFieldWithIcon(
                  _refugeeCardNoController, Icons.credit_card, S.of(context).RefugeeCardNo),
              _buildDropdownField(),


              _buildDatePickerField(
                  _cardStartDateController, Icons.date_range, 'Card Start Date'),
              _buildDatePickerField(
                  _cardEndDateController, Icons.date_range, 'Card End Date'),
            if (state is AddRefugeeLoading || State is FileUploadLoadingState)
              Center(
                child: CircularProgressIndicator(),
              ),

              MaterialButton
                (
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () async {

                  if (cubit.profileImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select profile image'),
                      ),
                    );
                    return;
                  }
                  if (cubit.pdfFile == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select pdf file'),
                      ),
                    );
                    return;
                  }
               if (formKey.currentState!.validate()) {
                 if (cubit.pdfFile != null && cubit.profileImage!=null)
                   {

                cubit.pdfLink=     await cubit.uploadFile(file: cubit.pdfFile!);
                cubit.profileImageLink=      await cubit.uploadFile(file: cubit.profileImage!);

                      await cubit.addRefugee(
                        countryId: _selectedCountry!.countryId!,
                        cardEndDate: _cardEndDateController.text,
                        cardStartDate: _cardStartDateController.text,
                        nationaltyId: _selectedCountry!.countryId!,
                        refugeeCardNo: _refugeeCardNoController.text,
                        userId: widget.userid!,
                        cv: cubit.pdfLink!,
                        refugeeJobId: 5,
                        imagePath: cubit.profileImageLink!,


                        deviceToken: 'token',




                      );
                      if (cubit.refugeeModel != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScrean(),
                          ),
                        );
                      }else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to add refugee'),
                          ),
                        );
                      }

                   }

                  } else {
                    setState(() {
                      autovalidateMode = AutovalidateMode.always;
                    });
                  }

                },
                color: Colors.blue,
                child: Text(S.of(context).Register,style:TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp
                ) ,),
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

  Widget _buildTextFieldWithIcon(
      TextEditingController controller, IconData icon, String labelText) {
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
            labelStyle: TextStyle(color: Colors.blue), // Set label color to blue
          ),
        ),
      ),
    );
  }

  Widget _buildDatePickerField(
      TextEditingController controller, IconData icon, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controller,
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
              setState(() {
                controller.text = formattedDate;
              });
            }
          },
          style: TextStyle(color: Colors.blue,fontSize: 12.sp ), // Set text color to blue
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
            labelStyle: TextStyle(color: Colors.blue,fontSize: 10.sp), // Set label color to blue
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:DropdownButtonFormField<CountryModel>(
        decoration: InputDecoration(
          labelText: S.of(context).Country,
          prefixIcon: Icon(Icons.flag, color: Colors.blue),
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          labelStyle: TextStyle(color: Colors.blue),
        ),
        hint: Text(
          _selectedCountry?.countryName ?? S.of(context).Selectcountry,
          style: TextStyle(color: Colors.blue, fontSize: 7.sp),
        ),
        value: _selectedCountry,
        onChanged: (CountryModel? newValue) {
          setState(() {
            _selectedCountry = newValue;
          });
        },
        items: widget.countryModelList?.map((CountryModel country) {
          return DropdownMenuItem<CountryModel>(
            value: country,
            child: Text(
              country.countryName ?? '',
              style: TextStyle(color: Colors.blue,fontSize: 13.sp),
            ),
          );
        }).toList() ?? [],
      )
      ,
    );
  }
}
