import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/properties_states.dart';
import 'package:newavenue/modules/properties/categories.dart';
import 'package:newavenue/shared/components/buy_rent_custom_button.dart';
import 'package:newavenue/shared/components/category_widget.dart';
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

              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
        
                  Text(
                      '\nSet Location',
                      style: f17TextBlackRegular
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right:20.0),
                      child: Text(
                  '\nNews',
                  style: f17TextBlackRegular,
                ),
                    ),
                ],
              ),
              const SizedBox(height: 5,),
              
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
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_){
                          return const CategoriesScreen();
                        }));
                      },
                      child: Row(
                        children: [
                          Text('See all',style: f11TextPrimarySemibold,),
                          Icon(Icons.chevron_right_rounded,color: primaryColor,)
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15,),
                SizedBox(
                  height: 188,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cubit.testCategories.length,
                    itemBuilder: (context,i){
                      
                      return categoryWidget
                      (
                      icon: cubit.testCategories[i]["icon"], 
                      name: cubit.testCategories[i]["name"], 
                      properties: cubit.testCategories[i]["len"],
                       
                      image: cubit.testCategories[i]['img'],
                      function: (){
                        cubit.navigateToCategoriesExplore(i, context);
                      }
        
                      );
                    }),
                
                )
                ,
                const SizedBox(height: 16,),
                Container(
                  height: 400,
                  child: ListView.builder(
                    
                    itemCount: 2,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,i){
                      
                      return Container(
                        height: 400,
                        width: 400,
                        
                         margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:AssetImage(images[i]),),
                    
                  
                ),
                      );
                    }),
                
                
               

                
                ),


                const SizedBox(height: 16),     
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Near by',style: f15TextGraySemibold_1,),
                    InkWell(
                      onTap: (){},
                      child: Row(
                        children: [
                          Text('See all',style: f11TextPrimarySemibold,),
                          Icon(Icons.chevron_right_rounded,color: primaryColor,)
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height:15,),
                SizedBox(
                  height:266,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cubit.allProperties.length,
                    itemBuilder: (context,i){
                      return nearbyWidget(
                        function: (){
                          cubit.changePropertyFavourite(cubit.allProperties[i]);
                        },
                        property: cubit.allProperties[i],
                        context: context,
                        
                      );
                    }),
                ),
                Text("Explore all ${cubit.allProperties.length}+ properties",style: f15TextGraySemibold_1,),
                
                for(int i =0 ;i<cubit.allProperties.length;i++)
                
                Container(
                  child: propertyWidget(
                    
                    context: context,
                    property: cubit.allProperties[i],                
                 
                  ),
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




