import 'package:flutter/material.dart';
import 'package:galactic_football_league/domain/models/league_standing.dart';

class TeamStandingRow extends StatelessWidget {
  final LeagueStanding standing;

  const TeamStandingRow({super.key, required this.standing});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Text(
                standing.team.name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                standing.wins.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                standing.draws.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                standing.losses.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                standing.points.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}