import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/componants/colors.dart';
import 'package:delivery/componants/componants.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditInformation extends StatelessWidget {
  const EditInformation({super.key});

  @override
  Widget build(BuildContext context) {
    var user=DeliveryCubit.get(context).getUserData;
    TextEditingController nameController=TextEditingController();
    TextEditingController gmailController=TextEditingController();
    bool name=false;
    bool birth=false;
    bool updateEmail=false;
    String ?birthDateInString;
    DateTime ?birthDate;
    final _formKey = GlobalKey<FormState>();
    bool dateSelected=false;
    final RegExp emailRegex = RegExp(
      r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])',
    );
    return BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {

  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dropdownvalue=='English Language'?'Edit information':'حدث بياناتك'),
      ),
      body: DeliveryCubit.get(context).getUserData!=null?Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            if(state is UpdateUserLoading)
              const LinearProgressIndicator(),
            const SizedBox(height: 15,),
            profile('رقم الهاتف','Phone number',true,TextEditingController(text: '${DeliveryCubit.get(context).getUserData!.phoneNumber}',),Icons.phone),
            profile('اسمك','Name',user!.username!=''||name? true:false,user.username!=''? TextEditingController(text: '${DeliveryCubit.get(context).getUserData!.username}',):nameController,Icons.person),
            Form(
              key: _formKey,
               child:  profile('حسابك','Gmail',user.email!=''||updateEmail? true:false,user.email!=''? TextEditingController(text:'${DeliveryCubit.get(context).getUserData!.email}',):gmailController,Icons.email,
                validate: (value){
                 if(emailRegex.hasMatch(value)){ return null;}
                 return 'Enter valid email';
                }),

            ),
            StatefulBuilder(
              builder:(context,setState)=> GestureDetector(
                  child: dateSelected?
                  date("${birthDate!.year}-${birthDate!.month}-${birthDate!.day}",true):date(user.birthdate!=null? '${user.birthdate}':'mm/dd/yy',false),
                  onTap: user.birthdate==null? birth?null:() async{
                    final datePick= await showDatePicker(
                      context: context,
                      initialDate: new DateTime.now(),
                      firstDate: new DateTime(1950),
                      lastDate: new DateTime.now(),
                    );
                    if(datePick!=null && datePick!=birthDate){
                      setState(() {
                        dateSelected=true;
                        birthDate=datePick;
                        birthDateInString = "${birthDate!.year}-${birthDate!.month}-${birthDate!.day}"; // 08/14/2019
                      });
                    }
                  }:null
              ),
            ),
            Spacer(),
            bottom('Update information', (){
              if(_formKey.currentState!.validate()){
                updateEmail=true;
                DeliveryCubit.get(context).userUpdate(email: gmailController.text,);
              }
              if(nameController.text!=''){
                DeliveryCubit.get(context).userUpdate(username: nameController.text,);
                name=true;
              }
              if(birthDate!=null){
                DeliveryCubit.get(context).userUpdate(birthdate:'${birthDate!.month}/${birthDate!.day}/${birthDate!.year}',);
                birth=true;
              }
            }),
            const SizedBox(height: 10,)
          ],
        ),
      ):Center(child: const LinearProgressIndicator()),
    );
  },
);
  }
}
Widget profile(textAr,textEn,readOnly,controller,icon,{validate})=>Padding(
  padding: const EdgeInsets.only(bottom: 15.0),
  child: Directionality(
    textDirection: dropdownvalue=='English Language'? TextDirection.ltr:TextDirection.rtl,
    child: TextFormField(
      validator: validate,
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: dropdownvalue=='English Language'?'$textEn ':"$textAr",
        prefixIcon: Icon(
          icon,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: textFieldColor),
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: readOnly? textFieldColor:mainColor.shade400),
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        labelStyle: TextStyle(fontSize: readOnly? 22:14,color:isdark??false? Colors.white:Colors.black),
        contentPadding: const EdgeInsets.all(10),
      ),
    ),
  ),
);
