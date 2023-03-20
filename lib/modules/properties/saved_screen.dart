

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/properties_states.dart';
import 'package:newavenue/shared/components/custom_loading.dart';
import 'package:newavenue/shared/components/saved_widget.dart';

import '../../shared/styles/styles.dart';


class SavedScreen extends StatelessWidget {
  const SavedScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PropertiesCubit cubit =PropertiesCubit.get(context)..getFavourites();   

  return BlocConsumer<PropertiesCubit,PropertiesStates>
  (builder:(context,states){
      return Scaffold(
      // appBar: AppBar(
      //   actionsIconTheme: IconThemeData(color: black),
      //   actions: [
      //     IconButton(
      //       onPressed: (){
              
      //       },
      //       // ignore: prefer_const_constructors
      //       icon: Icon(
      //         Icons.filter_alt_sharp,
      //       ),
      //     ),
      //     IconButton(
      //       onPressed: (){},
      //       icon: Icon(Icons.map_sharp))
      //   ],
      //   backgroundColor: white,
      //   elevation: 0.0,
      // ),
      body: Container(
        
        margin: const EdgeInsets.only(left:16,),
        child:cubit.favouritesLoading?customLoading() :ListView(
          scrollDirection: Axis.vertical,
          children: [
            const SizedBox(height: 40,),
            Text('Saved',
            style:Theme.of(context).textTheme.displayLarge
            ),
            
            Text("\n${cubit.favouriteProperties.length} properties",style: f15TextGraySemibold_1,),
            for(int i = 0;i < cubit.favouriteProperties.length ;i ++)
            SavedWidget(
              context: context,
              property: cubit.favouriteProperties[i],
              function:(){
                 cubit.changeSavedFavourite(cubit.favouriteProperties[i]);
              },
              )
          ],
        ),
      ),
    
    );
  
  } , 
  listener:(context,states){
  } );
  }

}