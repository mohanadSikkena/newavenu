

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/ads/ads_states.dart';

import '../../shared/network/remote/dio_helper.dart';
import 'ad_model.dart';

class AdsCubit extends Cubit<AdsStates>{
  AdsCubit():super(AdInitialState());
  static AdsCubit get(context)=>BlocProvider.of(context);
    List<Ad>ads=[];
    bool adsLoading=true;

    getAds()async{
    ads=[];
    adsLoading =true;
    emit(AdsLoading());
    await DioHelper.getData(url: '/ads').then((value){
      value.data['data'].forEach((map){
        Ad ad =Ad.fromMap(map);
        ads.add(ad);
      });
      adsLoading=false;
      emit(GetAdsState());
    });

  }

}