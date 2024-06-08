import 'package:flutter/material.dart';

class CustomInputLogin extends StatefulWidget {
  final String hintText;
  TextEditingController? controller ;
  String? value;

   CustomInputLogin({Key? key, required this.hintText, this.controller, this.value}) : super(key: key);

  @override
  State<CustomInputLogin> createState() => _CustomInputLoginState();
}

class _CustomInputLoginState extends State<CustomInputLogin> {
   bool isPassword = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: widget.controller,
        obscureText: isPassword ,
        decoration: InputDecoration(

          suffixIcon: widget.value =='password'? IconButton(
            icon: Icon( isPassword ? Icons.visibility_off : Icons.visibility),
            color: Colors.blue,
            onPressed: () {
           setState(() {
              isPassword = !isPassword;
           });
            },
          ):Icon(Icons.email , color: Colors.blue,),

          hintText: widget.hintText,
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),

          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),

        ),
      ),
    );
  }
}
