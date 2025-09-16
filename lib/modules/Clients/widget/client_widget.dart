import 'package:flutter/material.dart';

Widget buildClientCard(Map<String, dynamic> client, BuildContext context) {
  final theme = Theme.of(context);

  return Card(
    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
    elevation: 4,

    shadowColor: Colors.black.withOpacity(0.3),
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color.fromRGBO(96, 165, 250, 0.25),
        child: Text(
          client['companyName'][0].toUpperCase(),
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
      ),
      title: Text(
        client['companyName'],
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Row(
        children: [
          Text("${client['numberofInvoices']} Invoices"),
          const SizedBox(width: 8),
          Container(
            height: 18,
            width: 1,
            color: Theme.of(context).dividerColor.withOpacity(0.5),
            margin: const EdgeInsets.symmetric(horizontal: 8),
          ),
          Text("₹ ${client['amountDue'].toStringAsFixed(2)}"),
        ],
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.chevron_right,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        onPressed: () {},
      ),
      onTap: () {},
    ),
  );
}
