import 'package:eventify/config/app_colors.dart';
import 'package:eventify/providers/event_provider.dart';
import 'package:eventify/providers/user_provider.dart';
import 'package:eventify/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserEventScreen extends StatelessWidget {
  const UserEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    EventProvider eventProvider = context.watch<EventProvider>();
    eventProvider.fetchEvents(context.read<UserProvider>().currentUser!.rememberToken ?? '');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        itemCount: eventProvider.eventList.length,
        itemBuilder: (context, index) {
          final event = eventProvider.eventList[index];
          return EventCard(event: event);
        },
      ),
    );
  }
}
