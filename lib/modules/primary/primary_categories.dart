import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/main.dart';
import 'package:newavenue/models/locations/locations_cubit.dart';
import 'package:newavenue/models/locations/locations_states.dart';
import 'package:newavenue/models/primary/primary_cubit.dart';
import 'package:newavenue/modules/primary/primary_explore.dart';
import 'package:newavenue/shared/components/custom_loading.dart';
import 'package:newavenue/shared/router.dart';

class PrimaryCategories extends StatelessWidget {
  const PrimaryCategories({Key? key}) : super(key: key);

  @override
   Widget build(BuildContext context) {
    LocationCubit cubit = LocationCubit.get(context);
    return BlocConsumer<LocationCubit,LocationStates>
    (builder: (context,states){
         return Scaffold(
      appBar: AppBar(
        leading:IconButton(onPressed: (){
          CustomRouter.pop();
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
                  count: cubit.locations[i].count,
                  name: cubit.locations[i].name, function: (){
                  PrimaryCubit.get(context).getPrimaryByLocation(id: cubit.locations[i].id, context: context);
                  CustomRouter.normalPush(screen: const PrimaryExploreScreen());
              
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
    required int count,
    required Function function , 
    required BuildContext context
  }
)=>ListTile(
  onTap: (){
    function();
  },
  subtitle: Text('$count Properties Found' , style: Theme.of(context).textTheme.bodyMedium,),
  title: Text(name,style: Theme.of(context).textTheme.displaySmall,),
);