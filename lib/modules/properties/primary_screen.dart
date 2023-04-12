import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/main.dart';
import 'package:newavenue/models/primary/primary_cubit.dart';
import 'package:newavenue/models/primary/primary_states.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/shared/components/custom_loading.dart';
import 'package:newavenue/shared/components/loading_dialog.dart';
import 'package:newavenue/shared/network/remote/dynamic_helper.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'image_screen.dart';


class PrimaryScreen extends StatelessWidget {
  const PrimaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PrimaryCubit cubit = PrimaryCubit.get(context);
    return BlocConsumer<PrimaryCubit, PrimaryStates>(
        builder: (context, states) {
          return Scaffold(
            backgroundColor: black,
            body: cubit.primaryScreenLoading
                ? customLoading()
                : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          children: [
                            CarouselSlider.builder(
                                itemCount: cubit.currentPrimary.images.length,
                                itemBuilder: (context, i, j) {
                                  return Container(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (_) {
                                          return ImageScreen(
                                            images: cubit.currentPrimary.images,
                                          );
                                        }));
                                      },
                                      child: Image(
                                          loadingBuilder:
                                              (context, child, loadingProgress) {
                                            return loadingProgress == null
                                                ? child
                                                : customLoading();
                                          },
                                          filterQuality: FilterQuality.high,
                                          excludeFromSemantics: true,
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              cubit.currentPrimary.images[i])),
                                    ),
                                    // ignore: prefer_const_constructors
                                    decoration: BoxDecoration(
                                      border: BorderDirectional(
                                          bottom: BorderSide(
                                              width: 1, color: gray_3)),
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  enableInfiniteScroll: false,
                                    height: 404,
                                    autoPlay: true,
                                    viewportFraction: 1,
                                    onPageChanged: (i, k) {
                                      cubit.changePrimaryImage(
                                          i, cubit.currentPrimary);
                                    })),
                            SizedBox(
                              height: 380,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(
                                            Icons.arrow_back_ios,
                                            color: white,
                                          )),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: 20,
                                          width: 35,
                                          decoration: BoxDecoration(
                                              color: black,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            '${cubit.currentPrimary.currentImage + 1}/${cubit.currentPrimary.images.length}',
                                            style: f13TextWhiteRegular,
                                          ),
                                        ),
                                        // Text(
                                        //   '${cubit.currentPrimary.minSpace} - ${cubit.currentPrimary.maxSpace} Sqm',
                                        //   style: f17TextWhiteMedium,
                                        // ),
                                        // Text(
                                        //   cubit.currentPrimary.price,
                                        //   style: f20TextWhiteSemibold,
                                        // ),
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
                                        activeDotColor: gray_3),
                                    activeIndex:
                                        cubit.currentPrimary.currentImage,
                                    count: cubit.currentPrimary.images.length),
                              ),
                            )
                          ],
                        ),
                
                
                
                // Flexible(
                //   child: Card(
                //     margin:const EdgeInsets.only(top: 16 , left: 4 , right: 4,bottom: 4),

                //     child: GridView.count(
                //       mainAxisSpacing: 0.0,
                //        childAspectRatio: 3,
                //       crossAxisCount: 2,
                //       shrinkWrap: true,
                //       padding: EdgeInsets.zero,
                //       physics: const NeverScrollableScrollPhysics(),
                //       children: [
                          
                //           customListTile(name: 'Project Name', data: cubit.currentPrimary.name),
                //           customListTile(name: 'Developer Name', data: cubit.currentPrimary.developerName),
                //           customListTile(name: 'Location', data: cubit.currentPrimary.location),
                //           customListTile(name: 'Property Type', data: cubit.currentPrimary.propertyType),
                        
                        
                //         // Add more ListTiles as needed
                //       ],
                //     ),
                //   ),
                // ),


                 

                Flexible(
                  child: Card(
                    
                    child: Column(
                      
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text('Project Name:${cubit.currentPrimary.name}')
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text('Project Name:${cubit.currentPrimary.name}')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Flexible( 
                  child: Card(
                    child:Column(
                      children: [
                        ListTile(
                          
                          leading: Text('Project Name:${cubit.currentPrimary.name} '), 
),
                        ListTile(
                          
                          leading: Text('Project Name:${cubit.currentPrimary.name} '), 
),
                       
                      ],
                    )
                      
                     ),
                ),
                Flexible( 
                  child: Card(
                    child:Column(
                      children: [
                        ListTile(
                          
                          leading: Text('Project Name:'),
                          title: Text(cubit.currentPrimary.name), 
),
                        ListTile(
                          
                          leading: Text('Project Name:'),
                          title: Text(cubit.currentPrimary.name), 
),
                       
                      ],
                    )
                      
                     ),
                ),
                Flexible(
                  child: Card(

                    child: GridView.count(
                      mainAxisSpacing: 0.0,
                       childAspectRatio: 3,
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [

                          customListTile(name: 'Min Price per meter', data: cubit.currentPrimary.minPricePerMeter),
                          customListTile(name: 'Max Price Per meter', data: cubit.currentPrimary.maxPricePerMeter),
                          customListTile(name: 'Min Total price', data: cubit.currentPrimary.minTotalPrice),
                        
                        
                        // Add more ListTiles as needed
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Card(
                    child: GridView.count(
                      mainAxisSpacing: 0.0,
                       childAspectRatio: 3,
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [

                          customListTile(name: 'Min Space', data: cubit.currentPrimary.minSpace),
                          customListTile(name: 'Max Space', data: cubit.currentPrimary.maxSpace),
                          customListTile(name: 'Delivery Date', data: cubit.currentPrimary.deliveryDate),
                        
                        
                        // Add more ListTiles as needed
                      ],
                    ),
                  ),
                ),
                

                
                
                                    
                      
                                    
                                    
                                    
                                    
                                    
                                    
                
                      
                     
                     
                            
                            
                            
                            
                         
                          
                
                          
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
                              loadingDialog(context: context);
                              HelperClass helperClass=HelperClass();
                              String messege=await helperClass.createDynamicLink(category: 'primary' , id: cubit.currentPrimary.id).then((value) {
                                
                                Navigator.pop(context);
                                return value;
                              });
                              bool canLaunchWhatsapp=await canLaunchUrl(Uri.parse('whatsapp://send'));
                              if(canLaunchWhatsapp){
                                await launchUrl(Uri.parse(
                                "whatsapp://send?phone=" + PropertiesCubit.get(context).phone + "&text=$messege"));
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const  SnackBar(
                
                                      content: Text('WhatsApp is not installed on your device.'),
                                    ),
                                  );
                              }
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
                            await launchUrl(Uri(scheme: 'tel',path: PropertiesCubit.get(context).phone));
                
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
                          
                      
                      ]
                
                
                   
                    ),
                ),
          );
        },
        listener: (context, states) {});
  }
}

Widget customListTile({required String name, required String data}){
  return ListTile(
    key: GlobalKey(),
    title: Text(name, style: f13TextWhiteRegular,),
    subtitle: Text(data, style:f15TextWhiteRegular ,),
  );
}