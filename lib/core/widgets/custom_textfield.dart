import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hero/core/utils/getsize.dart';

import '../utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.prefixWidget,
    this.suffixIcon,
    required this.title,
    required this.textInputType,
    this.minLine = 1,
    this.isPassword = false,
    this.validatorMessage = '',
    this.controller,
    this.horizontalPadding = 20,
    this.imageColor = Colors.grey,
    required this.backgroundColor,
    this.maxLengthOfCharacter,
    this.isAdd = false,
    this.isEnable = true,
    this.fontSize,
    this.onchange,
  }) : super(key: key);
  final Widget? prefixWidget;
  final Widget? suffixIcon;
  final Color imageColor;
  final Color backgroundColor;
  final String title;
  final String validatorMessage;
  final int minLine;
  final bool isPassword;
  final bool? isEnable;
  final Function(String)? onchange;
  final TextInputType textInputType;
  final TextEditingController? controller;
  final double horizontalPadding;
  final bool isAdd;
  final double? fontSize;
  final int? maxLengthOfCharacter;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: getSize(context) / 7,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: horizontalPadding),
      child: TextFormField(
        inputFormatters: [
          new LengthLimitingTextInputFormatter(maxLengthOfCharacter),

          /// here char limit is 5
        ],
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        keyboardType: textInputType,
        obscureText: isPassword,
        enabled: isEnable,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
          fontFamily: 'Cairo',
        ),
        autofocus: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(1),
          hintStyle: TextStyle(
            color: AppColors.gray6,
            fontWeight: FontWeight.w400,
          ),
          hintText: title,
          isDense: true,
          border: textInputType != TextInputType.phone
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(getSize(context) / 44),
                  borderSide: BorderSide(
                      color: isAdd ? AppColors.white : AppColors.white),
                )
              : InputBorder.none,
          enabledBorder: textInputType != TextInputType.phone
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(getSize(context) / 44),
                  borderSide: BorderSide(
                      color: isAdd ? AppColors.white : AppColors.white),
                )
              : InputBorder.none,
          focusedBorder: textInputType != TextInputType.phone
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(getSize(context) / 44),
                  borderSide: BorderSide(
                      color: isAdd ? AppColors.white : AppColors.white),
                )
              : InputBorder.none,
          prefixIcon:
              textInputType != TextInputType.phone ? prefixWidget : null,
          suffixIcon: suffixIcon,
          suffixIconColor: AppColors.buttonColor,
          prefixIconColor: AppColors.buttonColor,
          fillColor: backgroundColor,
          filled: true,
        ),
        onChanged: onchange,
        maxLines: 1,
        minLines: minLine,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validatorMessage;
          }
          return null;
        },
      ),
    );
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ','; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Handle "deletion" of separator character
    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 4 == 0 && i != chars.length - 1) {
          newString = separator + newString;
        }
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue previousValue,
    TextEditingValue nextValue,
  ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}
