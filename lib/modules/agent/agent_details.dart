import 'package:flutter/material.dart';
import 'package:newavenue/modules/properties/explore_screen.dart';
import 'package:newavenue/shared/components/agent_profile_property_widget.dart';
import 'package:newavenue/shared/styles/styles.dart';

import '../../shared/styles/colors.dart';


class AgentDetails extends StatefulWidget {
  const AgentDetails({Key? key}) : super(key: key);

  @override
  State<AgentDetails> createState() => _AgentDetailsState();
}

class _AgentDetailsState extends State<AgentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
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
                  backgroundColor: gray_1,
                  radius: 43,
                ),
                const SizedBox(
                  height: 33,
                ),
                Text(
                  "Agent Name",
                  style: f34DisplayBlackBold,
                ),
                Text(
                  "Land & Happiness Property",
                  style: f15TextgrayRegular_1,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 17,
                  ),
                  height: 80,
                  width:190,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      iconWithText(
                          text: "Favourite",
                          icon: Icons.favorite_border,
                          isFavourite: true,
                          ),
                      iconWithText(
                          text: "Chat", icon: Icons.chat_bubble, ),
                      iconWithText(text: "Call", icon: Icons.call, )
                    ],
                  ),
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
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return const ExploreScreen();
                          }));
                        },
                        child: Row(
                          children: [
                            Text(
                              'See all',
                              style: f11TextPrimarySemibold,
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: primaryColor,
                            )
                          ],
                        ),
                      )
                    ]),
                Container(
                  height: 172,
                  margin: const EdgeInsets.only(top: 15),
                  child: ListView.builder(
                      itemCount: 6,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        return profilePropertyWidget(
                            context: context,
                            name: '284 Flemming Street Henderson, NC 934');
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
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return const ExploreScreen();
                          }));
                        },
                        child: Row(
                          children: [
                            Text(
                              'See all',
                              style: f11TextPrimarySemibold,
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: primaryColor,
                            )
                          ],
                        ),
                      )
                    ]),
                Container(
                  margin: const EdgeInsets.only(top: 15,bottom: 20),
                  height: 172,
                  child: ListView.builder(
                      itemCount: 6,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        return profilePropertyWidget(
                            context: context,
                            name: '284 Flemming Street Henderson, NC 934');
                      }),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Agent Description",style: f15TextGraySemibold_1,)),

                 const SizedBox(height: 20,),
                 Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Thus, only by choosing the right property will enhance and allow you to multiply and grow your property portfolio in a easier and more systematic way without over stretching your financial comfortability. ",
                  style: f15TextBlackRegular,)),
                  const SizedBox(height: 30,),
                  
                
              ],
              
            ),
          ),
          
        ],
      ),
    );
  }
}


  @override
  Widget iconWithText ({
      required String text,
      required IconData icon,
      bool isFavourite = false}) {
    return Column(
      children: [
        Container(
          width:40 ,
          height:60 ,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isFavourite ? white : primaryColor,
              border: isFavourite
                  ? Border.all(color: favoriteColor, width: 2)
                  : null,
              shape: BoxShape.circle),
          child: Icon(
            icon,
            color: isFavourite ? favoriteColor : white,
          ),
        ),
        Text(
          text,
          style: f11TextBlackRegular,
        )
      ],
    );
  }


