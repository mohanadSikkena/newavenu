import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/agent/agent_model.dart';
import 'package:newavenue/models/filter/filter_cubit.dart';
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
  final String _phone="01154973622";
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
  int fromSearch = 0;
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
    fromSearch = 1;
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
    fromSearch = 0;
    filterApplied = false;
    searchValue = '';
    FilterCubit.get(context).resetFilter();
    Navigator.pop(context);

    emit(ExploreBackState());
  }

  applyFilter(context) async{
    exploreLoading=true;
    exploreProperties=[];
    emit(ExploreLoading());
    // Navigator.push(context, MaterialPageRoute(builder: (_) {
    //   return const ExploreScreen();
    // }));
        Navigator.pop(context);

    FilterCubit cubit = FilterCubit.get(context);
    // List options = ['resail', 'primary'];
    // int type=cubit.currentOption;
  
    // double minPrice = ;
      // double maxPrice = ;
      // double minArea = cubit.areaRangeValues.start;
      // double maxArea = cubit.areaRangeValues.end;
      // String option = cubit.options[currentOption];
      // fromSearch
      //     ? 'search then apply filter'
      //     : 'get from category then apply filter';
      // exploreProperties= properties comming from DB;


    await DioHelper.getData(
      url: 
      '/properties/filter?from_search=$fromSearch&word=${
        fromSearch==1?searchWord:null}&sub_category_id=${fromSearch==1?null :selectedSubCategory}&min_price=${
        cubit.currentRangeValues.start.toInt()
        
        }&max_price=${
        cubit.currentRangeValues.end.toInt()
        
        }&min_area=${
          
          cubit.areaRangeValues.start.toInt()
          }&max_area=${
            
            cubit.areaRangeValues.end.toInt()
            }&sale_type=${
              cubit.saleType+1
            }&category=${cubit.currentOption+1}').
        then((value) {
          
              value.data.forEach((map){ 
                map["agent"]=Agent.fromMap(map["agent"]);
                Property property=Property.fromMap(map);
                favourites.contains(property.id)?property.isFavourite=true:null;
                exploreProperties.add(property);
              });
      
    });
    exploreLoading=false;
    emit(GetFilterProperties());
    }

  
// &min_area=200&max_area=600&sale_type=2&category=1
}


