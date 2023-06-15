


class Constant{
  

  static const List<Map<String, dynamic>> _onBoardingScreens = [
    {
      "title": "Discover place near you",
      "details":
          "Find the best place you want by your location or neighborhood",
      "img":
          "images/onboarding/onboarding-1.jpg"
    },
    {
      "title": "Search for place easily",
      "details":
          "Decide where to sleep with family and friends to enjoy the beautiful day",
      "img":
          "images/onboarding/onboarding-2.jpg"
    },
    {
      "title": "Ready to move in beautiful place",
      "details":
          "A beautiful day with hot chocolate in a new place with loved ones",
      "img":
          "images/onboarding/onboarding-3.jpg"
    }
  ];
  static List<Map<String,dynamic>> get onBoardingScreens => _onBoardingScreens;


  static const List<Map<String, dynamic>> _categories = [
    {
      'name': "Primary",
      "img":
          "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80",
    },
    {
      'name': "Resale",
      "img":
          "https://images.unsplash.com/photo-1554469384-e58fac16e23a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
    },
    
  ];

  static List<Map<String, dynamic>> get categories =>_categories;
}