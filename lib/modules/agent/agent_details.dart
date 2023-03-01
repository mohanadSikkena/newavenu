import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/main.dart';
import 'package:newavenue/models/agent/agent_model.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/properties_states.dart';
import 'package:newavenue/modules/properties/explore_screen.dart';
import 'package:newavenue/shared/components/agent_profile_property_widget.dart';
import 'package:newavenue/shared/components/custom_loading.dart';
import 'package:newavenue/shared/styles/styles.dart';

import '../../shared/styles/colors.dart';


// ignore: must_be_immutable
class AgentDetails extends StatelessWidget {
  Agent agent;
  AgentDetails({ Key? key , required this.agent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PropertiesCubit,PropertiesStates>
    (builder: (context,states){
  return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: white,
          leading: IconButton(
            onPressed: () {
              navigatorKey.currentState!.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: black,
          )),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                border: BorderDirectional(
                    bottom: BorderSide(color: gray_2, width: 1))),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(agent.img),
                  radius: 43,
                ),
                const SizedBox(
                  height: 33,
                ),
                Text(
                  agent.name,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  agent.about,
                  style: f15TextgrayRegular_1,
                ),
                
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                left: 16,
                top: 16),
            child: Column(
              children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Units For Sale',
                        style: f15TextGraySemibold_1,
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     // Navigator.push(context,
                      //     //     MaterialPageRoute(builder: (_) {
                      //     //   return const ExploreScreen();
                      //     // }));
                      //   },
                      //   child: Row(
                      //     children: [
                      //       Text(
                      //         'See all',
                      //         style: f11TextPrimarySemibold,
                      //       ),
                      //       Icon(
                      //         Icons.chevron_right_rounded,
                      //         color: primaryColor,
                      //       )
                      //     ],
                      //   ),
                      // )
                    ]),
                Container(
                  height: 172,
                  margin: const EdgeInsets.only(top: 15),
                  child:PropertiesCubit.get(context).agentPropertiesLoading? customLoading():ListView.builder(
                      itemCount: PropertiesCubit.get(context).agentSale.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        return profilePropertyWidget(
                          property: PropertiesCubit.get(context).agentSale[i] , 
                          context: context);
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Units For Rent',
                        style: f15TextGraySemibold_1,
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     // Navigator.push(context,
                      //     //     MaterialPageRoute(builder: (_) {
                      //     //   return const ExploreScreen();
                      //     // }));
                      //   },
                      //   child: Row(
                      //     children: [
                      //       Text(
                      //         'See all',
                      //         style: f11TextPrimarySemibold,
                      //       ),
                      //       Icon(
                      //         Icons.chevron_right_rounded,
                      //         color: primaryColor,
                      //       )
                      //     ],
                      //   ),
                      // )
                    ]),
                Container(
                  margin: const EdgeInsets.only(top: 15,bottom: 20),
                  height: 172,
                  child:PropertiesCubit.get(context).agentPropertiesLoading? customLoading(): ListView.builder(
                      itemCount: PropertiesCubit.get(context).agentRent.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        return profilePropertyWidget(
                            context: context,
                            property: PropertiesCubit.get(context).agentRent[i]
                            );
                      }),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Agent Description",style: f15TextGraySemibold_1,)),

                 const SizedBox(height: 20,),
                 Align(
                  alignment: Alignment.centerLeft,
                  child: Text(agent.description,
                  style: Theme.of(context).textTheme.labelMedium,)),
                  const SizedBox(height: 30,),
                  
                
              ],
              
            ),
          ),
          
        ],
      ),
    );
  
    }, 
    listener: (context,states){});

  }
}

 

