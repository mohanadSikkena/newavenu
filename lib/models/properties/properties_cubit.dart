import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/properties/properties_states.dart';
import 'package:newavenue/models/properties/property_model.dart';
import 'package:newavenue/shared/network/remote/dio_helper.dart';

import '../../modules/properties/explore_screen.dart';
import '../../modules/properties/property_screen.dart';
import '../../modules/search_screen.dart';

class PropertiesCubit extends Cubit<PropertiesStates> {
  PropertiesCubit() : super(PropertiesInitialState());
  static PropertiesCubit get(context) => BlocProvider.of(context);

  FocusNode homePageSearchNode = FocusNode();

  List<Property> allProperties = [];
  List<Property> favouriteProperties = [];
  List<Property> exploreProperties = [];
  late Property currentProperty;

  List<Map<String, dynamic>> testCategories = [
    {
      'name': "Residential",
      'len': 12,
      "img":
          "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80",
      "icon": Icons.house
    },
    {
      'name': "Commercial",
      'len': 27,
      "img":
          "https://images.unsplash.com/photo-1554469384-e58fac16e23a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
      "icon": Icons.business
    },
    {
      'name': "Condo",
      'len': 7,
      "img":
          "https://images.unsplash.com/photo-1568605114967-8130f3a36994?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80",
      "icon": Icons.garage
    },
  ];

  String homePageSelected = 'buy';
  String categoriesSelected = 'buy';
  bool filterApplied = false;
  bool fromCategories = false;
  bool fromSearch = false;
  late String selectedCategoryName;
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
    Response response=await dioHelper.getData(url: "/properties/$id");
    currentProperty=Property.fromMap(response.data);
    emit(GetProperty());
    Navigator.push(context, MaterialPageRoute(builder: (_) {
        return PropertyScreen();
      })
      );
  }
  index() async{

    
   Response response =await dioHelper.getData(url: '/properties/');
    response.data.forEach((element) {
      Property property = Property.fromMap(element);
      allProperties.add(property);
    });

    emit(GetAllProperties());
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

  navigateToCategoriesExplore(int i, context) {
    fromCategories = true;
    categoriesSelected = testCategories[i]['name'];
    exploreProperties.add(allProperties[0]);
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return const ExploreScreen();
    }));
    emit(RouteToExploreScreen());
  }

  navigeToSearchExplore(String search, context) {
    fromSearch = true;
    searchValue = search;
    exploreProperties.add(allProperties[1]);
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return const ExploreScreen();
    }));
    emit(RouteToExploreScreen());
  }

  changePropertyFavourite(Property property){
    property.isFavourite=!property.isFavourite;
    property.isFavourite?favouriteProperties.contains(property)?
    null:favouriteProperties.add(property)
    :
    favouriteProperties.contains(property)?favouriteProperties.remove(property):null;
    emit(ChangePropertyFavourite());

  }

  exploreBackFunction(BuildContext context) {
    exploreProperties = [];
    fromSearch = false;
    fromCategories = false;
    filterApplied = false;
    selectedCategoryName = '';
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