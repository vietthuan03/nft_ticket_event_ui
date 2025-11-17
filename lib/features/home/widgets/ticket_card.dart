import 'package:flutter/material.dart';
import 'package:nft_ticket_event_ui/features/home/models/ticket_model.dart';
import 'package:nft_ticket_event_ui/features/home/widgets/ticket_dialog.dart';

class TicketCard extends StatelessWidget {
  final TicketModel ticket;
  final bool showBuyButton;

  const TicketCard({
    super.key,
    required this.ticket,
    this.showBuyButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final TicketDialog ticketDialog = TicketDialog();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final bgColor = colorScheme.surface;
    final textColor = colorScheme.onSurface;
    final shadowColor = theme.brightness == Brightness.dark
        ? Colors.black54
        : Colors.grey.shade300;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: shadowColor, blurRadius: 10, spreadRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image network (model dùng URL)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              ticket.imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 180,
                color: Colors.grey.shade200,
                alignment: Alignment.center,
                child: const Icon(Icons.image_not_supported, size: 40),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // PASS LABEL
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "1 DAY PASS",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),

                const SizedBox(height: 10),
                Text(
                  ticket.title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  ticket.location,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: textColor.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  ticket.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: textColor.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 10),

                // Footer row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Valid in ${ticket.date}",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: textColor.withOpacity(0.6),
                      ),
                    ),

                    if (showBuyButton)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                        onPressed: () {
                          // ticketDialog.showBuyTicketDialog(context);
                        },
                        child: const Text(
                          "Buy",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
