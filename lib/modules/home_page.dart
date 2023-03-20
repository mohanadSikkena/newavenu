import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/main.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/properties_states.dart';
import 'package:newavenue/modules/contact_us.dart';
import 'package:newavenue/modules/properties/categories.dart';
import 'package:newavenue/shared/components/ad_widget.dart';
import 'package:newavenue/shared/components/buy_rent_custom_button.dart';
import 'package:newavenue/shared/components/category_widget.dart';
import 'package:newavenue/shared/components/custom_loading.dart';
import 'package:newavenue/shared/components/custom_text_field.dart';
import 'package:newavenue/shared/components/nearby_widget.dart';
import 'package:newavenue/shared/components/property_widget.dart';
import 'package:newavenue/shared/constant.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';





class HomePage extends StatelessWidget {
   const HomePage({ Key? key }) : super(key: key);


  @override
  
Widget build(BuildContext context) {
      PropertiesCubit cubit=PropertiesCubit.get(context);

      return BlocConsumer<PropertiesCubit,PropertiesStates>(
        builder: (context,states){
          
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryColor,
        onPressed: (){
        
        navigatorKey.currentState!.push(MaterialPageRoute(builder: (_){
          return ContactUsScreen();
        }));
      }, label: Row(
        children:const [
          Text('Contact Us'), 
          SizedBox(width: 8,),
          Icon(Icons.support_agent)
        ],
      )
      
      ),
      // backgroundColor: white,
      body: Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(left:16,),
        child: ListView(
          controller: cubit.scrollController..addListener(() {
            if(cubit.scrollController.offset==
            cubit.scrollController.position.maxScrollExtent&&!cubit.loadingPage&&cubit.count>cubit.homeProperties.length){
              cubit.getHomePagePaginate();
            }
          }),
          
            
          children:  [

            const SizedBox(height: 10,),
            
            Row(
              mainAxisSize: MainAxisSize.min,
children: [

  Padding(
              padding: const EdgeInsets.only(right:12.0),
              child: Image.asset(Theme.of(context).backgroundColor==black? 'images/white_logo_crop.png':'images/black_logo_crop.png',height:50 ,alignment: Alignment.center),
            ),

            Flexible(
              child: customTextField(
                controller: TextEditingController(),
                onSubmit: (){},
                node: cubit.homePageSearchNode,
                readOnly: true,
                onTapFunction: (){
                  cubit.homePageSearchFunction(context);
                  
                },
                text: 'Search...',
                ),
            ),
],
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
                      ( context: context,text: 'Buy',selected: cubit.homePageSelected=='buy'?true:false)
                      ),
                    const SizedBox(width: 20,),
                    InkWell(
                      onTap: (){
                        cubit.changeSelectedHomePage("rent");
                      },
                      child: buyRentButton( context: context,text: 'Rent',selected: cubit.homePageSelected=='rent'?true:false),
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
                    categoryWidget(name: Constant.categories[0]['name'], image:Constant.categories[0]['img'] , function: (){
                      cubit.navigateToPrimaryCategories(context:context);
                    }),
                    categoryWidget(name: Constant.categories[1]['name'], image:Constant.categories[1]['img'] , function: (){
                      navigatorKey.currentState!.push(MaterialPageRoute(builder: (_){
                       return const CategoriesScreen();
                      }));
                    })
                ],)

              
              )
              ,
              const SizedBox(height: 16,),
              cubit.adsLoading? customLoading():
              cubit.ads.isNotEmpty?
              CarouselSlider.builder(
                options: CarouselOptions(
                autoPlay: true,
              

              enlargeCenterPage: true,
              autoPlayInterval:const   Duration(seconds: 10),

              
              height: 320,
            
              
            ),
                
                itemCount: cubit.ads.length,
                itemBuilder: (context,i,j){
                  
                  return adWidget(context: context, ad: cubit.ads[i])
                  
                  ;
                }):const SizedBox(),


              const SizedBox(height: 16),     
              cubit.mostViewd.isNotEmpty? Text('Most Views',style: f15TextGraySemibold_1,):const SizedBox(),
              const SizedBox(height:15,),
              cubit.mostViewd.isNotEmpty? SizedBox(
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
              ):const SizedBox(),
              Text(cubit.allPropertiesLoading?"Loading":"Explore all ${cubit.count}+ properties",style: f15TextGraySemibold_1,),
              
              cubit.allPropertiesLoading?customLoading() :
              Column(
                children: [
                  for(int i =0 ;i<cubit.homeProperties.length;i++)
              
              propertyWidget(
                
                context: context,
                property: cubit.homeProperties[i],                
               
              ),
                ],
              )
            
          ],
        ),
      ),
    );
  
        }, 
        listener: (context,states){
        });
    



  }

}




