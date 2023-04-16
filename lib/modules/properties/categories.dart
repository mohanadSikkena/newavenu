import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/main.dart';
import 'package:newavenue/models/categories/categories_cubit.dart';
import 'package:newavenue/models/categories/categories_states.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/modules/properties/primary_categories.dart';

import '../../shared/components/buy_rent_custom_button.dart';
import '../../shared/styles/colors.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoriesCubit cubit = CategoriesCubit.get(context);
    return BlocConsumer<CategoriesCubit, CategoriesStates>(
        builder: (context, states) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: white,
              scrolledUnderElevation: 0.0,
              leading: IconButton(
                onPressed: () {
                  navigatorKey.currentState!.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              elevation: 0.0,
            ),
            body: Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 16),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Text('Categories',
                        style: Theme.of(context).textTheme.displayLarge),
                    const SizedBox(
                      height: 15,
                    ),
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
                                cubit.changeSelectedSaleType(1);
                              },
                              child: buyRentButton
                                ( context: context,text: 'Buy',selected: cubit.selectedSaleType==1?true:false)
                          ),
                          const SizedBox(width: 20,),
                          InkWell(
                            onTap: (){
                              cubit.changeSelectedSaleType(2);
                            },
                            child: buyRentButton( context: context,text: 'Rent',selected: cubit.selectedSaleType==2?true:false),
                          )

                        ],
                      ),
                    ),
                    Column(
                      children: List.generate(
                          cubit.categories.length,
                          (i) => primaryCategories(
                              count: cubit.categories[i].count,
                              context: context,
                              name: cubit.categories[i].name,
                              function: () {
                                PropertiesCubit.get(context)
                                    .navigateToExploreFromCategory(
                                        context: context,
                                        i: cubit.categories[i].id);
                              })),
                    )
                  ],
                )),
          );
        },
        listener: (context, states) {});
  }
}
