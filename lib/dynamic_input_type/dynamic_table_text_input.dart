part of 'dynamic_table_input_type.dart';

class DynamicTableTextInput extends DynamicTableInputType<String> {
  DynamicTableTextInput({
    InputDecoration? decoration,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
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
    // this.validator,
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
  })  : _mouseCursor = mouseCursor,
        _autovalidateMode = autovalidateMode,
        _autofillHints = autofillHints,
        _scrollPhysics = scrollPhysics,
        _scrollPadding = scrollPadding,
        _keyboardAppearance = keyboardAppearance,
        _cursorColor = cursorColor,
        _cursorHeight = cursorHeight,
        _cursorRadius = cursorRadius,
        _cursorWidth = cursorWidth,
        _enabled = enabled,
        _inputFormatters = inputFormatters,
        _maxLength = maxLength,
        _expands = expands,
        _minLines = minLines,
        _maxLines = maxLines,
        _maxLengthEnforcement = maxLengthEnforcement,
        _enableSuggestions = enableSuggestions,
        _smartQuotesType = smartQuotesType,
        _smartDashesType = smartDashesType,
        _autocorrect = autocorrect,
        _obscureText = obscureText,
        _obscuringCharacter = obscuringCharacter,
        _showCursor = showCursor,
        _readOnly = readOnly,
        _textAlignVertical = textAlignVertical,
        _textAlign = textAlign,
        _textDirection = textDirection,
        _strutStyle = strutStyle,
        _style = style,
        _textInputAction = textInputAction,
        _textCapitalization = textCapitalization,
        _decoration = decoration,
        _keyboardType = keyboardType,
        super(
        // dynamicTableInput: DynamicTableInput.text,
        );

  final InputDecoration? _decoration;
  final TextInputType? _keyboardType;
  final TextCapitalization _textCapitalization;
  final TextInputAction? _textInputAction;
  final TextStyle? _style;
  final StrutStyle? _strutStyle;
  final TextDirection? _textDirection;
  final TextAlign _textAlign;
  final TextAlignVertical? _textAlignVertical;
  final bool _readOnly;
  final bool? _showCursor;
  final String _obscuringCharacter;
  final bool _obscureText;
  final bool _autocorrect;
  final SmartDashesType? _smartDashesType;
  final SmartQuotesType? _smartQuotesType;
  final bool _enableSuggestions;
  final MaxLengthEnforcement? _maxLengthEnforcement;
  final int _maxLines;
  final int? _minLines;
  final bool _expands;
  final int? _maxLength;
  // final void Function()? onTap;
  // final void Function(PointerDownEvent)? onTapOutside;
  // final String? Function(String?)? validator;
  final List<TextInputFormatter>? _inputFormatters;
  final bool? _enabled;
  final double _cursorWidth;
  final double? _cursorHeight;
  final Radius? _cursorRadius;
  final Color? _cursorColor;
  final Brightness? _keyboardAppearance;
  final EdgeInsets _scrollPadding;
  final ScrollPhysics? _scrollPhysics;
  final Iterable<String>? _autofillHints;
  final AutovalidateMode? _autovalidateMode;
  final MouseCursor? _mouseCursor;

  @override
  Widget displayWidget(String? value, bool focused, TouchEditCallBacks touchEditCallBacks) {
    return DefaultDisplayWidget<String>(value: value, focused: focused, touchEditCallBacks: touchEditCallBacks);
  }

  @override
  Widget editingWidget(String? value,
      Function(String? value)? onChanged,
      TouchEditCallBacks touchEditCallBacks,
      bool focused) {
    return DynamicTableTextInputWidget(keyboardType: _keyboardType, maxLines: _maxLines, decoration: _decoration, textCapitalization: _textCapitalization, textInputAction: _textInputAction, style: _style, strutStyle: _strutStyle, textDirection: _textDirection, textAlign: _textAlign, textAlignVertical: _textAlignVertical, readOnly: _readOnly, showCursor: _showCursor, obscuringCharacter: _obscuringCharacter, obscureText: _obscureText, autocorrect: _autocorrect, smartDashesType: _smartDashesType, smartQuotesType: _smartQuotesType, enableSuggestions: _enableSuggestions, maxLengthEnforcement: _maxLengthEnforcement, minLines: _minLines, expands: _expands, maxLength: _maxLength, inputFormatters: _inputFormatters, enabled: _enabled, cursorWidth: _cursorWidth, cursorHeight: _cursorHeight, cursorRadius: _cursorRadius, cursorColor: _cursorColor, keyboardAppearance: _keyboardAppearance, scrollPadding: _scrollPadding, scrollPhysics: _scrollPhysics, autofillHints: _autofillHints, autovalidateMode: _autovalidateMode, mouseCursor: _mouseCursor, value: value, onChanged: onChanged, touchEditCallBacks: touchEditCallBacks, focused: focused);
  }

  @override
  void dispose() {
  }
}
