import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twist_chat/providers/active_filter.dart';
import 'package:twist_chat/providers/filter.dart';

Future<void> showModificationModal(BuildContext context, WidgetRef ref) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          children: [
            Consumer(
              builder: (context, ref, child) {
                final activeFilter = ref.watch(activeFilterProvider);
                final filters = ref.watch(filterProvider).value;
                if (filters == null) return const SizedBox.shrink();

                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2,
                  ),
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    final filter = filters[index];
                    return Card(
                      color:
                          activeFilter == filter.id
                              ? Theme.of(context).highlightColor
                              : Theme.of(context).cardColor,
                      child: InkWell(
                        onTap: () {
                          // Update the active text filter using the notifier.
                          ref
                              .read(activeFilterProvider.notifier)
                              .setActiveTextFilter(filter.id);
                          // Optionally close the modal.
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                filter.emoji,
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                filter.name,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
