


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
  int selectedSaleType = 1;
  List<Category> categories=[];

  changeSelectedSaleType(int selected) async {
    selectedSaleType = selected;
    emit((ChangeSelectedSaleType()));
    await getCategories();
  }

  getCategories()async{
    categories=[];
    emit(CategoriesLoading());
    await DioHelper.getData(url: '/v2/categories?sell_type_id=$selectedSaleType').then((value) {

      value.data.forEach((map){
        Category category=Category.fromMap(map);
        categories.add(category);
      });
      emit(GetCategoriesSuccess());
    }).onError((error, stackTrace) {

      emit(GetCategoriesFailed());
    });
  }
  navigateToCategories({required BuildContext context})async{
    categories=[];
    emit(CategoriesLoading());
    navigatorKey.currentState!.push(MaterialPageRoute(builder: (_){
      return const  CategoriesScreen();
    }));
    await getCategories();



  }

}