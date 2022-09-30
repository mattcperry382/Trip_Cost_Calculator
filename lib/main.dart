import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello You',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FuelForm(),
    );
  }
}

class FuelForm extends StatefulWidget {
  @override
  createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  final _currencies = ['Dollars', 'Euro', 'Pounds'];
  final double _formDistance = 5.0;
  String _currency = 'Dollars';
  TextEditingController distanceController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String result = '';

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Cost Calculator"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: _formDistance,
                bottom: _formDistance,
              ),
              child: Expanded(
                child: TextField(
                  controller: distanceController,
                  decoration: InputDecoration(
                    labelText: 'Distance (Mi/KM)',
                    hintText: "e.g. 100",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: _formDistance,
                bottom: _formDistance,
              ),
              child: Expanded(
                child: TextField(
                  controller: avgController,
                  decoration: InputDecoration(
                    labelText: 'Distance per unit (MPG/KMPL)',
                    hintText: "e.g. 50",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: _formDistance,
                bottom: _formDistance,
              ),
              child: Row(
                children: <Widget>[],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: _formDistance,
                bottom: _formDistance,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: priceController,
                      decoration: InputDecoration(
                        labelText: 'Price',
                        hintText: "e.g. 1.65",
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    width: _formDistance * 5,
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      items: _currencies.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _currency,
                      onChanged: (String? value) {
                        if (value != null) {
                          _onDropdownChanged(value);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: _formDistance,
                bottom: _formDistance,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RawMaterialButton(
                      highlightColor: Theme.of(context).primaryColorDark,
                      fillColor: Theme.of(context).primaryColorLight,
                      onPressed: () {
                        setState(
                          () {
                            result = _calculate();
                          },
                        );
                      },
                      child: const Text(
                        'Submit',
                        textScaleFactor: 1.5,
                      ),
                    ),
                  ),
                  Expanded(
                    child: RawMaterialButton(
                      highlightColor: Theme.of(context).primaryColorLight,
                      fillColor: Theme.of(context).primaryColorDark,
                      onPressed: () {
                        setState(
                          () {
                            _reset();
                          },
                        );
                      },
                      child: const Text(
                        'Reset',
                        textScaleFactor: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(result),
          ],
        ),
      ),
    );
  }

  void _onDropdownChanged(String value) {
    setState(() {
      this._currency = value;
    });
  }

  String _calculate() {
    double _distance = double.parse(distanceController.text);
    double _fuelCost = double.parse(priceController.text);
    double _consumption = double.parse(avgController.text);
    double _totalCost = _distance / _consumption * _fuelCost;
    String _result =
        "The total cost of your trip is ${_totalCost.toStringAsFixed(2)} $_currency";
    return _result;
  }

  void _reset() {
    distanceController.text = '';
    avgController.text = '';
    priceController.text = '';
    setState(() {
      result = '';
    });
  }
}
