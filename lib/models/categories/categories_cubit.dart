

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/categories/categories_states.dart';

import '../../main.dart';
import '../../modules/properties/categories.dart';
import '../../shared/network/remote/dio_helper.dart';
import 'category_model.dart';

class CategoriesCubit extends Cubit<CategoriesStates>{
  CategoriesCubit():super(CategoriesInitialState());
  static CategoriesCubit get(context )=>BlocProvider.of(context);

  List<Category> categories=[];  

  navigateToCategories({required BuildContext context})async{
    categories=[];
    emit(CategoriesLoading());

    navigatorKey.currentState!.push(MaterialPageRoute(builder: (_){
      return const  CategoriesScreen();
    }));

    await DioHelper.getData(url: '/categories').then((value) {
      value.data.forEach((map){ 
        Category category=Category.fromMap(map);
        categories.add(category);
      });
      emit(GetCategoriesSuccess());
    }).onError((error, stackTrace) {
      emit(GetCategoriesFailed());
    });


  }

}