import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:never_out/models/product_model.dart';
import 'package:never_out/screens/icon_select.dart';
import 'package:never_out/theme/app_colors.dart';
import 'package:never_out/theme/app_component_styles.dart';
import 'package:never_out/theme/app_constants.dart';

enum PriorityStatus { ranOut, normal }

class NewProductScreen extends StatefulWidget {
  const NewProductScreen({
    super.key,
    this.product,
  });

  final ProductModel? product;

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _quantityController;

  late UnitType _selectedUnitType;
  late int _quantity;
  String? _titleErrorText;
  String? _quantityErrorText;
  bool _isSubmitting = false;

  FaIconData? iconData;

  bool get _isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();

    final product = widget.product;
    _quantity = product?.quantity ?? 1;
    _selectedUnitType = product?.unitType ?? UnitType.kilogram;
    iconData = product?.iconData ?? FontAwesomeIcons.boxOpen;

    _titleController = TextEditingController(text: product?.name ?? '');
    _quantityController = TextEditingController(text: _quantity.toString());
    _titleController.addListener(_handleTitleChanged);
    _quantityController.addListener(_handleQuantityChanged);
  }

  @override
  void dispose() {
    _titleController.removeListener(_handleTitleChanged);
    _quantityController.removeListener(_handleQuantityChanged);
    _titleController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _handleTitleChanged() {
    if (_titleErrorText == null || _titleController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      _titleErrorText = null;
    });
  }

  void _handleQuantityChanged() {
    final quantityText = _quantityController.text.trim();
    final parsedQuantity = int.tryParse(quantityText);
    final nextQuantity = parsedQuantity ?? 0;
    final nextQuantityErrorText = _quantityErrorText == null
        ? null
        : _quantityErrorTextFor(quantityText, parsedQuantity);

    if (nextQuantity == _quantity &&
        nextQuantityErrorText == _quantityErrorText) {
      return;
    }

    setState(() {
      _quantity = nextQuantity;
      _quantityErrorText = nextQuantityErrorText;
    });
  }

  void _setQuantity(int value) {
    final nextQuantity = value < 1 ? 0 : value;

    setState(() {
      _quantity = nextQuantity;
      _quantityErrorText = _quantityErrorText == null
          ? null
          : _quantityErrorTextFor(nextQuantity.toString(), nextQuantity);
    });

    _quantityController.text = nextQuantity.toString();
    _quantityController.selection = TextSelection.collapsed(
      offset: _quantityController.text.length,
    );
  }

  PriorityStatus get _priorityStatus {
    return _quantity <= 1 ? PriorityStatus.ranOut : PriorityStatus.normal;
  }

  String? _quantityErrorTextFor(String quantityText, int? quantity) {
    if (quantityText.isEmpty) {
      return 'Enter a quantity.';
    }

    if (quantity == null || quantity <= 0) {
      return 'Quantity must be greater than zero.';
    }

    return null;
  }

  Future<void> _submitFormData() async {
    if (_isSubmitting) {
      return;
    }

    final name = _titleController.text.trim();
    final quantityText = _quantityController.text.trim();
    final quantity = int.tryParse(quantityText);
    final titleErrorText = name.isEmpty ? 'Enter a product name.' : null;
    final quantityErrorText = _quantityErrorTextFor(quantityText, quantity);

    if (titleErrorText != null || quantityErrorText != null) {
      setState(() {
        _titleErrorText = titleErrorText;
        _quantityErrorText = quantityErrorText;
      });
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final validatedQuantity = quantity!;
    final existingProduct = widget.product;

    final product = ProductModel(
      serverId: existingProduct?.serverId,
      databaseId: existingProduct?.databaseId,
      name: name,
      quantity: validatedQuantity,
      unitType: _selectedUnitType,
      updatedAt: DateTime.now(),
      syncStatus: _isEditing
          ? _syncStatusForEditedProduct(existingProduct!)
          : SyncStatus.pendingCreate,
      iconData: iconData!,
    );

    if (!mounted) {
      return;
    }

    Navigator.pop(context, product);
  }

  SyncStatus _syncStatusForEditedProduct(ProductModel product) {
    if (product.syncStatus == SyncStatus.pendingCreate) {
      return SyncStatus.pendingCreate;
    }

    return SyncStatus.pendingUpdate;
  }

  Widget _buildTitleInput() {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppThemeColors>()!;
    final textColor = theme.colorScheme.onSurface;

    return TextField(
      controller: _titleController,
      cursorColor: textColor,
      maxLength: 30,
      maxLines: 1,
      style: theme.textTheme.bodyLarge?.copyWith(color: textColor),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        errorText: _titleErrorText,
        prefixIcon: InkWell(
          onTap: () async {
            final newIconData = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const IconSelectScreen(),
              ),
            );
            setState(() {
              iconData = newIconData;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: FaIcon(iconData),
          ),
        ),
        label: Text(
          'Enter Product Name',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: appColors.inputLabel,
          ),
        ),
      ),
    );
  }

  Widget _buildUnitTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Unit Type', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: AppSpacing.small),
        SizedBox(
          height: AppSizes.unitSelectorHeight,
          width: double.infinity,
          child: SegmentedButton<UnitType>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment<UnitType>(
                value: UnitType.kilogram,
                label: Text('Kg'),
              ),
              ButtonSegment<UnitType>(
                value: UnitType.liter,
                label: Text('Liter'),
              ),
              ButtonSegment<UnitType>(
                value: UnitType.piece,
                label: Text('Piece'),
              ),
              ButtonSegment<UnitType>(
                value: UnitType.box,
                label: Text('Box'),
              ),
            ],
            selected: {_selectedUnitType},
            onSelectionChanged: (newSelection) {
              setState(() {
                _selectedUnitType = newSelection.first;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityInput() {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quantity', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: AppSpacing.small),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              style: AppButtonStyles.circularIconButtonStyle(),
              onPressed: () => _setQuantity(_quantity - 1),
              child: const Icon(Icons.remove),
            ),
            const SizedBox(width: AppSpacing.small),
            Expanded(
              child: TextField(
                controller: _quantityController,
                cursorColor: textColor,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  errorText: _quantityErrorText,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.small),
            ElevatedButton(
              style: AppButtonStyles.circularIconButtonStyle(),
              onPressed: () => _setQuantity(_quantity + 1),
              child: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xLarge),
        _buildPriorityIndicator(),
      ],
    );
  }

  Widget _buildPriorityIndicator() {
    // Priority is derived from quantity so it stays consistent with the form.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Priority', style: Theme.of(context).textTheme.titleSmall),
        Row(
          children: [
            Expanded(
              child: SegmentedButton<PriorityStatus>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment<PriorityStatus>(
                    value: PriorityStatus.ranOut,
                    label: Text('Ran Out'),
                    icon: Icon(Icons.warning_rounded),
                  ),
                  ButtonSegment<PriorityStatus>(
                    value: PriorityStatus.normal,
                    label: Text('Normal'),
                    icon: Icon(Icons.list),
                  ),
                ],
                selected: {_priorityStatus},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppThemeColors>()!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: _isSubmitting ? null : _submitFormData,
          icon: _isSubmitting
              ? SizedBox(
                  width: AppSizes.submitSpinner,
                  height: AppSizes.submitSpinner,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.5),
                  ),
                )
              : const Icon(Icons.check),
          label: Text(_isEditing ? 'Save Product' : 'Add Product'),
          style: ElevatedButton.styleFrom(
            fixedSize: AppSizes.primaryActionButton,
          ),
        ),
        ElevatedButton(
          onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
          style: AppButtonStyles.secondaryElevatedButtonStyle(
            appColors,
            fixedSize: AppSizes.secondaryActionButton,
          ),
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(
      context,
    ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Edit Product' : 'Add Product',
          style: titleStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xLarge,
            AppSpacing.xLarge,
            AppSpacing.xLarge,
            AppSpacing.medium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTitleInput(),
              const SizedBox(height: AppSpacing.xLarge),
              _buildUnitTypeSelector(),
              const SizedBox(height: AppSpacing.xLarge),
              _buildQuantityInput(),
              const SizedBox(height: AppSpacing.xxLarge),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
