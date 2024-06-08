import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project_end_user/Views/EditProfile/refugee_view/RefugeeCubit/refugee_cubit.dart';
import 'package:intl/intl.dart';
import 'package:graduation_project_end_user/Models/RefugeeModel.dart';
import '../../../Models/CountryModel.dart';
import '../../../generated/l10n.dart';

class RefuggeView extends StatefulWidget {
  RefuggeView({this.refugeeModel, this.countryModelList, this.countryModel});

   RefugeeModel? refugeeModel;
   List<CountryModel>? countryModelList;
   CountryModel? countryModel;

  @override
  _RefuggeViewState createState() => _RefuggeViewState();
}

class _RefuggeViewState extends State<RefuggeView> {
  late TextEditingController _refugeeCardNoController = TextEditingController();
  late TextEditingController _nationaltyIdController = TextEditingController();
  late TextEditingController _cardStartDateController = TextEditingController();
  late TextEditingController _cardEndDateController = TextEditingController();
  CountryModel? _selectedCountry;
  String? decodedFileName;
  DateTime? parsedStartDate;
  DateTime? parsedEndDate;

  @override
  void initState() {
    super.initState();
    print (widget.refugeeModel!.imagePath);
    if (widget.refugeeModel != null) {

      _refugeeCardNoController.text = widget.refugeeModel!.refugeeCardNo!;
      _cardStartDateController.text = widget.refugeeModel!.cardStartDate!;
      _cardEndDateController.text = widget.refugeeModel!.cardEndDate!;
      List<String> segments = widget.refugeeModel!.cv!.split('/');

      // Get the last segment which represents the filename
      String lastSegment = segments.last;

      // Decode the filename to handle special characters
       decodedFileName = Uri.decodeFull(lastSegment);
    }
    if (widget.countryModel != null) {
      _selectedCountry = widget.countryModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => RefugeeCubit(),
  child: BlocListener<RefugeeCubit, RefugeeState>(
  listener: (context, state) {
    if (state is EditRefugeeSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(S.of(context).successfully),
        ),
      );
    }
    if (state is EditRefugeeFailure ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(S.of(context).Failed),
        ),
      );
    }
  },
  child: BlocBuilder<RefugeeCubit, RefugeeState>(
  builder: (context, state) {
    final cubit = RefugeeCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
appBar: AppBar(
        title: Text(S.of(context).Refugee_inf),
      ),
      body:    ListView(
        padding: EdgeInsets.all(16),
        children: [

          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,

            ),
            child: cubit.profileImage != null
                ? CircleAvatar(

              backgroundImage: FileImage(cubit.profileImage!) as ImageProvider,
              radius: 80.h,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          await cubit.pickCameraImage();

                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
                : CachedNetworkImage(
              imageUrl: widget.refugeeModel!.imagePath!,
              imageBuilder: (context, imageProvider) => Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                await    cubit.pickCameraImage();

                  },
                ),
              ),
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/image/preview-HMeq0RCYE-transformed.png'),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.blue,
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue,
                  child: Stack(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          await    cubit.pickCameraImage();


                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),



          _buildTextFieldWithIcon(
              _refugeeCardNoController, Icons.credit_card, S.of(context).RefugeeCardNo),
          _buildDropdownField(),
       Column(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children:[
           if (widget.refugeeModel!.cv != null)
             Text(
               widget.refugeeModel!.cv != null ? '${S.of(context).CV}: ${decodedFileName}' : '${S.of(context).CV}: ${S.of(context).NoCVuploaded}',
               style: TextStyle(color: Colors.blue),
             )
           else if (cubit.fileName != null)
    Text(
    cubit.pdfFile != null ? '${S.of(context).CV}: ${cubit.pdfLink!}' : '${S.of(context).CV}: ${S.of(context).NoCVuploaded}',
    style: TextStyle(color: Colors.blue,fontSize: 10 ),

    ),

           MaterialButton(onPressed: () async {
              await cubit.pickFilePdf();
           },
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10),
             ),
             child: Text(S.of(context).PickPDF),
             color: Colors.blue,
            ),
         ],
       ),
          Row(
            children: [
              Expanded(
                child: _buildDatePickerField(
                    _cardStartDateController, Icons.date_range, S.of(context).CardStartDate),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _buildDatePickerField(
                    _cardEndDateController, Icons.date_range, S.of(context).CardEndDate,
              ),
              )
            ],
          ),
          SizedBox(height: 20),
          if (State is FileUploadLoadingState || State is EditRefugeeLoading)
            CircularProgressIndicator()
          else // Add some space between the fields and the button
          ElevatedButton(
            onPressed: () async{
              if (cubit.pdfFile != null)
                {
                  cubit.pdfLink=       await cubit.uploadFile(file: cubit.pdfFile,);

                }
              if (cubit.profileImage != null)
                {
                  cubit.profileImageLink=     await cubit.uploadFile(file: cubit.profileImage);

                }
              // Parse cardStartDate and cardEndDate to DateTime


                parsedStartDate = DateTime.parse(_cardStartDateController.text); // Ensure cardStartDate is in a parsable format like "yyyy-MM-dd"
                parsedEndDate = DateTime.parse(_cardEndDateController.text); // Ensure cardEndDate is in a parsable format like "yyyy-MM-dd"

              // Convert to ISO 8601 strings
              String cardStartDateToIso = parsedStartDate!.toIso8601String();
              String cardEndDateToIso = parsedEndDate!.toIso8601String();
              RefugeeModel refugeeModel = RefugeeModel(
                refugeeId: widget.refugeeModel!.refugeeId,
                refugeeCardNo: _refugeeCardNoController.text,
                countryId: _selectedCountry!.countryId,
               nationaltyId: _selectedCountry!.countryId,
                userId: widget.refugeeModel!.userId,
                deviceToken: widget.refugeeModel!.deviceToken,
                refugeeJobId: widget.refugeeModel!.refugeeJobId,
                cardStartDate: cardStartDateToIso,
                cardEndDate: cardEndDateToIso,
                imagePath:  cubit.profileImageLink!.isEmpty ? widget.refugeeModel!.imagePath : cubit.profileImageLink,
                cv:  cubit.pdfLink!.isNotEmpty ? cubit.pdfLink : widget.refugeeModel!.cv,
              );
              print (refugeeModel.toJson());
              await cubit.editRefugee(
                refugeeModel: refugeeModel,
              );


            },
            child: Text(S.of(context).edit),
          ),
        ],
      ),
    );
  },
),
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
      child: DropdownButtonFormField<CountryModel>(
        decoration: InputDecoration(
          labelText: S.of(context).Country,

          prefixIcon: Icon(
            Icons.flag,
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
        hint: Text(
          _selectedCountry != null ? _selectedCountry!.countryName ?? '' : S.of(context).Selectcountry,
          style: TextStyle(color: Colors.blue,fontSize:7 ), // Set hint text color to blue
        ),
        value: _selectedCountry,
        onChanged: (CountryModel? newValue) {
          setState(() {
            _selectedCountry = newValue!;
          });
        },
        items: widget.countryModelList!.map((CountryModel country) {
          return DropdownMenuItem<CountryModel>(
            value: country,
            child: Text(country.countryName ?? '',style: TextStyle(
              color: Colors.blue,
              fontSize: 13.sp

            ),),
          );
        }).toList(),
      ),
    );
  }


}
