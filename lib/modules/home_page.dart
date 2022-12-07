import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/properties_states.dart';
import 'package:newavenue/modules/properties/categories.dart';
import 'package:newavenue/shared/components/ad_widget.dart';
import 'package:newavenue/shared/components/buy_rent_custom_button.dart';
import 'package:newavenue/shared/components/category_widget.dart';
import 'package:newavenue/shared/components/custom_loading.dart';
import 'package:newavenue/shared/components/custom_text_field.dart';
import 'package:newavenue/shared/components/nearby_widget.dart';
import 'package:newavenue/shared/components/property_widget.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';




class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  

  @override
  
Widget build(BuildContext context) {
      PropertiesCubit cubit=PropertiesCubit.get(context);
      List<String> images=['images/test-2.jpg','images/test.jpg'];

      return BlocConsumer<PropertiesCubit,PropertiesStates>(
        builder: (context,states){
          
    return Scaffold(


      backgroundColor: white,
      body: Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(left:16,),
        child: SingleChildScrollView(
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
              
            children:  [

              const SizedBox(height: 20,),

              
              Text('Browse',
              style:f34DisplayBlackBold
              ),
              customTextField(
                controller: TextEditingController(),
                onSubmit: (){},
                node: cubit.homePageSearchNode,
                readOnly: true,
                onTapFunction: (){
                  cubit.homePageSearchFunction(context);
                  
                },
                height: 40,  
                text: 'Where do you want to live?',
                ),
                const SizedBox(height: 10,),
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
                          cubit.changeSelectedHomePage("buy");
                        },
                        child: buyRentButton
                        ( text: 'Buy',selected: cubit.homePageSelected=='buy'?true:false)
                        ),
                      const SizedBox(width: 20,),
                      InkWell(
                        onTap: (){
                          cubit.changeSelectedHomePage("rent");
                        },
                        child: buyRentButton( text: 'Rent',selected: cubit.homePageSelected=='rent'?true:false),
                      )
                     
                    ],
                  ),
                ),
                const SizedBox(height: 16,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Categories',style: f15TextGraySemibold_1,),
                    
                  ],
                ),
                const SizedBox(height: 15,),
                SizedBox(
                  height: 188,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      categoryWidget(name: cubit.categories[0]['name'], image:cubit.categories[0]['img'] , function: (){
                        cubit.navigateToSubCategories(i: 1, context: context);
                      }),
                      categoryWidget(name: cubit.categories[1]['name'], image:cubit.categories[1]['img'] , function: (){
                        cubit.navigateToSubCategories(i: 2, context: context);
                      })
                  ],)
                  // ListView.builder(
                  //   scrollDirection: Axis.horizontal,
                  //   itemCount: cubit.testCategories.length,
                  //   itemBuilder: (context,i){
                      
                  //     return categoryWidget
                  //     (
                  //     icon: cubit.testCategories[i]["icon"], 
                  //     name: cubit.testCategories[i]["name"], 
                  //     properties: cubit.testCategories[i]["len"],
                       
                  //     image: cubit.testCategories[i]['img'],
                  //     function: (){
                  //       cubit.navigateToCategoriesExplore(i, context);
                  //     }
        
                  //     );
                  //   }),
                
                )
                ,
                const SizedBox(height: 16,),
                cubit.adsLoading? customLoading():CarouselSlider.builder(

                  options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                autoPlayInterval:const   Duration(seconds: 10),

                
                height: 320,
              
                
              ),
                  
                  itemCount: cubit.ads.length,
                  itemBuilder: (context,i,j){
                    
                    return adWidget(context: context, ad: cubit.ads[i]);
                  }),


                const SizedBox(height: 16),     
                Text('Most Views',style: f15TextGraySemibold_1,),
                const SizedBox(height:15,),
                SizedBox(
                  height:266,
                  child:cubit.mostViewsLoading? customLoading():ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cubit.mostViewd.length,
                    itemBuilder: (context,i){
                      return nearbyWidget(
                        property: cubit.mostViewd[i],
                        context: context,
                        
                      );
                    }),
                ),
                Text("Explore all ${cubit.allProperties.length}+ properties",style: f15TextGraySemibold_1,),
                
                cubit.allPropertiesLoading?customLoading() :
                Column(
                  children: [
                    for(int i =0 ;i<cubit.allProperties.length;i++)
                
                propertyWidget(
                  
                  context: context,
                  property: cubit.allProperties[i],                
                 
                ),
                  ],
                )
              
            ],
          ),
        ),
      ),
    );
  
        }, 
        listener: (context,states){});
    



  }

}




