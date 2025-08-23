// lib/modules/Clients/screen/client_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_app/config/themes/theme_config.dart';
import 'package:invoice_app/modules/Clients/cubit/client_cubit.dart';
import 'package:invoice_app/modules/Clients/model/client_model.dart';
import 'package:invoice_app/modules/Clients/repository/client_repository.dart';
import 'package:invoice_app/modules/Clients/screen/add_client.dart';
import 'package:invoice_app/modules/settings/screen/settings.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ClientCubit(clientRepository: ClientRepositoryImpl())..loadClients(),
      child: const _ClientScreenContent(),
    );
  }
}

class _ClientScreenContent extends StatefulWidget {
  const _ClientScreenContent({super.key});

  @override
  State<_ClientScreenContent> createState() => _ClientScreenContentState();
}

class _ClientScreenContentState extends State<_ClientScreenContent> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedSort = 'All';
  String _searchQuery = '';

  final Map<String, int Function(Client, Client)> _sortFunctions = {
    'All': (a, b) => 0, // No sorting, maintain original order
    'New': (a, b) => b.createdAt.compareTo(a.createdAt), // Newest first
    'Name': (a, b) => a.fullName.compareTo(b.fullName), // A-Z
    'Company': (a, b) => a.companyName.compareTo(b.companyName), // Company A-Z
  };

  List<Client> _sortClients(List<Client> clients) {
    // Apply search filter first
    var sortedClients = clients.where((client) {
      return _searchQuery.isEmpty ||
          client.fullName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          client.companyName.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          client.email.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    // Apply sorting
    final sortFunction = _sortFunctions[_selectedSort];
    if (sortFunction != null && _selectedSort != 'All') {
      sortedClients.sort(sortFunction);
    }

    return sortedClients;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Clients',
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
      body: BlocConsumer<ClientCubit, ClientState>(
        listener: (context, state) {
          if (state is ClientError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          List<Client> displayedClients = [];

          if (state is ClientLoaded) {
            displayedClients = _sortClients(state.clients);
          }

          return Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Search and Sort UI
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: TextStyle(color: theme.colorScheme.onBackground),
                        decoration: InputDecoration(
                          hintText: 'Search Clients',
                          hintStyle: TextStyle(
                            color: ThemeConfig.darkButtonTextDisabled,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: ThemeConfig.darkButtonTextDisabled,
                          ),
                          fillColor: theme.colorScheme.surface,
                          filled: true,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        // Show sort options dialog
                        _showSortOptions(context);
                      },
                      icon: Icon(
                        _selectedSort == 'All' ? Icons.filter_list : Icons.sort,
                        color: ThemeConfig.darkButtonTextDisabled,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: theme.colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Sort Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 8),
                      ..._sortFunctions.keys.map((sort) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: buildSortChip(
                            theme,
                            label: sort,
                            isSelected: _selectedSort == sort,
                            onPressed: () {
                              setState(() {
                                _selectedSort = sort;
                              });
                            },
                          ),
                        );
                      }).toList(),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Results count
                const SizedBox(height: 8),

                // Client List
                Expanded(child: _buildClientList(state, displayedClients)),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<ClientCubit>(),
                child: const AddClientScreen(),
              ),
            ),
          );
        },
        label: Text(
          'Add Client',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: ThemeConfig.buttonTextPrimary,
          ),
        ),
        icon: const Icon(
          Icons.person_add,
          color: ThemeConfig.buttonTextPrimary,
        ),
        backgroundColor: theme.colorScheme.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _showSortOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Sort Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _sortFunctions.keys.map((sort) {
              return ListTile(
                title: Text(sort),
                trailing: _selectedSort == sort
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
                onTap: () {
                  setState(() {
                    _selectedSort = sort;
                  });
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildClientList(ClientState state, List<Client> displayedClients) {
    if (state is ClientLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ClientError) {
      return Center(child: Text('Error: ${state.message}'));
    } else if (state is ClientLoaded) {
      if (displayedClients.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.people_outline,
                size: 64,
                color: Theme.of(
                  context,
                ).colorScheme.onBackground.withOpacity(0.3),
              ),
              const SizedBox(height: 16),
              Text(
                _searchQuery.isNotEmpty
                    ? 'No clients match your search'
                    : 'No clients found',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onBackground.withOpacity(0.5),
                ),
              ),
              if (_searchQuery.isNotEmpty)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _searchQuery = '';
                      _searchController.clear();
                    });
                  },
                  child: Text('Clear search'),
                ),
            ],
          ),
        );
      }
      return ListView.builder(
        itemCount: displayedClients.length,
        itemBuilder: (context, index) {
          final client = displayedClients[index];
          return _buildClientCard(client, context, index, Theme.of(context));
        },
      );
    } else {
      return const Center(child: Text('No clients found'));
    }
  }

  Widget _buildClientCard(
    Client client,
    BuildContext context,
    int index,
    dynamic theme,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color.fromRGBO(96, 165, 250, 0.25),
          child: Text(
            client.fullName[0].toUpperCase(),
            style: TextStyle(color: theme.colorScheme.primary),
          ),
        ),
        title: Text(
          client.fullName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(client.companyName), const SizedBox(height: 4)],
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.chevron_right,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          onPressed: () {
            _showDeleteDialog(context, client);
          },
        ),
        onTap: () {},
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Client client) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Client'),
        content: Text('Are you sure you want to delete ${client.fullName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<ClientCubit>().deleteClient(client.id!);
              Navigator.of(context).pop();
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSortChip(
    ThemeData theme, {
    required String label,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return FilterChip(
      label: Text(
        label,
        style: theme.textTheme.bodySmall?.copyWith(
          color: isSelected ? Colors.white : ThemeConfig.darkButtonTextDisabled,
        ),
      ),
      selected: isSelected,
      onSelected: (_) => onPressed(),
      backgroundColor: isSelected ? null : theme.colorScheme.surface,
      selectedColor: theme.colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          width: 1,
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.surface,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      showCheckmark: false, // This removes the tick mark
    );
  }
}
