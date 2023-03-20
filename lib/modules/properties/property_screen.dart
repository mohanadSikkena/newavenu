import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/main.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/properties_states.dart';
import 'package:newavenue/modules/agent/agent_details.dart';
import 'package:newavenue/modules/properties/image_screen.dart';
import 'package:newavenue/shared/components/custom_loading.dart';
import 'package:newavenue/shared/styles/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/network/remote/dynamic_helper.dart';
import '../../shared/styles/colors.dart';



class PropertyScreen extends StatelessWidget {
   // ignore: use_key_in_widget_constructors
  const PropertyScreen({Key? key ,
  }) ;


  @override
  Widget build(BuildContext context) {


     PropertiesCubit cubit = PropertiesCubit.get(context);
     return BlocConsumer<PropertiesCubit,PropertiesStates>
     (builder: (context,states){
        return Scaffold(
      backgroundColor: black,
      body: cubit.propertyLoading?customLoading():ListView(
        scrollDirection: Axis.vertical,
        children: [
          Stack(
            children: [
              CarouselSlider.builder
                (
                itemCount: cubit.currentProperty.images.length, 
              itemBuilder: (context,i,j){
                return Container(
                  child: InkWell(
                    onTap: (){
                      navigatorKey.currentState!.push(MaterialPageRoute(builder: (_){
                        return  ImageScreen(images: cubit.currentProperty.images,);
                      }));
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image(
                          loadingBuilder: (context, child, loadingProgress) {
                            return loadingProgress==null?child:customLoading();
                          },
                          filterQuality: FilterQuality.high,
                          excludeFromSemantics: true,
                          fit: BoxFit.fill,
                          image: NetworkImage(cubit.currentProperty.images[i])),
                      const Image(
                        height: 200, 
                        width: 200,
                        image: AssetImage(
                          'images/black_logo.png') ,fit:BoxFit.cover ,)
                      ],
                    ),
                  ),
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                border: BorderDirectional(bottom: BorderSide(
                  width: 1,
                  color: gray_3
                )),
          
              ),
              
              
              
            );
              }, options: CarouselOptions(
                height: 404 ,
                autoPlay: true,
                viewportFraction: 1,
                onPageChanged: (i,k){
                  cubit.changeHomePagePropertiesImage(i, cubit.currentProperty);
                }
                
                
              )),
              
              
              SizedBox(
                height: 380 ,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: (){
                          navigatorKey.currentState!.pop(context);
                        }
                      , icon: Icon(Icons.arrow_back_ios,color: white,)
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: (){
                              cubit.changePropertyFavourite(cubit.currentProperty);
                            }, 
                            icon: Icon(
                              cubit.currentProperty.isFavourite? Icons.favorite:Icons.favorite_border,
                              color: cubit.currentProperty.isFavourite?favoriteColor: white,),),
                              IconButton(onPressed: (){
                          HelperClass helperClass=HelperClass();
                          helperClass.createDynamicLink(id: cubit.currentProperty.id, category: 'resail').then((value){
                            helperClass.shareData(messege: value,);
                          });
                        }, icon: Icon(
                          Icons.share, color: white,
                        ))
                            
                        ],
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 20,
                          width: 35,
                          decoration: BoxDecoration(
                          color: black,

                          borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text('${cubit.currentProperty.currentImage+1}/${cubit.currentProperty.images.length}',style: f13TextWhiteRegular,),
                        ),
                        Text('${cubit.currentProperty.area} Sqm',style: f17TextWhiteMedium,),
                        Row(
                          children: [
                            Text(cubit.currentProperty.price,style: Theme.of(context).textTheme.displaySmall,),
                            Container(
                              alignment: Alignment.center,
                              height: 20,
                              width: 80,
                              padding: const EdgeInsets.only(left: 10 , right: 10),
                              margin: const EdgeInsets.only(left: 10),
                              child: Text(cubit.currentProperty.saleType,style: f13TextWhiteMedium,),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          ],
                        ),
                        Text(cubit.currentProperty.subCategory,style: f15TextWhiteSemibold,),
                        
                      
                      
                      ],
                    ),
                  )
                ],
            ),
              ),

          SizedBox(
            height: 400,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedSmoothIndicator(
              effect: ScrollingDotsEffect(
                activeDotScale: 1.2,
                dotWidth: 12,
                dotHeight: 12,
                
                dotColor: gray_2,
                activeDotColor: gray_3
              ),
              activeIndex: cubit.currentProperty.currentImage, 
               
              count: cubit.currentProperty.images.length),
            ),
          )
              
            ],
            
          ),




          // ignore: prefer_const_constructors
          ListTile(
            onTap: (){
              cubit.getAgentProperties(cubit.currentProperty.agent.id);
              navigatorKey.currentState!.push( 
              MaterialPageRoute(builder: (_){
                return AgentDetails( agent: cubit.currentProperty.agent, );
              }));
            },
            
            contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
            // ignore: prefer_const_constructors
            leading: CircleAvatar(
              
              
              
              child: Image(
                fit: BoxFit.fill,
                image: NetworkImage(cubit.currentProperty.agent.img,)), 
              
              radius: 40,
              ),
              title: Text(cubit.currentProperty.agent.name,style: f15TextWhiteSemibold,),
              subtitle: Text(cubit.currentProperty.agent.about,style: f12TextWhiteRegular,),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16,top: 16),
            child: Text('Description ', style: f15TextGraySemibold_1,)),
            Container(
            margin: const EdgeInsets.only(left: 16,top: 16),
            child: Text(cubit.currentProperty.description, style: f15TextWhiteRegular,)),
            for(int i=0;i<cubit.currentProperty.details.length;i++)
            Row(
              children: [
                Container(
                margin: const EdgeInsets.only(left: 16,top: 16),
                child: Text(cubit.currentProperty.details[i]["name"]+" :", 
                style: f15TextWhiteRegular,)),
                Container(
                margin: const EdgeInsets.only(left: 4,top: 16),
                child: Text(cubit.currentProperty.details[i]["details"], 
                style: f15TextWhiteRegular,)),
              ],
            ),
            
            
            Container(
            margin: const EdgeInsets.only(left: 16,top: 16),
            child: Text('Features ', style: f15TextGraySemibold_1,)),
            Container(
              margin: const EdgeInsets.only(top: 16,left: 16),
              height: 56,
              child: ListView.builder(
                itemCount: cubit.currentProperty.features.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,i){
                  return Column(
                    children: [
                      featuresWidget(feature:cubit.currentProperty.features[i]),
                    ],
                  );
                  // return Container();
                }
                ),
            ),
            Container(
            margin: const EdgeInsets.only(left: 16,top: 16),
            child: Text('Location ', style: f15TextGraySemibold_1,)),
            Container(
            margin: const EdgeInsets.only(left: 16,top: 16),
            child: Text(cubit.currentProperty.location, style: f15TextWhiteRegular,)),
           
            const SizedBox(
              height: 16,
            ),

            Container(
              margin: const EdgeInsets.only(left: 16,right: 16),
              height:50,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: 
                        const 
                        BorderRadius.only(topLeft: Radius.circular(10),
                        bottomLeft:  Radius.circular(10) )
                      ),
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          border: BorderDirectional(end: BorderSide(
                            color: gray_2,width: 1
                          ))
                        ),
                        child: InkWell(
                          onTap: ()async{
                            HelperClass helperClass=HelperClass();
                            String messege =await helperClass.createDynamicLink(category: 'resail', id: cubit.currentProperty.id);
                            await launchUrl(Uri.parse("whatsapp://send?phone=" + cubit.phone + "&text=$messege"));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat_bubble_rounded,color: white),
                                const SizedBox(width: 10,),
                                Text('Chat',style: f17TextWhiteSemibold,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(10),bottomRight:  Radius.circular(10) )
                      ),
                      height: 50,
                      child: InkWell(
                        onTap: ()async{
                          await launchUrl(Uri(scheme: 'tel',path: cubit.phone));

                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.call,color: white),
                                const SizedBox(width: 10,),
                                Text('Call',style: f17TextWhiteSemibold,)
                            ],
                          ),
                      ),
                    ),
                  )
                  ],
              ),
            ),
            
            
            const SizedBox(height: 10,)
          
        ],
      )
      
    );
  
     }, 
     listener: (context,states){});
     
  }
}


Widget featuresWidget({
  required String feature
})=>Flexible(
  child:   Container(
  
    alignment: Alignment.center,
  
  
    decoration: BoxDecoration(
  
      color: white,
  
      borderRadius: BorderRadius.circular(10)
  
  
  
    ),
  
    margin: const EdgeInsets.only(right: 16),
    padding: const EdgeInsets.only(left: 10,right: 10),
  
    child: Text(feature,style: f13TextPrimarySemibold,),
  
  ),
);