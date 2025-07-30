import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:galactic_football_league/domain/models/league_standing.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamStandingRow extends StatelessWidget {
  final int rank;
  final LeagueStanding standing;

  const TeamStandingRow({
    super.key,
    required this.rank,
    required this.standing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTopThree = rank <= 3;
    final isDarkMode = theme.brightness == Brightness.dark;

    // Цвет неонового свечения для топ-3
    final Color? glowColor = isTopThree && isDarkMode
        ? (rank == 1
            ? const Color(0xFFFFD700) // Gold
            : rank == 2
                ? const Color(0xFFC0C0C0) // Silver
                : const Color(0xFFCD7F32)) // Bronze
        : null;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isDarkMode
                ? theme.cardTheme.color
                : theme.cardTheme.color, // Используем цвет из CardTheme
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.2)
                  : Colors.grey.shade300,
            ),
            boxShadow: [
              if (glowColor != null)
                BoxShadow(
                  color: glowColor.withOpacity(0.5),
                  blurRadius: 12.0,
                  spreadRadius: 1.0,
                ),
            ],
          ),
          child: Row(
            children: [
              Text(
                '#$rank',
                style: GoogleFonts.exo2(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: glowColor ?? theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  standing.team.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 8),
              _StatPill(label: 'W', value: standing.wins.toString()),
              _StatPill(label: 'D', value: standing.draws.toString()),
              _StatPill(label: 'L', value: standing.losses.toString()),
              const SizedBox(width: 12),
              Text(
                standing.points.toString(),
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Вспомогательный виджет для отображения статистики (W, D, L)
class _StatPill extends StatelessWidget {
  final String label;
  final String value;

  const _StatPill({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      width: 40,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black.withOpacity(0.2) : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}