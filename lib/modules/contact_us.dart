import 'package:flutter/material.dart';
import 'package:newavenue/models/customer/customer_cubit.dart';
import 'package:newavenue/shared/components/custom_button.dart';
import 'package:newavenue/shared/components/custom_text_field.dart';
import 'package:newavenue/shared/styles/colors.dart';

import '../main.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> mainKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              navigatorKey.currentState!.pop(context);
            },
            icon:  Icon(Icons.arrow_back_ios, color: Theme.of(context).iconTheme.color),
          )),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: mainKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Expanded(
                  flex: 1,
                  child: Theme.of(context).backgroundColor == black
                      ? Image.asset('images/white_logo_crop.png')
                      : Image.asset('images/black_logo_crop.png')),
              SizedBox(
                height: 20,
              ),
              Flexible(
                  flex: 2,
                  child: Card(
                    elevation: 20,
                    color: Theme.of(context).backgroundColor,
                    shadowColor: Theme.of(context).backgroundColor == black
                        ? white
                        : black,
                    surfaceTintColor: Theme.of(context).backgroundColor,
                    margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Contact Us',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 16, top: 16),
                              child: customTextField(
                                  controller: nameController, text: 'Name')),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 16),
                              child: customTextField(
                                  controller: phoneController, text: 'Phone')),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: customButton(
                                text: 'Submit',
                                function: () async {
                                  if (mainKey.currentState!.validate()) {
                                    // await DioHelper.setData(url: '/customer/add-customer-property', query: {"name":nameController.text,"phone":phoneController.text}).
                                    // then((value) {

                                    // }).onError((error, stackTrace) {

                                    // });

                                    CustomerCubit.get(context).sendCustomerProperty(
                                      context: context, 
                                      name: nameController.text,
                                      phone: phoneController.text

                                    );

                                    
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  )),
              Expanded(flex: 1, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
