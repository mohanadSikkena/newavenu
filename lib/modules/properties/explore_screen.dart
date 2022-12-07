

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/properties_states.dart';
import 'package:newavenue/modules/properties/filter_screen.dart';
import 'package:newavenue/shared/components/custom_loading.dart';
import 'package:newavenue/shared/components/property_widget.dart';

import '../../shared/styles/colors.dart';
import '../../shared/styles/styles.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      PropertiesCubit cubit = PropertiesCubit.get(context);
      return BlocConsumer<PropertiesCubit,PropertiesStates>(
        builder: (context,states){
           return Scaffold(
      appBar: AppBar(
        
        actionsIconTheme: IconThemeData(color: black),
        
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_){
                return const FilterScreen();
              }));
            },
            // ignore: prefer_const_constructors
            icon: Icon(
              Icons.filter_alt_sharp,
            ),
          ),
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.map_sharp))
        ],
        leading:IconButton(onPressed: (){
          cubit.exploreBackFunction(context);
        }, icon: const Icon(Icons.arrow_back_ios),color: black,) ,
        backgroundColor: white,
        elevation: 0.0,
      ),
      backgroundColor: white,
      body: cubit.exploreLoading? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const Text('Loading') , 
          const SizedBox(height: 10,) , 
          customLoading()
        ]),
      ) :Container(
        margin: const EdgeInsets.only(left:16,),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Text('Explore',
            style:f34DisplayBlackBold
            ),
            
            Text("\n${cubit.exploreProperties.length} properties",style: f15TextGraySemibold_1,),
            for(int i = 0;i < cubit.exploreProperties.length ;i ++)
            propertyWidget(
              context: context,
              property: cubit.exploreProperties[i],

            )
          ],
        ),
      ),
    );
  
        }, 
        listener: (context,states){});
   }
}
