import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/properties_states.dart';
import 'package:newavenue/shared/components/custom_button.dart';
import 'package:newavenue/shared/styles/styles.dart';

import '../../shared/styles/colors.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PropertiesCubit cubit = PropertiesCubit.get(context);

    return BlocConsumer<PropertiesCubit, PropertiesStates>(
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
                  Text(
                    "Sort Options",
                    style: f15TextGraySemibold_1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  for (int i = 0; i < cubit.sortOptionsList.length; i++)
                    sortOptions(
                        text: cubit.sortOptionsList[i],
                        function: () {
                          cubit.changeSortOptions(i);
                        },
                        isSelected: cubit.currentSortIption == i,
                        height: 35,
                        topMargin:10),
                  const SizedBox(
                    height: 27,
                  ),
                  Text(
                    'Options',
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
                            height: 30,
                            decoration: BoxDecoration(
                                color: cubit.currentOption == 0 ? primaryColor : white,
                                border: cubit.currentOption == 1
                                    ? Border.all(color: primaryColor, width: 1)
                                    : null,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            child: Text(
                              'Resail',
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
                            height: 30,
                            child: Text(
                              'Primary',
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
                  const SizedBox(
                    height: 27,
                  ),
                  Text(
                    "Price Range",
                    style: f15TextGraySemibold_1,
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
                            NumberFormat.currency(symbol: 'EGP ')
                                .format(cubit.currentRangeValues.start),
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
                  Text(
                    "Area Sqm",
                    style: f15TextGraySemibold_1,
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
                            cubit.areaRangeValues.start.round().toString() + " M",
                            cubit.areaRangeValues.end.round().toString() + " M"),
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
                          cubit.applyFilter(context);
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
