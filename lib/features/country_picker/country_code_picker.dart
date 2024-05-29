library countrycodepicker;

import 'package:flutter/material.dart';
import 'package:mortuary/core/styles/colors.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';

import '../../core/constants/app_strings.dart';
import '../../core/constants/place_holders.dart';
import '../splash/domain/entities/splash_model.dart';
import 'country.dart';
import 'functions.dart';

const TextStyle _defaultItemTextStyle =  TextStyle(fontSize: 16);
const TextStyle _defaultSearchInputStyle =  TextStyle(fontSize: 16);
const String _kDefaultSearchHintText = AppStrings.searchCountry;


class CountryPickerWidget extends StatefulWidget {
  /// This callback will be called on selection of a [Country].
  final ValueChanged<dynamic>? onSelected;

  /// [itemTextStyle] can be used to change the TextStyle of the Text in ListItem. Default is [_defaultItemTextStyle]
  final TextStyle itemTextStyle;

  /// [searchInputStyle] can be used to change the TextStyle of the Text in SearchBox. Default is [searchInputStyle]
  final TextStyle searchInputStyle;

  /// [searchInputDecoration] can be used to change the decoration for SearchBox.
  final InputDecoration? searchInputDecoration;

  /// Flag icon size (width). Default set to 32.
  final double flagIconSize;

  ///Can be set to `true` for showing the List Separator. Default set to `false`
  final bool showSeparator;

  ///Can be set to `true` for opening the keyboard automatically. Default set to `false`
  final bool focusSearchBox;

  ///This will change the hint of the search box. Alternatively [searchInputDecoration] can be used to change decoration fully.
  final String searchHintText;


  bool isFromApi = false;
  List<RadioOption>? countryApiList;

   CountryPickerWidget({
    Key? key,
    this.onSelected,
    this.itemTextStyle = _defaultItemTextStyle,
    this.searchInputStyle = _defaultSearchInputStyle,
    this.searchInputDecoration,
    this.searchHintText = _kDefaultSearchHintText,
    this.flagIconSize = 32,
    this.showSeparator = false,
    this.focusSearchBox = false,
    this.isFromApi = false,
    this.countryApiList
  }) : super(key: key);

  @override
  _CountryPickerWidgetState createState() => _CountryPickerWidgetState();
}

class _CountryPickerWidgetState extends State<CountryPickerWidget> {
  List<dynamic> _list = [];
  List<dynamic> _filteredList = [];
  TextEditingController _controller = new TextEditingController();
  ScrollController _scrollController = new ScrollController();
  bool _isLoading = false;
  dynamic _currentCountry;



  void _onSearch(text) {
    if (text == null || text.isEmpty) {
      setState(() {
        _filteredList.clear();
        _filteredList.addAll(_list);
      });
    } else {
      setState(() {
        if(widget.isFromApi == false) {
          _filteredList = _list
              .where((element) =>
          element.name
              .toLowerCase()
              .contains(text.toString().toLowerCase()) ||
              element.callingCode
                  .toLowerCase()
                  .contains(text.toString().toLowerCase()) ||
              element.countryCode
                  .toLowerCase()
                  .startsWith(text.toString().toLowerCase()))
              .map((e) => e)
              .toList();
        }
        else
          {
            _filteredList = _list .where((element) =>
            element.name
                .toLowerCase()
                .contains(text.toString().toLowerCase()))
                .map((e) => e)
                .toList();
          }
      });
    }
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    });
    loadList();
    super.initState();
  }

  void loadList() async {
    setState(() {
      _isLoading = true;
    });
    if(widget.isFromApi == false) {
      _list = await getCountries(context);
      try {
        // String? code = await FlutterSimCountryCode.simCountryCode;
        // _currentCountry =
        //     _list.firstWhere((element) => element.countryCode == code);
        final country = _currentCountry;
        if (country != null) {
          _list.removeWhere(
                  (element) => element.callingCode == country.callingCode);
          _list.insert(0, country);
        }
      } catch (e) {} finally {
        setState(() {
          _filteredList = _list.map((e) => e).toList();
          _isLoading = false;
        });
      }
    }else
      {
        _list = widget.countryApiList!;
        setState(() {
          _filteredList = _list.map((e) => e).toList();
          _isLoading = false;
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: TextField(
            style: widget.searchInputStyle,
            autofocus: widget.focusSearchBox,
            decoration: widget.searchInputDecoration ??
                InputDecoration(
                  suffixIcon: Visibility(
                    visible: _controller.text.isNotEmpty,
                    child: InkWell(
                      child: Icon(Icons.clear),
                      onTap: () => setState(() {
                        _controller.clear();
                        _filteredList.clear();
                        _filteredList.addAll(_list);
                      }),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                  hintText: widget.searchHintText,
                ),
            textInputAction: TextInputAction.done,
            controller: _controller,
            onChanged: _onSearch,
          ),
        ),
        sizeFieldMinPlaceHolder,
        Expanded(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  padding: EdgeInsets.only(top: 16),
                  controller: _scrollController,
                  itemCount: _filteredList.length,
                  separatorBuilder: (_, index) =>
                      widget.showSeparator ? Divider() : Container(),
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        widget.onSelected?.call(_filteredList[index]);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            bottom: 12, top: 12, left: 24, right: 24),
                        child: Row(
                          children: <Widget>[

                            Visibility(
                              visible: widget.isFromApi == false,
                              child: widget.isFromApi == false
                                  ? Image.asset(
                                _filteredList[index].flag,
                                width: widget.flagIconSize,
                              )
                                  : const SizedBox(), // If flag is null, render an empty SizedBox
                            ),

                       sizeHorizontalFieldMinPlaceHolder,
                            Expanded(
                                child: CustomTextWidget(
                              //'${_filteredList[index].callingCode} ${_filteredList[index].name}',
                               text: widget.isFromApi ?_filteredList[index].nationality:_filteredList[index].name,
                                  size: 16,
                                  colorText: AppColors.secondaryTextColor,
                            )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
