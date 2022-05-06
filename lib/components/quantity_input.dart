import 'package:flutter/material.dart';

class QuantityInput extends StatelessWidget {
  const QuantityInput({
    Key? key,
    this.placeHolder,
    this.onTap,
    this.errorText,
    required this.onChanged,
    this.helperText,
  }) : super(key: key);
  final String? placeHolder;
  final VoidCallback? onTap;
  final String? helperText;
  final String? errorText;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: TextFormField(
        onTap: onTap,
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: placeHolder ?? "Nom du produit",
          labelStyle: const TextStyle(
            color: Colors.white,
          ),
          helperText: helperText,
          helperMaxLines: 2,
          errorText: errorText,
          errorMaxLines: 3,
        ),
      ),
    );
  }
}
