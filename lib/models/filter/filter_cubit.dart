



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/filter/filter_states.dart';

class FilterCubit extends Cubit<FilterStates>{
  FilterCubit() : super(FilterInitialState());
  static FilterCubit get(context)=>BlocProvider.of(context);
  RangeValues currentRangeValues = const RangeValues(0, 20000000);
  RangeValues areaRangeValues = const RangeValues(0, 4000);
  int currentOption = 0;
  int saleType = 0;
  
  resetFilter() {
    currentRangeValues = const RangeValues(0, 20000000);
    areaRangeValues = const RangeValues(0, 4000);
    currentOption = 0;
    saleType=0; 
    emit(ResetFilter());
  }

  changeSaleType(int i){
    saleType=i;
    emit(ChangeSaleType());
  }

    changeCurrentOption(int i) {
    currentOption = i;
    emit(ChangeCurrentOption());
  }
   changePriceRangeValues(value) {
    currentRangeValues = value;
    emit(ChangePriceRangeValue());
  }
  changeAreaRangeValue(values) {
    areaRangeValues = values;
    emit(ChangeAreaRangeValue());
  }



}