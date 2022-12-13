import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:newavenue/models/filter/filter_cubit.dart';
import 'package:newavenue/models/filter/filter_states.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/properties_states.dart';
import 'package:newavenue/shared/components/custom_button.dart';
import 'package:newavenue/shared/styles/styles.dart';

import '../../shared/styles/colors.dart';

// ignore: must_be_immutable
class FilterScreen extends StatelessWidget {
   FilterScreen({Key? key}) : super(key: key);
  CurrencyFormatterSettings egpSettings = CurrencyFormatterSettings(
  symbol: 'EGP',
  symbolSide: SymbolSide.right,
  thousandSeparator: ',',
  decimalSeparator: '.',
  symbolSeparator: ' ',
  
);

  @override
  Widget build(BuildContext context) {
    FilterCubit cubit = FilterCubit.get(context);

    return BlocConsumer<FilterCubit, FilterStates>(
        builder: (context, states) {
          return Scaffold(
            backgroundColor: white,
            appBar: AppBar(
                actions: [
                  InkWell(
                    onTap: () {
                      cubit.resetFilter();
                    },
                    child: Center(
                        child: Text(
                      "Reset",
                      style: f17TextgrayRegular_3,
                    )),
                  )
                ],
                centerTitle: true,
                title: Text(
                  "Filter",
                  style: f17TextBlackSemibold,
                ),
                backgroundColor: white,
                elevation: 0.0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                  color: black,
                )),
            body: Container(
              margin: const EdgeInsets.only(left: 16),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  

                                    Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            cubit.changeSaleType(0);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 35,
                            decoration: BoxDecoration(
                                color: cubit.saleType == 0 ? primaryColor : white,
                                border: cubit.saleType == 1
                                    ? Border.all(color: primaryColor, width: 1)
                                    : null,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            child: Text(
                              'Buy',
                              style: cubit.saleType == 0
                                  ? f13TextWhiteSemibold
                                  : f13TextPrimarySemibold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            cubit.changeSaleType(1);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: cubit.saleType == 0 ? white : primaryColor,
                              border: cubit.saleType == 0
                                  ? Border.all(color: primaryColor, width: 1)
                                  : null,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            height: 35,
                            child: Text(
                              'Rent',
                              style: cubit.saleType == 0
                                  ? f13TextPrimarySemibold
                                  : f13TextWhiteSemibold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16,)
                    ],
                  ),
                  
                  const SizedBox(
                    height: 16,
                  ),
                  
                  BlocBuilder<PropertiesCubit,PropertiesStates>(builder: (context,states){
                    return PropertiesCubit.get(context).fromSearch==0?const SizedBox():Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text( 
                    'Category',
                    style: f15TextGraySemibold_1,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                        Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                cubit.changeCurrentOption(0);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: cubit.currentOption == 0 ? primaryColor : white,
                                    border: cubit.currentOption == 1
                                        ? Border.all(color: primaryColor, width: 1)
                                        : null,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10))),
                                child: Text(
                                  'Primary',
                                  style: cubit.currentOption == 0
                                      ? f13TextWhiteSemibold
                                      : f13TextPrimarySemibold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                cubit.changeCurrentOption(1);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: cubit.currentOption == 0 ? white : primaryColor,
                                  border: cubit.currentOption == 0
                                      ? Border.all(color: primaryColor, width: 1)
                                      : null,
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                height: 35,
                                child: Text(
                                  'Resail',
                                  style: cubit.currentOption == 0
                                      ? f13TextPrimarySemibold
                                      : f13TextWhiteSemibold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16,)
                        ],
                  ),
                      ],
                    );
                  
                    
                  })
                  ,
                  
                  const SizedBox(
                    height: 27,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price Range",
                        style: f15TextGraySemibold_1,
                      ),
                      Padding(
                        padding:const EdgeInsets.only(right: 16),
                        child: Text(
                          cubit.currentRangeValues.start==0&&cubit.currentRangeValues.end==20000000?"~Any~":
                          "${CurrencyFormatter
                                .format(cubit.currentRangeValues.start.toInt(),egpSettings ,compact:true ) } - ${
                                  CurrencyFormatter
                                .format(cubit.currentRangeValues.end.toInt(), egpSettings , compact:true)}",
                          style: f15TextGraySemibold_1,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 15, right: 16),
                    height: 30,
                    child: SliderTheme(
                      data: SliderThemeData(
                          trackHeight: 2,
                          activeTrackColor: primaryColor,
                          inactiveTrackColor: gray_2,
                          thumbColor: white,
                          valueIndicatorTextStyle: f15TextBlackRegular),
                      child: RangeSlider(
                        max: 20000000,
                        min: 0,
                        divisions: 50,
                        labels: RangeLabels(
                            NumberFormat.currency(symbol: 'EGP '  , )
                                .format(cubit.currentRangeValues.start ,) ,
                            NumberFormat.currency(symbol: 'EGP ')
                                .format(cubit.currentRangeValues.end)),
                        values: cubit.currentRangeValues,
                        onChanged: (values) {
                          cubit.changePriceRangeValues(values);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Property Size (Sqm)",
                        style: f15TextGraySemibold_1,
                      ),
                      Padding(padding:const EdgeInsets.only(right: 16) ,
                       child:Text(
                        cubit.areaRangeValues.start==0&&cubit.areaRangeValues.end==4000?"~Any~":
                        "${cubit.areaRangeValues.start.toInt()} - ${cubit.areaRangeValues.end.toInt()} sqm",
                        style: f15TextGraySemibold_1,
                      ), 
                       )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 13, right: 16),
                    height: 30,
                    child: SliderTheme(
                      data: SliderThemeData(
                          trackHeight: 2,
                          activeTrackColor: primaryColor,
                          inactiveTrackColor: gray_2,
                          thumbColor: white,
                          valueIndicatorTextStyle: f15TextBlackRegular),
                      child: RangeSlider(
                        max: 4000,
                        min: 0,
                        divisions: 100,
                        labels: RangeLabels(
                            cubit.areaRangeValues.start.round().toString() + " sqm",
                            cubit.areaRangeValues.end.round().toString() + " sqm"),
                        values: cubit.areaRangeValues,
                        onChanged: (values) {
                          cubit.changeAreaRangeValue(values);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, right: 16),
                    child: customButton(
                        height: 50,
                        text: "Apply Filters",
                        function: () {
                          PropertiesCubit.get(context).applyFilter(context);
                        }),
                  )
                ],
              ),
            ),
          );
        },
        listener: (context, states) {});
  }
}

Widget sortOptions(
        {double topMargin = 10,
        double height = 35,
        required String text,
        bool isSelected = false,
        required Function function}) =>
    InkWell(
      onTap: () {
        function();
      },
      child: Container(
        margin: EdgeInsets.only(top: topMargin),
        height: height,
        decoration: BoxDecoration(
            border:
                BorderDirectional(bottom: BorderSide(color: gray_2, width: 1))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: f17TextBlackSemibold,
            ),
            isSelected
                ? Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.check,
                      color: primaryColor,
                    ))
                : const SizedBox()
          ],
        ),
      ),
    );
