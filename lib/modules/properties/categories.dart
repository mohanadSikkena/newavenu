

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/properties_states.dart';
import 'package:newavenue/shared/components/all_categories_widget.dart';
import 'package:newavenue/shared/components/buy_rent_custom_button.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';



class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({ Key? key }) : super(key: key);

    @override
  Widget build(BuildContext context) {
    PropertiesCubit cubit = PropertiesCubit.get(context);
    return BlocConsumer<PropertiesCubit,PropertiesStates>
    (builder: (context,states){
         return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        leading:IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios),color: black,) ,
        backgroundColor: white,
        elevation: 0.0,
      ),
      body: Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(left:16),
        child: ListView(
          scrollDirection: Axis.vertical,
          
          children: [
            Text('Categories',
            style:f34DisplayBlackBold
            ),
            const SizedBox(height: 15,),
             Container(
                
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(color: gray_2,width: 1),)
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                        cubit.changeCategoriesSelected('buy');
                      },
                      child: buyRentButton(text: 'Buy',selected: cubit.categoriesSelected=='buy'?true:false)
                      ),
                    const SizedBox(width: 20,),
                    InkWell(
                      onTap: (){
                        cubit.changeCategoriesSelected('rent');
                      },
                      child: buyRentButton(text: 'Rent',selected: cubit.categoriesSelected=='rent'?true:false),
                    )
                   
                  ],
                ),
              ),
              for(int i=0;i<cubit.subCategories.length;i++)
              allCategoriesWidget(
                name: cubit.subCategories[i]["name"],
                img :cubit.subCategories[i]["img"],
                
                function: (){
                cubit.navigateToExploreFromCategory(context: context, i: cubit.subCategories[i]["id"]);
                
              })
              

          ],
        )
        ),
    );
  
    }, 
    listener: (context,states){

    });
   
  }

}