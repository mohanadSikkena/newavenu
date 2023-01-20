import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/agent/agent_model.dart';
import 'package:newavenue/models/properties/properties_states.dart';
import 'package:newavenue/models/properties/property_model.dart';
import 'package:newavenue/modules/properties/categories.dart';
import 'package:newavenue/shared/network/local/cache_helper.dart';
import 'package:newavenue/shared/network/remote/dio_helper.dart';

import '../../modules/properties/explore_screen.dart';
import '../../modules/properties/property_screen.dart';
import '../../modules/search_screen.dart';

class PropertiesCubit extends Cubit<PropertiesStates> {
  PropertiesCubit() : super(PropertiesInitialState());
  static PropertiesCubit get(context) => BlocProvider.of(context);

  FocusNode homePageSearchNode = FocusNode();

  ScrollController scrollController = ScrollController();
  final String _phone="+201154973622";
  String get phone=>_phone;
  List<AgentProperty>agentRent=[];
  List<AgentProperty>agentSale=[];
  bool loadingPage=false;
  late Property currentProperty;
  List<Property> mostViewd=[];
  List<Property> homeProperties = [];
  List<Property> exploreProperties = [];
  List<FavouriteProperty> favouriteProperties=[];
  List<int>favourites=[];
  List<Ad>ads=[];
  bool agentPropertiesLoading=true;
  bool adsLoading=true;
  bool mostViewsLoading=true;
  bool allPropertiesLoading=true;
  bool propertyLoading=true;
  late String searchWord;
  late int count;
  int currentPage=1;



  
 
  
  String homePageSelected = 'buy';
  String categoriesSelected = 'buy';
  bool exploreLoading=true;
  bool favouritesLoading=true;
  late int selectedCategory;
  late int selectedSubCategory;
  late String searchValue;

  //******************Filter */

  
  
  //**************************** */
  changeSelectedHomePage(String selected) async{
    homePageSelected = selected;
    emit(ChangeHomePageSelected());
    await getHomeProperties();
  }

  changeCategoriesSelected(String selected) {
    categoriesSelected = selected;
    emit(ChangeCategoriesSelected());
  }

  homePageSearchFunction(BuildContext context) {
    homePageSearchNode.unfocus();
    emit(HomePageSearchUnfocus());
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return SearchScreen();
    }));
  }

  changeHomePagePropertiesImage(int currentIndex, Property property) {
    property.currentImage = currentIndex;
    emit(ChangePropertyWidgetImage());
  }





  getProperty(int id,BuildContext context)async{
    propertyLoading=true;
    emit(PropertyLoading());
    Navigator.push(context, MaterialPageRoute(builder: (_) {
        return const PropertyScreen();
      })
      );
    await DioHelper.getData(url: "/properties/$id").then((value) {
      value.data["agent"]=Agent.fromMap(value.data["agent"]);

      currentProperty=Property.fromMap(value.data);
      favourites.contains(currentProperty.id)?currentProperty.isFavourite=true:null;

    });
    
    // currentProperty=allProperties.firstWhere((element){
    //   return element.id==id;
    // });
    propertyLoading=false;
    emit(GetProperty());
    
  }



  mostViews()async{ 
    mostViewd=[];
    mostViewsLoading=true;
    emit(MostViewsLoading());
    await DioHelper.getData(url: '/properties/most-views').then((value){
      value.data.forEach((element){
        element["agent"]=Agent.fromMap(element["agent"]);
        Property property = Property.fromMap(element);
        favourites.contains(property.id)?property.isFavourite=true:property.isFavourite=false;
        mostViewd.add(property);

      });
    });
    mostViewsLoading=false;
    emit(GetMostViews());
  }

  getAds()async{
    ads=[];
    adsLoading =true;
    emit(AdsLoading());
    await DioHelper.getData(url: '/properties/ads').then((value){
      value.data.forEach((map){
        Ad ad =Ad.fromMap(map);
        ads.add(ad);
      });
      adsLoading=false;
      emit(GetAdsState());
    });

  }
    getFavourites()async{
    favourites=[];
    favouriteProperties=[];
    favouritesLoading=true;
    emit(ChangeFavouritesLoading());
    int id =await CacheHelper.getData(key: 'id');
    await DioHelper.getData(url: '/customer/$id/favourite').then((value){
      value.data["favourite"].forEach((fav){    
        favourites.add(fav["id"]);
        FavouriteProperty property=FavouriteProperty.fromMap(fav);
        favouriteProperties.add(property);
      });

    });
    favouritesLoading=false;
    emit(GetFavourites());

  }
  index() async{
    homeProperties=[];
    
    await getFavourites();


    getHomeProperties();
    
  }

  getHomeProperties()async{
    homeProperties=[];
    allPropertiesLoading=true;
    emit(AllPropertiesLoading());
    await DioHelper.getData(url: '/properties?sell_type=$homePageSelected').then((response) {
      response.data["properties"]['data'].forEach((element) {
      element["agent"]=Agent.fromMap(element["agent"]);
      Property property = Property.fromMap(element);
      favourites.contains(property.id)?property.isFavourite=true:property.isFavourite=false;
      homeProperties.add(property);
    });
    count=response.data['count'];
    allPropertiesLoading=false;
    });
    emit(GetAllProperties());
  }


  getHomePagePaginate()async{
    currentPage+=1;
    loadingPage=true;
    emit(ChangePaginationLoading());
    await DioHelper.getData(url: '/properties?sell_type=$homePageSelected&page=$currentPage').then((response){
      response.data["properties"]['data'].forEach((element) {
      element["agent"]=Agent.fromMap(element["agent"]);
      Property property = Property.fromMap(element);
      favourites.contains(property.id)?property.isFavourite=true:property.isFavourite=false;
      homeProperties.add(property);
    });
    loadingPage=false;
    emit(GetAllProperties());
    });
  }





  getAgentProperties(int id)async{
    agentRent=[];
    agentSale=[];
    agentPropertiesLoading=true;
    await DioHelper.getData(url: '/agents/$id/properties').then((value) {
      value.data.forEach((map){
        AgentProperty property = AgentProperty.fromMap(map);
        map['sell_type_id']==1?agentSale.add(property):agentRent.add(property);
      });
    });
    agentPropertiesLoading=false;
    emit(GetAgentProperties());
  }




  

  



 

  

  // navigateToCategoriesExplore(int i, context) {
  //   fromCategories = true;
  //   categoriesSelected = testCategories[i]['name'];
  //   exploreProperties.add(allProperties[0]);
  //   Navigator.push(context, MaterialPageRoute(builder: (_) {
  //     return const ExploreScreen();
  //   }));
  //   emit(RouteToExploreScreen());
  // }

  navigateToExploreFromCategory({
    required int i,
    required BuildContext context 
  })async{
    selectedSubCategory=i;
    exploreLoading=true;
    emit(ChangeSubCategory());
    Navigator.push(context, MaterialPageRoute(builder: (_){
      return const ExploreScreen();
    }));
    await DioHelper.getData(url: '/properties/get-by-category?category_id=$selectedCategory&sub_category_id=$selectedSubCategory').then((value) {
      value.data.forEach((map){
        map["agent"]=Agent.fromMap(map["agent"]);
        Property property=Property.fromMap(map);
        favourites.contains(property.id)?property.isFavourite=true:property.isFavourite=false;
        exploreProperties.add(property); 
        
      });
      exploreLoading=false;
      emit(GetExploreProperties());
    });
  }

  navigateToSubCategories({
    required int i,
    required BuildContext context
  }){
    selectedCategory=i;

    emit(ChangeCategory());
    Navigator.push(context,MaterialPageRoute(builder: (_){
      return const CategoriesScreen();
    }) );
  }

  navigeToSearchExplore(String search, context)async{
    exploreLoading=true;
    
    exploreProperties=[];
    emit(ExploreLoading());
    searchWord=search;
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return const ExploreScreen();
    }));
    await DioHelper.getData(url: '/properties/search?word=$search').then((value){
      value.data.forEach((map){
        map["agent"]=Agent.fromMap(map["agent"]);
        Property property=Property.fromMap(map);
        favourites.contains(property.id)?property.isFavourite=true:null;
        exploreProperties.add(property);
      });
    });
    
    

    exploreLoading=false;
    emit(RouteToExploreScreen());
  }

  changeSavedFavourite(
    FavouriteProperty property
  )async{

    favourites.contains(property.id)?favourites.remove(property.id):favourites.add(property.id);
    favouriteProperties.contains(property)?favouriteProperties.remove(property):null;
        emit(ChangePropertyFavourite());

       int id = CacheHelper.getData(key: 'id');
    await DioHelper.setData(query:{"property_id":property.id,"customer_id":id},url:"/customer/add-to-favourite").then((value) {
    }) ;



    emit(ChangePropertyFavourite());
  }

  changePropertyFavourite(Property property)async{
    property.isFavourite=!property.isFavourite;
    favourites.contains(property.id)?favourites.remove(property.id):favourites.add(property.id);
    
    // property.isFavourite?favouriteProperties.add(property):favouriteProperties.remove(property);
    
    
    // ***************************************************************
    
    favouriteProperties.removeWhere((element) {
      return element.id==property.id;
    },);
    
    emit(ChangePropertyFavourite());
    // property.isFavourite?favouriteProperties.contains(property)?
    // null:favouriteProperties.add(property)
    // :
    // favouriteProperties.contains(property)?favouriteProperties.remove(property):null;
    int id = CacheHelper.getData(key: 'id');
    await DioHelper.setData(query:{"property_id":property.id,"customer_id":id},url:"/customer/add-to-favourite").then((value) {
    }) ;



    emit(ChangePropertyFavourite());

  }

  exploreBackFunction(BuildContext context) {
    exploreProperties = [];
    searchValue = '';
    Navigator.pop(context);

    emit(ExploreBackState());
  }


  
// &min_area=200&max_area=600&sale_type=2&category=1
}


