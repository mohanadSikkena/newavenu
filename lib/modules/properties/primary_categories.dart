import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/main.dart';
import 'package:newavenue/modules/properties/primary_explore.dart';
import 'package:newavenue/shared/components/custom_loading.dart';

import '../../models/properties/properties_cubit.dart';
import '../../models/properties/properties_states.dart';
import '../../shared/styles/colors.dart';


class PrimaryCategories extends StatelessWidget {
  const PrimaryCategories({Key? key}) : super(key: key);

  @override
   Widget build(BuildContext context) {
    PropertiesCubit cubit = PropertiesCubit.get(context);
    return BlocConsumer<PropertiesCubit,PropertiesStates>
    (builder: (context,states){
         return Scaffold(
      appBar: AppBar(
        leading:IconButton(onPressed: (){
          navigatorKey.currentState!.pop(context);
        }, icon:  Icon(Icons.arrow_back_ios,color: Theme.of(context).iconTheme.color),) ,
        elevation: 0.0,
      ),
      body:cubit.primaryCategoriesLoading?customLoading(): Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(left:16),
        child: ListView(
          scrollDirection: Axis.vertical,
          
          children: [
            Text('Location',
            style:Theme.of(context).textTheme.displayLarge
            ),
            const SizedBox(height: 15,),

              
              
              
              Column(
                children: List.generate(cubit.locations.length ,(i) =>primaryCategories(
                  context: context,
                  name: cubit.locations[i].name, function: (){
                  cubit.getPrimaryByLocation(id: cubit.locations[i].id, context: context);
                  navigatorKey.currentState!.push(MaterialPageRoute(builder: (_){
                    return const PrimaryExploreScreen();
                  }));
              
              }) )
              )
              

          ],
        )
        ),
    );
  
    }, 
    listener: (context,states){

    });
   
  }

}Widget primaryCategories(
  {
    required String name,
    required Function function , 
    required BuildContext context
  }
)=>InkWell(
  onTap: (){
    function();
  },
  child:Container(
    alignment: Alignment.centerLeft,
  
    decoration: BoxDecoration(
  
      border: BorderDirectional(bottom: BorderSide(color: gray_2,width: 1),)
  
      
  
    ),
  
    height:60 ,
  
    padding: const EdgeInsets.only(top:8,bottom: 8),
  
    child: Text(name,style: Theme.of(context).textTheme.displaySmall,),
  
  
  
  ),
);