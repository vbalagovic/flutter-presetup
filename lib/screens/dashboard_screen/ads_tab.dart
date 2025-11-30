import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdsTab extends StatelessWidget {
  const AdsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: Text(tr('Rewards')),
            actions: [
              IconButton(
                icon: const Icon(FontAwesomeIcons.star),
                onPressed: () {},
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Points Overview Card
                _PointsOverviewCard(
                  points: '2,750',
                  rank: tr('Gold Member'),
                  nextRank: tr('Platinum'),
                  pointsToNext: '250',
                ),
                const SizedBox(height: 24),

                // Categories
                _SectionTitle(title: tr('Categories')),
                //const SizedBox(height: 12),
                const _RewardCategories(),

                //const SizedBox(height: 24),

                // Featured Rewards
                _SectionTitle(title: tr('Featured Rewards')),
                const SizedBox(height: 12),
                const _RewardsList(),

                const SizedBox(height: 24),

                // History
                _SectionTitle(title: tr('Recent Activity')),
                const SizedBox(height: 12),
                const _RewardHistory(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _PointsOverviewCard extends StatelessWidget {
  final String points;
  final String rank;
  final String nextRank;
  final String pointsToNext;

  const _PointsOverviewCard({
    required this.points,
    required this.rank,
    required this.nextRank,
    required this.pointsToNext,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: theme.colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  FontAwesomeIcons.star,
                  color: Colors.amber,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        points,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        tr('Available Points'),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    rank,
                    style: const TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              tr('{points} points until {rank}', args: [
                pointsToNext,
                nextRank,
              ]),
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: 0.85,
                minHeight: 8,
                backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RewardCategories extends StatelessWidget {
  const _RewardCategories();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.5,
      children: [
        _CategoryCard(
          icon: FontAwesomeIcons.crown,
          title: tr('Premium'),
          color: Colors.amber,
        ),
        _CategoryCard(
          icon: FontAwesomeIcons.palette,
          title: tr('Themes'),
          color: Colors.purple,
        ),
        _CategoryCard(
          icon: FontAwesomeIcons.ticket,
          title: tr('Events'),
          color: Colors.blue,
        ),
        _CategoryCard(
          icon: FontAwesomeIcons.gift,
          title: tr('Special'),
          color: Colors.green,
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _CategoryCard({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RewardHistory extends StatelessWidget {
  const _RewardHistory();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        _HistoryItem(
          icon: FontAwesomeIcons.gift,
          title: tr('Premium Theme Unlocked'),
          points: '-500',
          date: '2h ago',
          color: Colors.purple,
        ),
        const SizedBox(height: 12),
        _HistoryItem(
          icon: FontAwesomeIcons.trophy,
          title: tr('Achievement Bonus'),
          points: '+100',
          date: '5h ago',
          color: Colors.green,
        ),
      ],
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String points;
  final String date;
  final Color color;

  const _HistoryItem({
    required this.icon,
    required this.title,
    required this.points,
    required this.date,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  date,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Text(
            points,
            style: theme.textTheme.titleMedium?.copyWith(
              color: points.startsWith('+')
                  ? Colors.green
                  : theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final Widget? action;

  const _SectionTitle({
    required this.title,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (action != null) action!,
      ],
    );
  }
}

class _RewardsList extends StatelessWidget {
  const _RewardsList();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _RewardCard(
            icon: FontAwesomeIcons.crown,
            title: tr('Premium Access'),
            description: tr('Unlock all premium features'),
            points: '1000',
            backgroundColor: Colors.amber,
          ),
          const SizedBox(width: 12),
          _RewardCard(
            icon: FontAwesomeIcons.palette,
            title: tr('Custom Themes'),
            description: tr('Personalize your experience'),
            points: '500',
            backgroundColor: Colors.purple,
          ),
          const SizedBox(width: 12),
          _RewardCard(
            icon: FontAwesomeIcons.ticket,
            title: tr('Event Pass'),
            description: tr('Join exclusive events'),
            points: '750',
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}

class _RewardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String points;
  final Color backgroundColor;

  const _RewardCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.points,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: backgroundColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: backgroundColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: backgroundColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      FontAwesomeIcons.star,
                      size: 12,
                      color: backgroundColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      points,
                      style: TextStyle(
                        color: backgroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 36),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(tr('Redeem')),
          ),
        ],
      ),
    );
  }
}
