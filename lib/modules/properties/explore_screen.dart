

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/properties_states.dart';
import 'package:newavenue/shared/components/custom_loading.dart';
import 'package:newavenue/shared/components/property_widget.dart';

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
        // backgroundColor: Theme.of(context).colorScheme.background,
        leading:IconButton(onPressed: (){
          cubit.exploreBackFunction(context);
        }, icon:  Icon(Icons.arrow_back_ios,color: Theme.of(context).iconTheme.color)) ,
        elevation: 0.0,
      ),
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
            style:Theme.of(context).textTheme.displayLarge
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
