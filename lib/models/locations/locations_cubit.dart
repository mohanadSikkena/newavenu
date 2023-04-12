

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/locations/location_model.dart';
import 'package:newavenue/models/locations/locations_states.dart';

import '../../main.dart';
import '../../modules/properties/primary_categories.dart';
import '../../shared/network/remote/dio_helper.dart';

class LocationCubit extends Cubit<LocationStates>{
  LocationCubit():super(LocationIitialState());
  static LocationCubit get(context)=>BlocProvider.of(context);
    List<Location>locations=[];
    bool primaryCategoriesLoading=true;


    navigateToPrimaryCategories({required BuildContext context})async{
    primaryCategoriesLoading=true;
    locations=[];
    emit(ChangePrimaryCategoriesLoading());
    navigatorKey.currentState!.push(MaterialPageRoute(builder: (_){
        return const PrimaryCategories();
      })
      );
    await DioHelper.getData(url: '/locations').then((value) {
      value.data['data'].forEach((map){ 
        Location location=Location.fromMap(map);
        locations.add(location);
      });
      primaryCategoriesLoading=false;
      emit(ChangePrimaryCategoriesLoading());
      


    });

  }


}