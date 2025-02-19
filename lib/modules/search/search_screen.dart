import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newavenue/main.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/search/search_cubit.dart';
import 'package:newavenue/models/search/search_states.dart';
import 'package:newavenue/shared/components/custom_text_field.dart';
import 'package:newavenue/shared/router.dart';

import '../../shared/styles/colors.dart';
import '../../shared/styles/styles.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  FocusNode node = FocusNode();
  TextEditingController searchController = TextEditingController();
  GlobalKey<FormState> mainKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SearchCubit cubit=SearchCubit.get(context)..getSearch();
    return BlocConsumer<SearchCubit, SearchStates>(
        builder: (context, states) {
          return Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                 CustomRouter.pop();
                },
                icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).iconTheme.color,),
              ),
              elevation: 0.0,
            ),
            body: Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(
                  left: 16,
                ),
                child: ListView(scrollDirection: Axis.vertical, children: [
                  Text('Search', style: Theme.of(context).textTheme.displayLarge),
                  Container(
                    height: 36.h,
                    margin: const EdgeInsets.only(right: 16),
                    child: Form(
                      key: mainKey,
                      child: customTextField(

                          controller: searchController,
                          onSubmit: () {
                            if(searchController.text.isNotEmpty){
                               PropertiesCubit.get(context).navigeToSearchExplore(
                              searchController.text, context);
                              cubit.saveSearch(search: searchController.text);
                            }
                          },
                          node: node,
                          text: 'Search'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "History",
                    style: f15TextGraySemibold_1,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  for(int i =0;i<cubit.searchHistory.length;i++)
                  searchHistory(text: cubit.searchHistory[i], context: context)
                ])),
          );
        },
        listener: (context, states) {});
  }
}

Widget searchHistory({required String text, required BuildContext context}) => InkWell(
  onTap: (){
    PropertiesCubit.get(context).navigeToSearchExplore(text, context);
  },
  child:   Container(
  
        margin: const EdgeInsets.only(top: 7),
  
 
  
        child: Row(
  
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
  
          crossAxisAlignment: CrossAxisAlignment.center,
  
          children: [
  
            SizedBox(
  
                height: 30,
  
                child: Text(
  
                  text,
  
                  style: Theme.of(context).textTheme.headlineLarge,
  
                )),
  
            IconButton(onPressed: (){
              SearchCubit.get(context).deleteSearch(search: text);
            }, icon: const Icon(
  
                  Icons.close,
  
                  color: gray_2,
  
                ),)
  
          ],
  
        ),
  
      ),
);
