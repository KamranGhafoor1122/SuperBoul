import 'package:flutter/material.dart';
import 'package:superlotto/Constant/ApiConstant.dart';
import 'package:superlotto/models/language_model.dart';

class LanguageProvider with ChangeNotifier {
   LanguageRepo? languageRepo;

  LanguageProvider({this.languageRepo});

  int _selectIndex = 0;

  int get selectIndex => _selectIndex;

  void setSelectIndex(int index) {
    _selectIndex = index;
    notifyListeners();
  }

  List<LanguageModel> _languages = [];

  List<LanguageModel> get languages => _languages;

  void searchLanguage(String query, BuildContext context) {
    if (query.isEmpty) {
      _languages.clear();
      _languages = languageRepo!.getAllLanguages(context);
      notifyListeners();
    } else {
      _selectIndex = -1;
      _languages = [];
      languageRepo!.getAllLanguages(context).forEach((product) async {
        if (product.languageName.toLowerCase().contains(query.toLowerCase())) {
          _languages.add(product);
        }
      });
      notifyListeners();
    }
  }

  void initializeAllLanguages(BuildContext context) {
    if (_languages.length == 0) {
      _languages.clear();
      _languages = languageRepo!.getAllLanguages(context);
    }
  }
}

class LanguageRepo {
  List<LanguageModel> getAllLanguages(BuildContext context) {
    return ApiConst.languages;
  }
}

