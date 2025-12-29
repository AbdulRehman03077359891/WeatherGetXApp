import 'package:flutter/material.dart';

class CityChoose extends StatelessWidget {
  final String? selectedCity;
  final void Function(String?)? onChange;
  final double? width;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final String? hintText;
  final Widget? prefixIcon;
  final Color? fillColor;
  final Color focusBorderColor;
  final bool? hidePassword;
  final Widget? suffixIcon;
  final Color errorBorderColor;
  final Color? suffixIconColor;
  final TextInputType? keyboardType;
  final Color? labelText;
  final Color? labelColor;
  final void Function(double, double) onCoordinatesChanged;

  const CityChoose({
    super.key,
    required this.selectedCity,
    required this.onChange,
    this.width,
    this.controller,
    this.validate,
    this.hintText,
    this.prefixIcon,
    this.fillColor,
    required this.focusBorderColor,
    this.hidePassword = false,
    this.suffixIcon,
    required this.errorBorderColor,
    this.suffixIconColor,
    this.keyboardType,
    this.labelText,
    this.labelColor,
    required this.onCoordinatesChanged,
  });

 static const Map<String, List<double>> cityCoordinates = {
  'Abbottabad': [34.1498, 73.2174],
    'Ahmedpur East': [29.1795, 71.2766],
'Bahawalpur': [29.3569, 71.6756],
  'Bannu': [32.9843, 70.5937],
  'Dera Ghazi Khan': [30.0595, 70.6342],
  'Sharqpur Sharif': [31.4504, 74.2046],
  'Gujranwala': [32.1613, 74.1882],
  'Jalalpur Jattan': [32.6795, 74.1973],
  'Hyderabad': [25.3960, 68.3578],
  'Islamabad': [33.6844, 73.0479],
  'Karachi': [24.8607, 67.0011],
  'Khanewal': [30.3003, 71.9670],
  'Lahore': [31.5497, 74.3436],
  'Larkana': [27.5589, 68.2120],
  'Dhunel Ganj': [34.1991, 72.0428],
  'Murree': [33.9048, 73.3926],
  'Nawabshah': [26.2483, 68.4096],
  'Kot Malik Barkhurdar': [30.1798, 66.9750],
  'Arya': [33.5651, 73.0169],
  'Sargodha': [32.0836, 72.6748],
  'Sialkot': [32.5132, 74.5374],
  'Sneuron': [35.3333, 75.5480],
  'Thal': [35.2225, 72.2916],
  'Jam Shoro': [25.4572, 68.2088],
  'Kotri': [25.3525, 68.1900],
  'Gush Tang': [25.9730, 63.0312],
  'Vihari': [30.0444, 72.3624],
  'Amanzi': [30.3476, 66.2537],
};

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          labelStyle: TextStyle(color: labelColor),
          hintText: hintText,
          filled: true,
          fillColor: fillColor,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            borderSide: BorderSide(
              width: 2.0,
              style: BorderStyle.solid,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            borderSide: BorderSide(
              color: focusBorderColor,
              width: 2.0,
              style: BorderStyle.solid,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            borderSide: BorderSide(
              color: errorBorderColor,
              width: 2.0,
              style: BorderStyle.solid,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          labelText: 'City',
        ),
        value: selectedCity,
        items: cityCoordinates.keys
            .map((city) => DropdownMenuItem(
                  value: city,
                  child: Text(city),
                ))
            .toList(),
        onChanged: (value) {
          onChange?.call(value);
          if (value != null) {
            final coordinates = cityCoordinates[value]!;
            onCoordinatesChanged(coordinates[0], coordinates[1]);
          }
        },
        validator: (value) => value == null ? 'Please select a city' : null,
      ),
    );
  }
}
