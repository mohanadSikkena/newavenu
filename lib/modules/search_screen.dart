import 'package:flutter/material.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/shared/components/custom_text_field.dart';

import '../shared/styles/colors.dart';
import '../shared/styles/styles.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  FocusNode node = FocusNode();
  TextEditingController searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    PropertiesCubit cubit=PropertiesCubit.get(context);
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: black,
        ),
        backgroundColor: white,
        elevation: 0.0,
      ),
      body: Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(
            left: 16,
          ),
          child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Text('Search', 
                style: f34DisplayBlackBold),
                customTextField(
                  controller: searchController,
                  onTapFunction: (){}, 
                  onSubmit: (){
                    cubit.navigeToSearchExplore(searchController.text, context);
                  },
                  height: 36,
                  
                  node: node, 
                  
                  text: 'Search'
                  ),
                  const SizedBox(height: 20,),
                  Text("History",style: f15TextGraySemibold_1,),
                  const SizedBox(height: 15,),
                  searchHistory(text: "department")

                
                ]
              )
            ),
    );
  }
}

Widget searchHistory(
  {
    required String text
  }
)=>Container(
  decoration: BoxDecoration(
    border: BorderDirectional(bottom: BorderSide(color: gray_2,width: 1)),
    
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        height: 30,
        child: Text(text,style: f17TextBlackSemibold,)),
      Row(
        children: [
          Icon(Icons.search,color: gray_2,),
          const SizedBox(width: 10,)
        ],
      )
    ],
  ),
);
