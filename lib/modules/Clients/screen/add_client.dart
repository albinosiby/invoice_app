// lib/modules/Clients/screen/add_client.dart
import 'package:flutter/material.dart';
import 'package:invoice_app/constants/app_constants.dart';
import 'package:invoice_app/modules/Clients/widget/add_client.dart';
import 'package:invoice_app/modules/settings/screen/settings.dart';

class AddClientScreen extends StatefulWidget {
  const AddClientScreen({super.key});

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _gstinTaxIdController = TextEditingController();
  final TextEditingController _streetAddressController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateProvinceController =
      TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String? _selectedBusinessType;
  String? _selectedCountry;

  final List<String> _businessTypes = [
    'Sole Proprietorship',
    'Partnership',
    'Corporation',
    'LLC',
    'Non-profit',
    'Other',
  ];

  final List<String> _countries = [
    'United States',
    'Canada',
    'United Kingdom',
    'Australia',
    'India',
    'Germany',
    'France',
    'Other',
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _companyNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _gstinTaxIdController.dispose();
    _streetAddressController.dispose();
    _cityController.dispose();
    _stateProvinceController.dispose();
    _postalCodeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _saveClient(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.appBarTheme.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Add Client',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              theme.brightness == Brightness.dark
                  ? Iconconstants.settingsWhite
                  : Iconconstants.settingsBlack,
              height: 24,
              width: 24,
            ),
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => SettingsPage())),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Personal Details Section
              buildSectionHeader('Personal Details', context),
              const SizedBox(height: 16),

              buildTextField(
                controller: _fullNameController,
                label: 'Full Name',
                hint: 'Enter full name',
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter full name';
                  }
                  return null;
                },
                context: context,
              ),
              const SizedBox(height: 8),

              buildTextField(
                controller: _companyNameController,
                label: 'Company Name',
                hint: 'Enter company name',
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter company name';
                  }
                  return null;
                },
                context: context,
              ),
              const SizedBox(height: 8),

              buildTextField(
                controller: _emailController,
                label: 'Email',
                hint: 'Enter email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                context: context,
              ),
              const SizedBox(height: 8),

              buildTextField(
                controller: _phoneNumberController,
                label: 'Phone Number',
                hint: 'Enter phone number',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
                context: context,
              ),
              const SizedBox(height: 16),

              // Company Details Section
              buildSectionHeader('Company Details', context),
              const SizedBox(height: 16),

              buildTextField(
                controller: _gstinTaxIdController,
                label: 'GSTIN/Tax ID',
                hint: 'Enter GSTIN/Tax ID',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter GSTIN/Tax ID';
                  }
                  return null;
                },
                context: context,
              ),
              const SizedBox(height: 8),

              buildDropdownField(
                value: _selectedBusinessType,
                label: 'Business Type',
                hint: 'Select business type',
                items: _businessTypes,
                onChanged: (value) {
                  setState(() {
                    _selectedBusinessType = value;
                  });
                },
                context: context,
              ),
              const SizedBox(height: 16),

              // Address Section
              buildSectionHeader('Address', context),
              const SizedBox(height: 16),

              buildTextField(
                controller: _streetAddressController,
                label: 'Street Address',
                hint: 'Enter street address',
                keyboardType: TextInputType.streetAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter street address';
                  }
                  return null;
                },
                context: context,
              ),
              const SizedBox(height: 8),

              buildTextField(
                controller: _cityController,
                label: 'City',
                hint: 'Enter city',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter city';
                  }
                  return null;
                },
                context: context,
              ),
              const SizedBox(height: 8),

              buildTextField(
                controller: _stateProvinceController,
                label: 'State/Province',
                hint: 'Enter state/province',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter state/province';
                  }
                  return null;
                },
                context: context,
              ),
              const SizedBox(height: 8),

              buildTextField(
                controller: _postalCodeController,
                label: 'Postal Code',
                hint: 'Enter postal code',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter postal code';
                  }
                  return null;
                },
                context: context,
              ),
              const SizedBox(height: 8),

              buildDropdownField(
                value: _selectedCountry,
                label: 'Country',
                hint: 'Select country',
                items: _countries,
                onChanged: (value) {
                  setState(() {
                    _selectedCountry = value;
                  });
                },
                context: context,
              ),
              const SizedBox(height: 8),

              // Notes Section
              buildNotesField(_notesController, context),
              const SizedBox(height: 20.0),

              // Save Button
              Center(
                child: customButtonLarge(
                  context,
                  'Save',
                  () => _saveClient(context),
                ),
              ),
              const SizedBox(height: 25.0),
            ],
          ),
        ),
      ),
    );
  }
}
