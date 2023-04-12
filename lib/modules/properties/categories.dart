

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/main.dart';
import 'package:newavenue/models/categories/categories_cubit.dart';
import 'package:newavenue/models/categories/categories_states.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/properties_states.dart';
import 'package:newavenue/modules/properties/primary_categories.dart';




class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({ Key? key }) : super(key: key);

    @override
  Widget build(BuildContext context) {
    CategoriesCubit cubit = CategoriesCubit.get(context);
    return BlocConsumer<CategoriesCubit,CategoriesStates>
    (builder: (context,states){
         return Scaffold(
      appBar: AppBar(
        leading:IconButton(onPressed: (){
          navigatorKey.currentState!.pop(context);
        }, icon: Icon(Icons.arrow_back_ios , color: Theme.of(context).iconTheme.color,),) ,
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

              
              Column(
                children: List.generate(
                cubit.categories.length, (i) => 
              primaryCategories(
                count: cubit.categories[i].count,
                context: context,
                name: cubit.categories[i].name,
                
                function: (){
                PropertiesCubit.get(context).navigateToExploreFromCategory(context: context, i: cubit.categories[i].id);
                
              })),
              )
              

          ],
        )
        ),
    );
  
    }, 
    listener: (context,states){

    });
   
  }

}