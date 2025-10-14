import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String imageUrl;
  final bool isDark;

  const TicketCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.imageUrl,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? Colors.grey.shade50 : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black45 : Colors.grey.shade300,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "NFT TICKET",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
                const SizedBox(height: 10),
                Text(title,
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                const SizedBox(height: 4),
                Text(description,
                    style: TextStyle(color: textColor.withOpacity(0.7))),
                const SizedBox(height: 8),
                Text("Valid in $date",
                    style: TextStyle(color: textColor.withOpacity(0.5))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
