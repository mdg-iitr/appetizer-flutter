import 'package:flutter/material.dart';

class LeaveDropdownFilter extends StatefulWidget{

  @override
  _LeaveDropdownFilterState createState() => _LeaveDropdownFilterState();
}

class _LeaveDropdownFilterState extends State<LeaveDropdownFilter> {
  final _yearList = [
    DateTime.now().year,
    DateTime.now().year-1,
    DateTime.now().year-2,
    DateTime.now().year-3,
    DateTime.now().year-4,
  ];

  final _monthList = [
    'All', 'January', 'February', 'March', 'April', 'May', 'June', 'July',
    'August', 'September', 'October', 'November', 'December'
  ];

  int _currentYearSelected = DateTime.now().year;
  String _currentMonthSelected = 'All';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.0,
      width: 395,
      color: const Color.fromRGBO(121, 85, 72, 1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 12.0, 16.0, 4.0),
                child: Text(
                  'Filter by',
                  style: TextStyle(
                    fontSize: 16.5,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 0.0),
                        child: Text(
                          'Month',
                          style: TextStyle(
                              color: const Color.fromRGBO(0, 0, 0, 0.54),
                              fontSize: 16.5
                          ),
                        ),
                      ),
                      Container(
                        width: 182.0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: const Color.fromRGBO(0, 0, 0, 0.15)
                                    )
                                )
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _currentMonthSelected,
                                items: _monthList.map((String dropDownMonthItem){
                                  return DropdownMenuItem<String>(
                                    value: dropDownMonthItem,
                                    child: Text(
                                      '$dropDownMonthItem',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String newMonthSelected){
                                  _onDropDownMonthSelected(newMonthSelected);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 0.0),
                        child: Text(
                          'Year',
                          style: TextStyle(
                              color: const Color.fromRGBO(0, 0, 0, 0.54),
                              fontSize: 16.5
                          ),
                        ),
                      ),
                      Container(
                        width: 182.0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: const Color.fromRGBO(0, 0, 0, 0.15)
                                    )
                                )
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: _currentYearSelected,
                                items: _yearList.map((int dropDownYearItem){
                                  return DropdownMenuItem<int>(
                                    value: dropDownYearItem,
                                    child: Text(
                                      '$dropDownYearItem',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (int newYearSelected){
                                  _onDropDownYearSelected(newYearSelected);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onDropDownMonthSelected(String newMonthSelected){
    setState(() {
      this._currentMonthSelected = newMonthSelected;
    });
  }

  void _onDropDownYearSelected(int newYearSelected){
    setState(() {
      this._currentYearSelected = newYearSelected;
    });
  }

}
