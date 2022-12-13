


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/search/search_states.dart';
import 'package:newavenue/shared/network/local/cache_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);
  List<String> searchHistory=[];
  getSearch()async{

    searchHistory=await CacheHelper.getList(key: 'searchHistory')??[];
    emit(GetAllSearch());

  }

  saveSearch({required String search})async{
    searchHistory=await CacheHelper.getData(key: 'searchHistory')??[];
    searchHistory.contains(search)?null:{
      searchHistory.add(search),
      await CacheHelper.putList(key: "searchHistory", value: searchHistory)
      

    };
    emit(AddNewSearch());

  }

  deleteSearch({required String search})async{
    searchHistory=await CacheHelper.getData(key: 'searchHistory')??[];
    searchHistory.remove(search);
    await CacheHelper.putList(key: "searchHistory", value: searchHistory);
    emit(DeleteSearch());
   }

}