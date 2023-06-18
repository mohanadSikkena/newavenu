

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/primary/primary_states.dart';
import 'package:newavenue/shared/router.dart';

import '../../main.dart';
import '../../modules/primary/primary_screen.dart';
import '../../shared/network/remote/dio_helper.dart';
import 'primary_model.dart';

class PrimaryCubit extends Cubit<PrimaryStates>{
  PrimaryCubit():super(PrimaryInitialState());
  static PrimaryCubit get(context)=>BlocProvider.of(context);

  // ExpansionControl selectedExpansion=ExpansionControl.none;

  // changeSelectedExpansion({required ExpansionControl value}){
  //   selectedExpansion=value;
  //   emit(ChangeSelectedExpaninsionValue());
  // }

    changeHomePagePrimaryImage(int currentIndex, ExplorePrimary property) {
    property.currentImage = currentIndex;
    emit(ChangePropertyWidgetImage());
  }

  changePrimaryImage(int currentIndex, Primary property) {
    property.currentImage = currentIndex;
    emit(ChangePropertyWidgetImage());
  }


  late Primary currentPrimary;
  bool primaryScreenLoading=true;

  List<Primary>primaryHistory=[];
  propertyPop(){
    CustomRouter.pop();
    primaryHistory.removeLast();
    primaryHistory.isNotEmpty?{currentPrimary=primaryHistory.last}:null;
    emit(PrimaryPopState());
  }

  getPrimaryProperty({required int id,required BuildContext context})async{
    primaryScreenLoading=true;
    emit(PrimaryPropertyLoading());
    CustomRouter.animatedNavigateTo(screen: const PrimaryScreen());

    await DioHelper.getData(url: '/primary/$id').then((value) {
      currentPrimary=Primary.fromMap(value.data);
      primaryHistory.add(currentPrimary);
      primaryScreenLoading=false;
    emit(PrimaryPropertyLoading());
    });
  }

  
  List<ExplorePrimary> primaryProperties=[];
  bool primaryExploreLoading=true;


  getPrimaryByLocation({required int id, required BuildContext context})async{
    primaryExploreLoading=true;
    primaryProperties=[];
    emit(PrimaryPropertiesExploreLoading());

    await DioHelper.getData(url: '/locations/$id/primary').then((value){
      value.data['data'].forEach((map){ 
        ExplorePrimary property=ExplorePrimary.fromMap(map);
        primaryProperties.add(property);
      });
      primaryExploreLoading=false;
      emit(PrimaryPropertiesExploreLoading());
    });

    

  }
}