import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:dynamic_table/dynamic_table_data/dynamic_table_data_column.dart';
import 'package:dynamic_table/dynamic_table_source/dynamic_table_source.dart';

class DynamicTable extends StatefulWidget {
  /// Creates a widget describing a paginated [DataTable] on a [Card].
  ///
  /// The [header] should give the card's header, typically a [Text] widget.
  ///
  /// The [columns] argument must be a list of as many [DataColumn] objects as
  /// the table is to have columns, ignoring the leading checkbox column if any.
  /// The [columns] argument must have a length greater than zero and cannot be
  /// null.
  ///
  /// If the table is sorted, the column that provides the current primary key
  /// should be specified by index in [sortColumnIndex], 0 meaning the first
  /// column in [columns], 1 being the next one, and so forth.
  ///
  /// The actual sort order can be specified using [sortAscending]; if the sort
  /// order is ascending, this should be true (the default), otherwise it should
  /// be false.
  ///
  /// The [source] must not be null. The [source] should be a long-lived
  /// [DataTableSource]. The same source should be provided each time a
  /// particular [PaginatedDataTable] widget is created; avoid creating a new
  /// [DataTableSource] with each new instance of the [PaginatedDataTable]
  /// widget unless the data table really is to now show entirely different
  /// data from a new source.
  ///
  /// The [rowsPerPage] and [availableRowsPerPage] must not be null (they
  /// both have defaults, though, so don't have to be specified).
  ///
  /// Themed by [DataTableTheme]. [DataTableThemeData.decoration] is ignored.
  /// To modify the border or background color of the [PaginatedDataTable], use
  /// [CardTheme], since a [Card] wraps the inner [DataTable].
  ///
  ///

  //TODO: validate widget configuration

  DynamicTable(
      {super.key,
      this.header,
      this.dataRowMinHeight = kMinInteractiveDimension,
      this.dataRowMaxHeight = kMinInteractiveDimension,
      this.headingRowHeight = 56.0,
      this.horizontalMargin = 24.0,
      this.columnSpacing = 56.0,
      this.showFirstLastButtons = false,
      this.initialFirstRowIndex = 0,
      this.onPageChanged,
      this.rowsPerPage = defaultRowsPerPage,
      this.availableRowsPerPage = const <int>[
        defaultRowsPerPage,
        defaultRowsPerPage * 2,
        defaultRowsPerPage * 5,
        defaultRowsPerPage * 10
      ],
      this.onRowsPerPageChanged,
      this.dragStartBehavior = DragStartBehavior.start,
      this.arrowHeadColor,
      this.checkboxHorizontalMargin,
      this.controller,
      this.primary,
      this.actionColumnTitle = "Actions",
      this.selectAllToolTip,
      this.unselectAllToolTip,
      this.showSelectAllButton = false,
      this.filterSelectionByIndex,
      this.onSelectAll,
      bool showCheckboxColumn = false,
      bool selectable = true,
      this.actions,
      required this.columns,
      required this.rows,
      this.onRowEdit,
      this.onRowDelete,
      this.onRowSave,
      this.showActions = false,
      this.showDeleteAction = false,
      this.showDeleteOrCancelAction = false,
      this.touchMode = false,
      this.showAddRowButton = false,
      this.addRowAtTheEnd = false,
      this.editOneByOne = false,
      this.autoSaveRows = false})
      : assert(() {
          if ((onRowEdit == null && onRowSave != null) ||
              (onRowEdit != null && onRowSave == null)) {
            return false;
          } else {
            return true;
          }
        }(), "onRowEdit and onRowSave must be both null or both non-null"),
        assert(() {
          if (showAddRowButton == true &&
              (showActions == false && touchMode == false)) {
            return false;
          } else {
            return true;
          }
        }(),
            "showActions or touchMode shall be true if showAddRowButton is true, because the actions column or touchMode is required to save the new row"),
        assert(() {
          if (!editOneByOne && autoSaveRows) {
            return false;
          }
          return true;
        }(), 'autoSaveRows cannot be true if editOneByOne is false'),
        this.selectable = selectable,
        this.showCheckboxColumn = selectable && showCheckboxColumn {
    if (columns.where((column) => column.isKeyColumn).length != 1) {
      throw Exception("One Column must be Key Column.");
    }
  }

  /// The table card's optional header.
  ///
  /// This is typically a [Text] widget, but can also be a [Row] of
  /// [TextButton]s. To show icon buttons at the top end side of the table with
  /// a header, set the [actions] property.
  ///
  /// If items in the table are selectable, then, when the selection is not
  /// empty, the header is replaced by a count of the selected items. The
  /// [actions] are still visible when items are selected.

  final Widget? header;

  /// The minimum height of each row (excluding the row that contains column headings).
  ///
  /// This value is optional and defaults to [kMinInteractiveDimension] if not
  /// specified.
  final double dataRowMinHeight;

  /// The maximum height of each row (excluding the row that contains column headings).
  ///
  /// This value is optional and defaults to kMinInteractiveDimension if not
  /// specified.
  final double dataRowMaxHeight;

  /// The height of the heading row.
  ///
  /// This value is optional and defaults to 56.0 if not specified.
  final double headingRowHeight;

  /// The horizontal margin between the edges of the table and the content
  /// in the first and last cells of each row.
  ///
  /// When a checkbox is displayed, it is also the margin between the checkbox
  /// the content in the first data column.
  ///
  /// This value defaults to 24.0 to adhere to the Material Design specifications.
  ///
  /// If [checkboxHorizontalMargin] is null, then [horizontalMargin] is also the
  /// margin between the edge of the table and the checkbox, as well as the
  /// margin between the checkbox and the content in the first data column.
  final double horizontalMargin;

  /// The horizontal margin between the contents of each data column.
  ///
  /// This value defaults to 56.0 to adhere to the Material Design specifications.
  final double columnSpacing;

  /// Flag to display the pagination buttons to go to the first and last pages.
  final bool showFirstLastButtons;

  /// The index of the first row to display when the widget is first created.
  final int? initialFirstRowIndex;

  /// Invoked when the user switches to another page.
  ///
  /// The value is the index of the first row on the currently displayed page.
  final ValueChanged<int>? onPageChanged;

  /// The number of rows to show on each page.
  ///
  /// See also:
  ///
  ///  * [onRowsPerPageChanged]
  ///  * [defaultRowsPerPage]
  final int rowsPerPage;

  /// The default value for [rowsPerPage].
  ///
  /// Useful when initializing the field that will hold the current
  /// [rowsPerPage], when implemented [onRowsPerPageChanged].
  static const int defaultRowsPerPage = 10;

  /// The options to offer for the rowsPerPage.
  ///
  /// The current [rowsPerPage] must be a value in this list.
  ///
  /// The values in this list should be sorted in ascending order.
  final List<int> availableRowsPerPage;

  /// Invoked when the user selects a different number of rows per page.
  ///
  /// If this is null, then the value given by [rowsPerPage] will be used
  /// and no affordance will be provided to change the value.
  final ValueChanged<int?>? onRowsPerPageChanged;

  /// The data source which provides data to show in each row. Must be non-null.
  ///
  /// This object should generally have a lifetime longer than the
  /// [PaginatedDataTable] widget itself; it should be reused each time the
  /// [PaginatedDataTable] constructor is called.
  // late final DataTableSource source;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// Horizontal margin around the checkbox, if it is displayed.
  ///
  /// If null, then [horizontalMargin] is used as the margin between the edge
  /// of the table and the checkbox, as well as the margin between the checkbox
  /// and the content in the first data column. This value defaults to 24.0.
  final double? checkboxHorizontalMargin;

  /// Defines the color of the arrow heads in the footer.
  final Color? arrowHeadColor;

  /// {@macro flutter.widgets.scroll_view.controller}
  final ScrollController? controller;

  /// {@macro flutter.widgets.scroll_view.primary}
  final bool? primary;

  /// The title of the last column of the table.
  /// This is used to display the actions.
  /// Defaults to "Actions"
  final String actionColumnTitle;

  final bool showSelectAllButton;

  final bool Function(int)? filterSelectionByIndex;

  final String? selectAllToolTip;

  final String? unselectAllToolTip;

  /// Invoked when the user selects or unselects every row, using the
  /// checkbox in the heading row.
  ///
  /// See [DataTable.onSelectAll].
  final ValueSetter<bool?>? onSelectAll;

  /// {@macro flutter.material.dataTable.showCheckboxColumn}
  /// Only when selectable is true show checkbox column can be true
  final bool showCheckboxColumn;

  /// Whether the table should be selectable
  final bool selectable;

  /// Called when the user clicks on the edit icon of a row.
  ///
  /// Return true to allow the edit action, false to prevent it.
  /// If the action is allowed, the row will be editable.
  ///
  /// ```dart
  /// bool onRowEdit(int index, List<Comparable<dynamic>> row){
  /// //Do some validation on row and return false if validation fails
  /// if (index%2==1) {
  ///   ScaffoldMessenger.of(context).showSnackBar(
  ///    const SnackBar(
  ///     content: Text("Cannot edit odd rows"),
  ///   ),
  /// );
  /// return false; // The row will not open in editable mode
  /// }
  /// return true; // The row will open in editable mode
  /// }
  /// ```
  final bool Function(Comparable<dynamic>? key, List<Comparable<dynamic>?> row)?
      onRowEdit;

  /// Called when the user clicks on the delete icon of a row.
  ///
  /// Return true to allow the delete action, false to prevent it.
  ///
  /// If the delete action is allowed, the row will be deleted from the table.
  ///
  /// ```dart
  /// bool onRowDelete(int index, List<Comparable<dynamic>> row){
  /// //Do some validation on row and return false if validation fails
  /// if (row[0] == null) {
  ///    ScaffoldMessenger.of(context).showSnackBar(
  ///     const SnackBar(
  ///      content: Text("Name cannot be null"),
  ///     ),
  ///   );
  ///  return false;
  /// }
  /// return true;
  /// }
  /// ```
  final bool Function(Comparable<dynamic>? key, List<Comparable<dynamic>?> row)?
      onRowDelete;

  /// Called when the user clicks on the save icon of a row.
  ///
  /// Return List<Comparable<dynamic>> [newValue] to allow the save action, null to prevent it.
  ///
  /// The [newValue] must be a list of the same length as the column.
  ///
  /// If the save action is allowed, the row will be saved to the table.
  ///
  /// The [oldValue] is the value of the row before the edit.
  /// The [newValue] is the value of the row after the edit.
  ///
  /// ```dart
  ///
  /// List<Comparable<dynamic>>? onRowSave(int index, List<Comparable<dynamic>> oldValue, List<Comparable<dynamic>> newValue) {
  /// //Do some validation on new value and return null if validation fails
  /// if (newValue[0] == null) {
  ///     ScaffoldMessenger.of(context).showSnackBar(
  ///       const SnackBar(
  ///         content: Text("Name cannot be null"),
  ///          ),
  ///     );
  ///   return null;
  ///}
  /// // Do some modification to `newValue` and return `newValue`
  /// newValue[0] = newValue[0].toString().toUpperCase(); // Convert name to uppercase
  /// // Save new data to you list
  /// myData[index] = newValue;
  /// return newValue;
  /// }
  /// ```
  ///
  final List<Comparable<dynamic>?>? Function(
      Comparable<dynamic>? key,
      List<Comparable<dynamic>?> oldValue,
      List<Comparable<dynamic>?> newValue)? onRowSave;

  /// Icon buttons to show at the top end side of the table. The [header] must
  /// not be null to show the actions.
  ///
  /// Typically, the exact actions included in this list will vary based on
  /// whether any rows are selected or not.
  ///
  /// These should be size 24.0 with default padding (8.0).
  final List<Widget>? actions;

  /// The configuration and labels for the columns in the table.
  final List<DynamicTableDataColumn> columns;

  /// The data for the rows of the table.
  final Map<Comparable<dynamic>, List<Comparable<dynamic>?>> rows;

  /// Whether to show the actions column.
  /// Defaults to true.
  /// If set to true and [showDeleteAction] is set to false, the actions column will be displayed but the delete action will not be displayed.
  /// If set to true and [showDeleteAction] is set to true, the actions column will be displayed and the delete action will be displayed.
  final bool showActions;

  /// Whether to show the delete action.
  /// Defaults to true.
  /// If set to true and [showActions] is set to false, the delete action will be displayed but the actions column will not be displayed.
  final bool showDeleteAction;

  /// Whether to show the add row button.
  /// Defaults to true.
  /// If set to true and [showActions] is set to false, exception will be thrown because the actions column is required to save the new row.
  final bool showAddRowButton;

  /// Whether to add the new row beyond all existing rows, when add row button is clicked
  /// Defaults to false
  /// By default the new row becomes the first row
  final bool addRowAtTheEnd;

  /// Whether to allow only one row to be editable at any particular time
  /// Defaults to false
  /// By default multiple rows can be editable simultaneously
  final bool editOneByOne;

  /// Whether to save the rows automatically as the user moves focus out of the current editing row to another one
  /// Defaults to false
  /// This option requires edit one by one be enabled
  final bool autoSaveRows;

  /// Whether to edit a row cell by tapping on it, save a row when a user completes editing a row (the last cell of a row) and add a row when the user completes editing the last row
  /// Defaults to false
  final bool touchMode;

  /// Whether to show delete or cancel actions
  /// In view mode delete action is shown
  /// In edit mode edit action is shown
  final bool showDeleteOrCancelAction;

  @override
  State<DynamicTable> createState() => DynamicTableState();
}

class DynamicTableState extends State<DynamicTable> {
  GlobalKey<PaginatedDataTableState> _paginatedDataTableState = GlobalKey();

  late DynamicTableSource _source;

  List<DynamicTableDataColumn> _columns = [];

  int _rowsPerPage = 10;
  int _firstRowIndex = 0;

  int get _lastRowIndex => (_firstRowIndex + (_rowsPerPage-1));

  TableRowRange get _tableRowVisibleRange => (startIndex: _firstRowIndex, endIndex: _lastRowIndex);

  void _buildColumns() {
    _columns = [...widget.columns];
  }

  void _buildSource() {
    _source = DynamicTableSource(
      data: widget.rows,
      columns: _columns,
      actionColumnTitle: widget.actionColumnTitle,
      selectable: widget.selectable,
      showActions: widget.showActions,
      showDeleteAction: widget.showDeleteAction,
      showDeleteOrCancelAction: widget.showDeleteOrCancelAction,
      editOneByOne: widget.editOneByOne,
      autoSaveRowsEnabled: widget.autoSaveRows,
      touchMode: widget.touchMode,
      onRowEdit: widget.onRowEdit,
      onRowDelete: widget.onRowDelete,
      onRowSave: widget.onRowSave,
      tableRowVisibleRange: () => _tableRowVisibleRange,
      pageTo: (rowIndex) => _paginatedDataTableState.currentState?.pageTo(rowIndex),
      triggerTableStateUpdate: () => setState(() {},)
    );
  }

  @override
  void initState() {
    super.initState();
    _buildColumns();
    _buildSource();
    _rowsPerPage = widget.rowsPerPage;
  }

  @override
  void didUpdateWidget(covariant DynamicTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    _rowsPerPage = widget.rowsPerPage;
    _source.updateConfig(
      actionColumnTitle: widget.actionColumnTitle,
      selectable: widget.selectable,
      showActions: widget.showActions,
      showDeleteAction: widget.showDeleteAction,
      showDeleteOrCancelAction: widget.showDeleteOrCancelAction,
      editOneByOne: widget.editOneByOne,
      autoSaveRowsEnabled: widget.autoSaveRows,
      touchMode: widget.touchMode,
      onRowEdit: widget.onRowEdit,
      onRowDelete: widget.onRowDelete,
      onRowSave: widget.onRowSave,
    );
    _source.updateRowsByKeyByDiffChecking(widget.rows);
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      key: _paginatedDataTableState,
      header: widget.header,
      actions: [
        if (widget.showAddRowButton)
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text("Add Row"),
            onPressed: () {
              if (widget.addRowAtTheEnd) {
                _source.addRowLast();
              } else {
                _source.addRow();
              }
            },
          ),
        if (widget.showSelectAllButton)
          IconButton(
            onPressed: () {
              _source.selectAllRows(
                  isSelected: true,
                  filterByIndex: widget.filterSelectionByIndex);
            },
            icon: const Icon(Icons.select_all),
            tooltip: widget.selectAllToolTip,
          ),
        if (widget.showSelectAllButton)
          IconButton(
            onPressed: () {
              _source.selectAllRows(isSelected: false);
            },
            icon: const Icon(Icons.deselect_outlined),
            tooltip: widget.unselectAllToolTip,
          ),
        ...?widget.actions,
      ],
      columns: _source.getTableColumns(),
      sortColumnIndex: _source.sortColumnIndex,
      sortAscending: _source.sortOrder.toBool(),
      onSelectAll: (value) {
        _source.selectAllRows(isSelected: value ?? false);
        widget.onSelectAll?.call(value);
      },
      dataRowMinHeight: widget.dataRowMinHeight,
      dataRowMaxHeight: widget.dataRowMaxHeight,
      headingRowHeight: widget.headingRowHeight,
      horizontalMargin: widget.horizontalMargin,
      columnSpacing: widget.columnSpacing,
      showCheckboxColumn: widget.showCheckboxColumn,
      showFirstLastButtons: widget.showFirstLastButtons,
      initialFirstRowIndex: widget.initialFirstRowIndex,
      onPageChanged: (firstRowIndex) {
        _firstRowIndex = firstRowIndex;
        _source.focusRow(firstRowIndex, tableRowRange: _tableRowVisibleRange);
        widget.onPageChanged?.call(firstRowIndex);
      },
      rowsPerPage: _rowsPerPage,
      availableRowsPerPage: widget.availableRowsPerPage,
      onRowsPerPageChanged: (value) {
              setState(() {
                _rowsPerPage = value!;
              });
              widget.onRowsPerPageChanged?.call(value);
            },
      dragStartBehavior: widget.dragStartBehavior,
      arrowHeadColor: widget.arrowHeadColor,
      source: _source,
      checkboxHorizontalMargin: widget.checkboxHorizontalMargin,
      controller: widget.controller,
      primary: widget.primary,
    );
  }
}
