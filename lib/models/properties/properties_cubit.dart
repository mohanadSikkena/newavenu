import 'package:dio/dio.dart';
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


  List<AgentProperty>agentRent=[];
  List<AgentProperty>agentSale=[];

  late Property currentProperty;
  List<Property> mostViewd=[];
  List<Property> rent=[];
  List<Property> buy=[];
  List<Property> allProperties = [];
  List<Property> exploreProperties = [];
  List<FavouriteProperty> favouriteProperties=[];
  List<int>favourites=[];
  List<Ad>ads=[];
  bool agentPropertiesLoading=true;
  bool adsLoading=true;
  bool mostViewsLoading=true;
  bool allPropertiesLoading=true;
  bool propertyLoading=true;



  List<Map<String, dynamic>> categories = [
    {
      'name': "Primary",
      "img":
          "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80",
    },
    {
      'name': "Brokrage",
      "img":
          "https://images.unsplash.com/photo-1554469384-e58fac16e23a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
    },
    
  ];
  List<Map<String,dynamic>>subCategories=[
    {
      "id":1,
      "name":"show rooms",
      "img":"https://images.unsplash.com/photo-1554469384-e58fac16e23a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"   
    },
    {
      "id":2,
      "name":"retails",
      "img":          "https://images.unsplash.com/photo-1554469384-e58fac16e23a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
  
    },
    {
      "id":3,
      "name":"food and bavrege",
      "img":          "https://images.unsplash.com/photo-1554469384-e58fac16e23a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
  
    },
    {
      "id":4,
      "name":"malls",
      "img":          "https://images.unsplash.com/photo-1554469384-e58fac16e23a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
  
    },
    {
      "id":5,
      "name":"offices",
      "img":          "https://images.unsplash.com/photo-1554469384-e58fac16e23a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
  
    },
    {
      "id":6,
      "name":"buildings",
      "img":          "https://images.unsplash.com/photo-1554469384-e58fac16e23a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
  
    },
    {
      "id":7,
      "name":"co-work space",
      "img":          "https://images.unsplash.com/photo-1554469384-e58fac16e23a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
  
    },
    {
      "id":8,
      "name":"factories",
      "img":          "https://images.unsplash.com/photo-1554469384-e58fac16e23a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
  
    },
    {
      "id":9,
      "name":"warehouses",
      "img":          "https://images.unsplash.com/photo-1554469384-e58fac16e23a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
  
    },
    {
      "id":10,
      "name":"car service stations",
      "img":          "https://images.unsplash.com/photo-1554469384-e58fac16e23a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
  
    },
    {
      "id":11,
      "name":"clinic",
      "img":          "https://images.unsplash.com/photo-1554469384-e58fac16e23a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
  
    },
    {
      "id":12,
      "name":"hospital",
      "img":          "https://images.unsplash.com/photo-1554469384-e58fac16e23a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
  
    },
    {
      "id":13,
      "name":"income property",
      "img":          "https://images.unsplash.com/photo-1554469384-e58fac16e23a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
  
    },
  ];
  String homePageSelected = 'buy';
  String categoriesSelected = 'buy';
  bool filterApplied = false;
  bool fromCategories = false;
  bool fromSearch = false;
  bool exploreLoading=true;
  bool favouritesLoading=true;
  late int selectedCategory;
  late int selectedSubCategory;
  late String searchValue;

  //******************Filter */

  RangeValues currentRangeValues = const RangeValues(0, 20000000);
  RangeValues areaRangeValues = const RangeValues(0, 4000);
  int currentOption = 0;
  int currentSortIption = 0;
  List<String> sortOptionsList = [
    'Listing Price (High to Low)',
    'Listing Price (Low to High)',
    'Year Built (Newer to Older)',
    'Square Feet (High to Small)',
    'Lot Size (Big to Small)',
  ];
  //**************************** */
  changeSelectedHomePage(String selected) {
    homePageSelected = selected;
    emit(ChangeHomePageSelected());
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
        return PropertyScreen();
      })
      );
    await dioHelper.getData(url: "/properties/$id").then((value) {
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
    await dioHelper.getData(url: '/properties/most-views').then((value){
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
    await dioHelper.getData(url: '/properties/ads').then((value){
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
    await dioHelper.getData(url: '/customer/$id/favourite').then((value){
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
    allProperties=[];
    
    await getFavourites();
    allPropertiesLoading=true;
    emit(AllPropertiesLoading());
     
         
    
   Response response =await dioHelper.getData(url: '/properties/');
    response.data.forEach((element) {
      element["agent"]=Agent.fromMap(element["agent"]);
      Property property = Property.fromMap(element);
      favourites.contains(property.id)?property.isFavourite=true:property.isFavourite=false;
      allProperties.add(property);
    });
    allPropertiesLoading=false;

    emit(GetAllProperties());
  }





  getAgentProperties(int id)async{
    agentRent=[];
    agentSale=[];
    agentPropertiesLoading=true;
    await dioHelper.getData(url: '/agents/$id/properties').then((value) {
      value.data.forEach((map){
        AgentProperty property = AgentProperty.fromMap(map);
        map['sell_type_id']==1?agentSale.add(property):agentRent.add(property);
      });
    });
    agentPropertiesLoading=false;
    emit(GetAgentProperties());
  }




  resetFilter() {
    currentRangeValues = const RangeValues(0, 20000000);
    areaRangeValues = const RangeValues(0, 4000);
    currentOption = 0;
    currentSortIption = 0;
    emit(ResetFilter());
  }

  changeSortOptions(int i) {
    currentSortIption = i;
    emit(ChangeSortOption());
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
    await dioHelper.getData(url: '/properties/get-by-category?category_id=$selectedCategory&sub_category_id=$selectedSubCategory').then((value) {
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
      return CategoriesScreen();
    }) );
  }

  navigeToSearchExplore(String search, context)async{
    exploreLoading=true;
    
    exploreProperties=[];
    emit(ExploreLoading());
    fromSearch = true;
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return const ExploreScreen();
    }));
    await dioHelper.getData(url: '/properties/search?word=$search').then((value){
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
    await dioHelper.setData(query:{"property_id":property.id,"customer_id":id},url:"/customer/add-to-favourite").then((value) {
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
    await dioHelper.setData(query:{"property_id":property.id,"customer_id":id},url:"/customer/add-to-favourite").then((value) {
    }) ;



    emit(ChangePropertyFavourite());

  }

  exploreBackFunction(BuildContext context) {
    exploreProperties = [];
    fromSearch = false;
    fromCategories = false;
    filterApplied = false;
    searchValue = '';
    resetFilter();
    Navigator.pop(context);

    emit(ExploreBackState());
  }

  applyFilter(context) {
    // List options = ['resail', 'primary'];
    // double minPrice = currentRangeValues.start;
    // double maxPrice = currentRangeValues.end;
    // double minArea = areaRangeValues.start;
    // double maxArea = areaRangeValues.end;
    // String option = options[currentOption];
    // String sort = sortOptionsList[currentSortIption];
    fromSearch
        ? 'search then apply filter'
        : 'get from category then apply filter';
    // exploreProperties= properties comming from DB;
    Navigator.pop(context);
  }

  

}


// GET * FROM properties WHERE 