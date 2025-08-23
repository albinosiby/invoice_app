// lib/modules/Clients/screen/add_client.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_app/modules/Clients/cubit/client_cubit.dart';
import 'package:invoice_app/modules/Clients/model/client_model.dart';
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
      final client = Client(
        fullName: _fullNameController.text,
        companyName: _companyNameController.text,
        email: _emailController.text,
        phoneNumber: _phoneNumberController.text,
        gstinTaxId: _gstinTaxIdController.text.isNotEmpty
            ? _gstinTaxIdController.text
            : null,
        businessType: _selectedBusinessType,
        streetAddress: _streetAddressController.text,
        city: _cityController.text,
        stateProvince: _stateProvinceController.text,
        postalCode: _postalCodeController.text,
        country: _selectedCountry ?? '',
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      );

      context.read<ClientCubit>().addClient(client);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<ClientCubit, ClientState>(
      listener: (context, state) {
        if (state is ClientError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: theme.appBarTheme.backgroundColor,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: theme.colorScheme.onBackground,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Add Client',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              onPressed: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => SettingsPage())),
            ),
          ],
        ),
        body: BlocBuilder<ClientCubit, ClientState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 24.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Personal Details',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text('Full Name', style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 354,
                      height: 56,
                      child: TextFormField(
                        controller: _fullNameController,
                        decoration: InputDecoration(
                          hintText: 'Enter full name',
                          hintStyle: TextStyle(color: theme.hintColor),
                          filled: true,
                          fillColor: theme.colorScheme.onSurface.withOpacity(
                            0.05,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter full name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Company Name', style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 354,
                      height: 56,
                      child: TextFormField(
                        controller: _companyNameController,
                        decoration: InputDecoration(
                          hintText: 'Enter company name',
                          hintStyle: TextStyle(color: theme.hintColor),
                          filled: true,
                          fillColor: theme.colorScheme.onSurface.withOpacity(
                            0.05,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter company name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Email', style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 354,
                      height: 56,
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Enter email',
                          hintStyle: TextStyle(color: theme.hintColor),
                          filled: true,
                          fillColor: theme.colorScheme.onSurface.withOpacity(
                            0.05,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
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
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Phone Number', style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 354,
                      height: 56,
                      child: TextFormField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                          hintText: 'Enter phone number',
                          hintStyle: TextStyle(color: theme.hintColor),
                          filled: true,
                          fillColor: theme.colorScheme.onSurface.withOpacity(
                            0.05,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Company Details',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('GSTIN/Tax ID', style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 354,
                      height: 56,
                      child: TextFormField(
                        controller: _gstinTaxIdController,
                        decoration: InputDecoration(
                          hintText: 'Enter GSTIN/Tax ID',
                          hintStyle: TextStyle(color: theme.hintColor),
                          filled: true,
                          fillColor: theme.colorScheme.onSurface.withOpacity(
                            0.05,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Business Type', style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 6),
                    buildDropdownInput(
                      context,
                      _selectedBusinessType,
                      'Select business type',
                      _businessTypes,
                      (value) {
                        setState(() {
                          _selectedBusinessType = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Address',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Street Address', style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 354,
                      height: 56,
                      child: TextFormField(
                        controller: _streetAddressController,
                        decoration: InputDecoration(
                          hintText: 'Enter street address',
                          hintStyle: TextStyle(color: theme.hintColor),
                          filled: true,
                          fillColor: theme.colorScheme.onSurface.withOpacity(
                            0.05,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter street address';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('City', style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 354,
                      height: 56,
                      child: TextFormField(
                        controller: _cityController,
                        decoration: InputDecoration(
                          hintText: 'Enter city',
                          hintStyle: TextStyle(color: theme.hintColor),
                          filled: true,
                          fillColor: theme.colorScheme.onSurface.withOpacity(
                            0.05,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter city';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('State/Province', style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 354,
                      height: 56,
                      child: TextFormField(
                        controller: _stateProvinceController,
                        decoration: InputDecoration(
                          hintText: 'Enter state/province',
                          hintStyle: TextStyle(color: theme.hintColor),
                          filled: true,
                          fillColor: theme.colorScheme.onSurface.withOpacity(
                            0.05,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter state/province';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Postal Code', style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 354,
                      height: 56,
                      child: TextFormField(
                        controller: _postalCodeController,
                        decoration: InputDecoration(
                          hintText: 'Enter postal code',
                          hintStyle: TextStyle(color: theme.hintColor),
                          filled: true,
                          fillColor: theme.colorScheme.onSurface.withOpacity(
                            0.05,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter postal code';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Country', style: theme.textTheme.bodyLarge),
                    buildDropdownInput(
                      context,
                      _selectedCountry,
                      'Select country',
                      _countries,
                      (value) {
                        setState(() {
                          _selectedCountry = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    Text('Notes', style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 354,
                      height: 70,
                      child: TextFormField(
                        controller: _notesController,
                        decoration: InputDecoration(
                          hintText: 'Add notes',
                          hintStyle: TextStyle(color: theme.hintColor),
                          filled: true,
                          fillColor: theme.colorScheme.onSurface.withOpacity(
                            0.05,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Center(
                      child: state is ClientLoading
                          ? CircularProgressIndicator()
                          : customButtonLarge(
                              context,
                              'Save',
                              () => _saveClient(context),
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
