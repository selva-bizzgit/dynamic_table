import 'package:dynamic_table/dynamic_table.dart';
import 'package:dynamic_table/dynamic_table_source/dynamic_table_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dynamic_table/dynamic_table_widget/default_display_widget.dart';
import 'package:dynamic_table/dynamic_table_widget/dynamic_table_autocomplete_widget.dart';
import 'package:dynamic_table/dynamic_table_widget/dynamic_table_date_input_widget.dart';
import 'package:dynamic_table/dynamic_table_widget/dynamic_table_dependent_dropdown_widget.dart';
import 'package:dynamic_table/dynamic_table_widget/dynamic_table_dropdown_widget.dart';
import 'package:dynamic_table/dynamic_table_widget/dynamic_table_text_input_widget.dart';
import 'package:intl/intl.dart' show DateFormat;

part 'dynamic_table_date_input.dart';
part 'dynamic_table_text_input.dart';
part 'dynamic_table_dropdown_input.dart';
part 'dynamic_table_actions_input.dart';
part 'dynamic_table_autocomplete_input.dart';
part 'dynamic_table_dependent_dropdown.dart';

abstract class DynamicTableInputType<T extends Object> {
  DynamicTableInputType({int? dependentOn}) : _dependentOn = dependentOn;

  /// The value to display when the value is null (currently not usign this).
  static final String emptyValue = "N/A";

  int? _dependentOn;
  int? get dependentOn => _dependentOn;

  Type typeOf() => T;

  Widget getChild(T? value,
      {required bool isEditing,
      Function(T? value)? onChanged,
      TouchEditCallBacks touchEditCallBacks = const TouchEditCallBacks(),
      bool focused = false}) {
    if (isEditing) {
      return editingWidget(value, onChanged, touchEditCallBacks, focused);
    } else {
      return displayWidget(value, focused, touchEditCallBacks);
    }
  }

  /// This is the widget which will be displayed when the [DynamicTableDataRow.isEditing] is true.
  Widget editingWidget(T? value,
      Function(T? value)? onChanged,
      TouchEditCallBacks touchEditCallBacks,
      // ignore: avoid_positional_boolean_parameters
      bool focused);

  /// This is the widget which will be displayed when the [DynamicTableDataRow.isEditing] is false.
  // ignore: avoid_positional_boolean_parameters
  Widget displayWidget(T? value, bool focused, TouchEditCallBacks touchEditCallBacks);

  void dispose();

  /// Text Input for the [DynamicTable].
  ///
  /// [decoration],[keyboardType],[textCapitalization],[textInputAction],[style],[strutStyle],[textDirection],[textAlign],[textAlignVertical],[autofocus],[readOnly],[showCursor],[obscuringCharacter],[obscureText],[autocorrect],[smartDashesType],[smartQuotesType],[enableSuggestions],[maxLengthEnforcement],[maxLines],[minLines],[expands],[maxLength],[validator],[inputFormatters],[enabled],[cursorWidth],[cursorHeight],[cursorRadius],[cursorColor],[keyboardAppearance],[scrollPadding],[scrollPhysics],[autofillHints],[autovalidateMode],[mouseCursor]
  /// all this properties will be aplied to the [TextFormField] widget which will be shown while editing.
  ///
  /// [validator] is not used currently.
  static DynamicTableTextInput text({
    InputDecoration? decoration,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    bool? showCursor,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    MaxLengthEnforcement? maxLengthEnforcement,
    int maxLines = 1,
    int? minLines,
    bool expands = false,
    int? maxLength,
    // String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    ScrollPhysics? scrollPhysics,
    Iterable<String>? autofillHints,
    AutovalidateMode? autovalidateMode,
    MouseCursor? mouseCursor,
  }) {
    return DynamicTableTextInput(
      decoration: decoration,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      style: style,
      strutStyle: strutStyle,
      textDirection: textDirection,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      readOnly: readOnly,
      showCursor: showCursor,
      obscuringCharacter: obscuringCharacter,
      obscureText: obscureText,
      autocorrect: autocorrect,
      smartDashesType: smartDashesType,
      smartQuotesType: smartQuotesType,
      enableSuggestions: enableSuggestions,
      maxLengthEnforcement: maxLengthEnforcement,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      maxLength: maxLength,
      // validator: validator,
      inputFormatters: inputFormatters,
      enabled: enabled,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorColor: cursorColor,
      keyboardAppearance: keyboardAppearance,
      scrollPadding: scrollPadding,
      scrollPhysics: scrollPhysics,
      autofillHints: autofillHints,
      autovalidateMode: autovalidateMode,
      mouseCursor: mouseCursor,
    );
  }

  /// Date Input for the [DynamicTable].
  ///
  /// [decoration],[style],[strutStyle],[textDirection],[textAlign],[textAlignVertical],[autofocus],[inputFormatters],[enabled],[mouseCursor]
  /// all this properties will be aplied to the [TextFormField] widget which will be shown while editing.
  ///
  /// [formatDate] is a function which will be used to format the date to string.
  /// Default format is DD-MM-YY.
  /// [initialDate] is the initial date which will be shown in the date picker.
  /// [lastDate] is the last date which will be shown in the date picker.
  ///
  static DynamicTableDateInput date({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime lastDate,
    DateFormat? dateFormat,
    InputDecoration? decoration = const InputDecoration(
      border: OutlineInputBorder(),
      suffixIcon: Icon(Icons.calendar_today),
      labelText: "Enter a value",
    ),
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    bool autofocus = false,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    MouseCursor? mouseCursor,
    bool readOnly = true
  }) {
    return DynamicTableDateInput(
      initialDate: initialDate,
      lastDate: lastDate,
      dateFormat: dateFormat,
      decoration: decoration,
      style: style,
      strutStyle: strutStyle,
      textDirection: textDirection,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      mouseCursor: mouseCursor,
      readOnly: readOnly
    );
  }

  /// Actions Input for the [DynamicTable].
  ///
  /// [selectedItemBuilder],[hint],[disabledHint],[elevation],[style],[icon],[iconDisabledColor],[iconEnabledColor],[iconSize],[isDense],[isExpanded],[itemHeight],[focusColor],[focusNode],[autofocus],[dropdownColor],[decoration],[menuMaxHeight],[enableFeedback],[alignment],[borderRadius]
  /// all this properties will be aplied to the [DropdownButton] widget which will be shown while editing.
  ///
  /// `items` is the list of items which will be shown in the dropdown.
  ///
  /// `displayBuilder` is a function which will be used to format the selected value to string.
  ///
  static DynamicTableDropDownInput<T> dropDown<T extends Object>({
    required List<DropdownMenuItem<T>> items,
    required String Function(T?) displayBuilder,
    List<Widget> Function(BuildContext context)? selectedItemBuilder,
    Widget? hint,
    Widget? disabledHint,
    int elevation = 8,
    TextStyle? style,
    Widget? icon,
    Color? iconDisabledColor,
    Color? iconEnabledColor,
    double iconSize = 24.0,
    bool isDense = true,
    bool isExpanded = false,
    double? itemHeight,
    Color? focusColor,
    bool autofocus = false,
    Color? dropdownColor,
    InputDecoration? decoration,
    double? menuMaxHeight,
    bool? enableFeedback,
    AlignmentGeometry alignment = AlignmentDirectional.centerStart,
    BorderRadius? borderRadius,
  }) {
    return DynamicTableDropDownInput<T>(
      items: items,
      displayBuilder: displayBuilder,
      selectedItemBuilder: selectedItemBuilder,
      hint: hint,
      disabledHint: disabledHint,
      elevation: elevation,
      style: style,
      icon: icon,
      iconDisabledColor: iconDisabledColor,
      iconEnabledColor: iconEnabledColor,
      iconSize: iconSize,
      isDense: isDense,
      isExpanded: isExpanded,
      itemHeight: itemHeight,
      focusColor: focusColor,
      dropdownColor: dropdownColor,
      decoration: decoration,
      menuMaxHeight: menuMaxHeight,
      enableFeedback: enableFeedback,
      alignment: alignment,
      borderRadius: borderRadius,
    );
  }

  /// Autocomplete Input for the [DynamicTable].
  ///
  /// [optionsBuilder],[displayStringForOption],[fieldViewBuilder],[displayBuilder],[onSelected],[optionsMaxHeight],[optionsViewBuilder]
  ///
  /// [optionsBuilder] is a function which will be used to build the options for the autocomplete.
  ///
  /// [displayStringForOption] is a function which will be used to format the selected value to string.
  ///
  /// [fieldViewBuilder] is a function which will be used to build the field view for the autocomplete.
  ///
  /// [displayBuilder] is a function which will be used to format the selected value to string.
  ///

  static DynamicTableAutocompleteInput autocompleteInput({
    required AutocompleteOptionsBuilder<String> optionsBuilder,
    AutocompleteOptionToString<String> displayStringForOption =
        RawAutocomplete.defaultStringForOption,
    AutocompleteFieldViewBuilder? fieldViewBuilder,
    String Function(String? value)? displayBuilder,
    AutocompleteOnSelected<String>? onSelected,
    double optionsMaxHeight = 200.0,
    AutocompleteOptionsViewBuilder<String>? optionsViewBuilder,
  }) {
    return DynamicTableAutocompleteInput(
      optionsBuilder: optionsBuilder,
      displayStringForOption: displayStringForOption,
      fieldViewBuilder: fieldViewBuilder,
      displayBuilder: displayBuilder,
      onSelected: onSelected,
      optionsMaxHeight: optionsMaxHeight,
      optionsViewBuilder: optionsViewBuilder,
    );
  }
}
