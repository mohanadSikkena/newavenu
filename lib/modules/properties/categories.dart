

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/main.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/properties_states.dart';
import 'package:newavenue/shared/components/all_categories_widget.dart';
import 'package:newavenue/shared/constant.dart';




class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({ Key? key }) : super(key: key);

    @override
  Widget build(BuildContext context) {
    PropertiesCubit cubit = PropertiesCubit.get(context);
    return BlocConsumer<PropertiesCubit,PropertiesStates>
    (builder: (context,states){
         return Scaffold(
      appBar: AppBar(
        leading:IconButton(onPressed: (){
          navigatorKey.currentState!.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios),) ,
        elevation: 0.0,
      ),
      body: Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(left:16),
        child: ListView(
          scrollDirection: Axis.vertical,
          
          children: [
            Text('Categories',
            style:Theme.of(context).textTheme.displayLarge
            ),
            const SizedBox(height: 15,),

              
              for(int i=0;i<Constant.subCategories.length;i++)
              allCategoriesWidget(
                context: context,
                name: Constant.subCategories[i]["name"],
                img :Constant.subCategories[i]["img"],
                
                function: (){
                cubit.navigateToExploreFromCategory(context: context, i: Constant.subCategories[i]["id"]);
                
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