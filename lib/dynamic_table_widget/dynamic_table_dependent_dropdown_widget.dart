import 'package:dynamic_table/dynamic_table_source/dynamic_table_view.dart';
import 'package:dynamic_table/dynamic_table_widget/focusing_extension.dart';
import 'package:dynamic_table/dynamic_table_widget/key_event_handlers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DynamicTableDependentDropdownWidget<T, W> extends StatefulWidget {
  const DynamicTableDependentDropdownWidget({
    super.key,
    required this.dependentValue,
    required List<DropdownMenuItem<T>> Function(W dependentValue) itemsBuilder,
    required List<Widget> Function(BuildContext p1)? selectedItemBuilder,
    required Widget? hint,
    required Widget? disabledHint,
    required int elevation,
    required TextStyle? style,
    required Widget? icon,
    required Color? iconDisabledColor,
    required Color? iconEnabledColor,
    required double iconSize,
    required bool isDense,
    required bool isExpanded,
    required double? itemHeight,
    required Color? focusColor,
    required Color? dropdownColor,
    required InputDecoration? decoration,
    required double? menuMaxHeight,
    required bool? enableFeedback,
    required AlignmentGeometry alignment,
    required BorderRadius? borderRadius,
    required this.value,
    required this.onChanged,
    required this.touchEditCallBacks,
    required this.focused,
  }) : _itemsBuilder = itemsBuilder, _selectedItemBuilder = selectedItemBuilder, _hint = hint, _disabledHint = disabledHint, _elevation = elevation, _style = style, _icon = icon, _iconDisabledColor = iconDisabledColor, _iconEnabledColor = iconEnabledColor, _iconSize = iconSize, _isDense = isDense, _isExpanded = isExpanded, _itemHeight = itemHeight, _focusColor = focusColor, _dropdownColor = dropdownColor, _decoration = decoration, _menuMaxHeight = menuMaxHeight, _enableFeedback = enableFeedback, _alignment = alignment, _borderRadius = borderRadius;

  final List<Widget> Function(BuildContext p1)? _selectedItemBuilder;
  final Widget? _hint;
  final Widget? _disabledHint;
  final int _elevation;
  final TextStyle? _style;
  final Widget? _icon;
  final Color? _iconDisabledColor;
  final Color? _iconEnabledColor;
  final double _iconSize;
  final bool _isDense;
  final bool _isExpanded;
  final double? _itemHeight;
  final Color? _focusColor;
  final Color? _dropdownColor;
  final InputDecoration? _decoration;
  final double? _menuMaxHeight;
  final bool? _enableFeedback;
  final AlignmentGeometry _alignment;
  final BorderRadius? _borderRadius;

  final W? dependentValue;
  final List<DropdownMenuItem<T>> Function(W dependentValue) _itemsBuilder;
  final T? value;
  final Function(T value, )? onChanged;
  final TouchEditCallBacks touchEditCallBacks;
  final bool focused;

  @override
  State<DynamicTableDependentDropdownWidget<T, W>> createState() => _DynamicTableDependentDropdownWidgetState<T, W>();
}

class _DynamicTableDependentDropdownWidgetState<T, W> extends State<DynamicTableDependentDropdownWidget<T, W>> {

  FocusNode? _focusNode;

  void _init() {
    widget.touchEditCallBacks.updateFocusCache?.call(
        identity: this,
        UpdateFocusNodeCallBacks(
            unfocusFocusNodes: () => setState(() {
                  _focusNode?.unfocus();
                }),
            focusFocusNodes: () => setState(() {
                  _focusNode?.requestFocus();
                })));

    _focusNode?.onKeyEvent = (node, event) => event.handleKeysIfCallBackExistAndCallOnlyOnKeyDown(debugLabel: "Dependent Dropdown")
    .chain([LogicalKeyboardKey.tab], widget.touchEditCallBacks.focusPreviousField, withShift: true)
    .chain([LogicalKeyboardKey.tab], widget.touchEditCallBacks.focusNextField)
    .chain([LogicalKeyboardKey.escape], widget.touchEditCallBacks.cancelEdit).result();

    _focusNode?.focus(widget.focused);
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _init();
  }

  @override
  void didUpdateWidget(DynamicTableDependentDropdownWidget<T, W> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode?.unfocus();
    _focusNode?.dispose();
    _focusNode = null;
    widget.touchEditCallBacks.clearFocusCache?.call(identity: this);
  }

  @override
  Widget build(BuildContext context) {
    
    List<DropdownMenuItem<T>> _items = [];
    _items =
        widget.dependentValue == null ? [] : widget._itemsBuilder(widget.dependentValue!).toList();
    // ?? _items.first.value;

    assert(
      _items.isEmpty ||
          widget.value == null ||
          _items.where((DropdownMenuItem<T> item) {
                return item.value == widget.value;
              }).length ==
              1,
      "There should be exactly one item with [DropdownButton]'s value: "
      '${widget.value}. \n'
      'Either zero or 2 or more [DropdownMenuItem]s were detected '
      'with the same value',
    );

    return DropdownButtonFormField<T>(
      value: widget.value,
      onChanged: (value) {
        widget.onChanged?.call(value as T, );
        widget.touchEditCallBacks.focusNextField?.call();
      },
      items: _items,
      selectedItemBuilder: widget._selectedItemBuilder,
      hint: widget._hint,
      disabledHint: widget._disabledHint,
      elevation: widget._elevation,
      style: widget._style,
      icon: widget._icon,
      iconDisabledColor: widget._iconDisabledColor,
      iconEnabledColor: widget._iconEnabledColor,
      iconSize: widget._iconSize,
      isDense: widget._isDense,
      isExpanded: widget._isExpanded,
      itemHeight: widget._itemHeight,
      focusColor: widget._focusColor,
      focusNode: _focusNode,
      dropdownColor: widget._dropdownColor,
      decoration: widget._decoration,
      menuMaxHeight: widget._menuMaxHeight,
      enableFeedback: widget._enableFeedback,
      alignment: widget._alignment,
      borderRadius: widget._borderRadius,
    );
  }
}
