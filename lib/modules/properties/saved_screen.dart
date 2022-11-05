

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/properties_states.dart';
import 'package:newavenue/shared/components/saved_widget.dart';
import 'package:newavenue/shared/styles/colors.dart';

import '../../shared/styles/styles.dart';


class SavedScreen extends StatelessWidget {
  const SavedScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PropertiesCubit cubit =PropertiesCubit.get(context);   

  return BlocConsumer<PropertiesCubit,PropertiesStates>
  (builder:(context,states){
      return Scaffold(
      backgroundColor: white,
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
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const SizedBox(height: 40,),
            Text('Saved',
            style:f34DisplayBlackBold
            ),
            
            Text("\n${cubit.favouriteProperties.length} properties",style: f15TextGraySemibold_1,),
            for(int i = 0;i < cubit.favouriteProperties.length ;i ++)
            SavedWidget(
              property: cubit.favouriteProperties[i],
              function:(){
                 cubit.changePropertyFavourite(cubit.favouriteProperties[i]);
              },
              )
          ],
        ),
      ),
    
    );
  
  } , 
  listener:(context,states){} );
  }

}