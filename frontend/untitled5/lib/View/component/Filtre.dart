import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class inputFiled2 extends StatelessWidget {
  final String title;
  final String hint;

  final TextEditingController? controller;
  final Widget? widget;

  const inputFiled2(
      {required this.title,
        required this.hint,
        this.controller,
        this.widget,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            margin: EdgeInsets.only(top: 8,),
            padding: EdgeInsets.only(left: 14 ),
            child: Row(
              children: [
                Expanded(
                  child:TextFormField(
                      readOnly: widget==null?false:true,
                      decoration: InputDecoration(
                          hintText: hint,
                          hintStyle: GoogleFonts.gloriaHallelujah(
                              textStyle: TextStyle(letterSpacing: .5)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0)
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,width: 0)
                          )
                      ),
                      style: GoogleFonts.gloriaHallelujah(
                          textStyle: TextStyle(letterSpacing: .5)),
                      controller: controller,
                      autofocus: false,
                      cursorColor:Colors.grey
                  ) ,
                ),
                widget==null?Container():Container(child: widget,)
              ],
            ),
            height: 52,

            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: Colors.grey,
                    width: 1.0
                ),
                borderRadius: BorderRadius.circular(30)
            ),


          )


        ],
      ),
    );
  }
}