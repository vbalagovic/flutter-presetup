import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:presetup/widgets/buttons/animated_press_button.dart';
import 'package:presetup/widgets/buttons/bouncing_icon_button.dart';
import 'package:presetup/widgets/buttons/glass_button.dart';
import 'package:presetup/widgets/buttons/gradient_button.dart';
import 'package:presetup/widgets/buttons/icon_animated_button.dart';
import 'package:presetup/widgets/cards/animated_flip_card.dart';
import 'package:presetup/widgets/cards/expandable_card.dart';
import 'package:presetup/widgets/cards/glass_card.dart';
import 'package:presetup/widgets/cards/gradient_border_card.dart.dart';
import 'package:presetup/widgets/cards/status_card.dart';
import 'package:presetup/widgets/cards/swipeable_card.dart';
import 'package:presetup/widgets/inputs/styled_inputs.dart';
import 'package:presetup/widgets/lists/styled_lists.dart';
import 'package:presetup/widgets/overlays/styled_overlays.dart';

class WidgetsShowcaseTab extends ConsumerStatefulWidget {
  const WidgetsShowcaseTab({super.key});

  @override
  ConsumerState<WidgetsShowcaseTab> createState() => _WidgetsShowcaseTabState();
}

class _WidgetsShowcaseTabState extends ConsumerState<WidgetsShowcaseTab> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar.medium(
          expandedHeight: 0,
          surfaceTintColor: Colors.transparent,
          backgroundColor: theme.scaffoldBackgroundColor,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              tr('Widgets Showcase'),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colorScheme.primary.withOpacity(0.05),
                    theme.colorScheme.secondary.withOpacity(0.05),
                  ],
                ),
              ),
            ),
          )),
      SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                // Input Widgets
                _WidgetSection(
                  title: tr('Input Elements'),
                  icon: FontAwesomeIcons.keyboard,
                  children: [
                    // Styled TextField Examples
                    const Text('Styled TextFields:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    StyledTextField(
                      label: 'Standard Input',
                      hint: 'Enter text here',
                      prefixIcon: FontAwesomeIcons.user,
                    ),
                    const SizedBox(height: 16),
                    StyledTextField(
                      label: 'Password Input',
                      hint: 'Enter password',
                      isPassword: true,
                      prefixIcon: FontAwesomeIcons.lock,
                    ),
                    const SizedBox(height: 16),
                    StyledTextField(
                      label: 'Search Input',
                      hint: 'Search...',
                      prefixIcon: FontAwesomeIcons.magnifyingGlass,
                      suffixIcon: FontAwesomeIcons.xmark,
                      onSuffixIconTap: () {},
                    ),
                    const SizedBox(height: 24),

                    // Animated Search Bar Example
                    const Text('Animated Search Bar:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Center(
                      child: AnimatedSearchBar(
                        hint: 'Search...',
                        onChanged: (value) {},
                        expandedWidth: 300,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // PIN Input Example
                    const Text('PIN Input:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    PinInput(
                      length: 4,
                      onCompleted: (pin) {},
                    ),
                    const SizedBox(height: 24),

                    // Tag Input Example
                    const Text('Tag Input:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TagInput(
                      initialTags: ['Flutter', 'Dart'],
                      onTagsChanged: (tags) {},
                      hint: 'Add tag...',
                      maxTags: 5,
                    ),
                    _CustomTextField(
                      label: tr('Standard Input'),
                      placeholder: tr('Enter text'),
                    ),
                    const SizedBox(height: 12),
                    _CustomTextField(
                      label: tr('Password Input'),
                      placeholder: tr('Enter password'),
                      isPassword: true,
                    ),
                    const SizedBox(height: 12),
                    _CustomTextField(
                      label: tr('Search Input'),
                      placeholder: tr('Search...'),
                      prefixIcon: FontAwesomeIcons.magnifyingGlass,
                      suffixIcon: FontAwesomeIcons.xmark,
                    ),
                  ],
                ),

                // Button Widgets
                _WidgetSection(
                  title: tr('Buttons'),
                  icon: FontAwesomeIcons.shapes,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(tr('Primary Button')),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(tr('Secondary Button')),
                    ),
                    const SizedBox(height: 12),
                    AnimatedPressButton(
                      label: "Animated Press Button",
                      onPressed: () {},
                    ),
                    const SizedBox(height: 12),
                    BouncingIconButton(
                        icon: Icons.access_alarm_outlined, onPressed: () {}),
                    const SizedBox(height: 12),
                    GlassButton(label: "Glass Button", onPressed: () {}),
                    const SizedBox(height: 12),
                    GradientButton(label: "Gradient Button", onPressed: () {}),
                    const SizedBox(height: 12),
                    IconAnimatedButton(
                      icon: FontAwesomeIcons.heart,
                      label: 'Like',
                      onPressed: () {
                        //print('Button pressed!');
                      },
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    FilledButton.tonal(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(tr('Tonal Button')),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () {},
                            icon: const Icon(FontAwesomeIcons.google, size: 18),
                            label: Text(tr('Google')),
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.red,
                              minimumSize: const Size(0, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () {},
                            icon:
                                const Icon(FontAwesomeIcons.facebook, size: 18),
                            label: Text(tr('Facebook')),
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.blue,
                              minimumSize: const Size(0, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Selection Widgets
                _WidgetSection(
                  title: tr('Selection'),
                  icon: FontAwesomeIcons.list,
                  children: [
                    _CustomDropdown(
                      label: tr('Dropdown'),
                      items: ['Option 1', 'Option 2', 'Option 3'],
                    ),
                    const SizedBox(height: 12),
                    _CustomCheckbox(
                      label: tr('Remember me'),
                    ),
                    const SizedBox(height: 12),
                    _CustomSwitch(
                      label: tr('Notifications'),
                    ),
                    const SizedBox(height: 12),
                    _CustomRadioGroup(
                      label: tr('Gender'),
                      options: [tr('Male'), tr('Female'), tr('Other')],
                    ),
                  ],
                ),

                // Cards and Lists
                _WidgetSection(
                  title: tr('Cards & Lists'),
                  icon: FontAwesomeIcons.creditCard,
                  children: [
                    // Glass Card Example
                    Stack(
                      children: [
                        // Background image or gradient to show glass effect
                        Container(
                          height: 185,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.withOpacity(0.5),
                                Colors.purple.withOpacity(0.5),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                        GlassCard(
                          width: double.infinity,
                          child: Column(
                            children: [
                              const Text(
                                'Glass Card Content',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'This card shows a glass morphism effect over any background.',
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text('Action'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Gradient Border Card Example
                    const Text('Gradient Border Card:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: GradientBorderCard(
                        gradientColors: [Colors.blue, Colors.purple],
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Gradient Border Content',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'This card features a gradient border that stretches full width.',
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('Action'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Animated Flip Card Example
                    const Text('Animated Flip Card (Tap to flip):',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 200,
                      child: AnimatedFlipCard(
                        front: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border:
                                Border.all(color: Colors.blue.withOpacity(0.2)),
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FontAwesomeIcons.creditCard, size: 32),
                                SizedBox(height: 16),
                                Text('Front Side'),
                              ],
                            ),
                          ),
                        ),
                        back: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: Colors.green.withOpacity(0.2)),
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FontAwesomeIcons.lock, size: 32),
                                SizedBox(height: 16),
                                Text('Back Side'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Expandable Card Example
                    const Text('Expandable Card:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ExpandableCard(
                      title: 'Expandable Content',
                      icon: FontAwesomeIcons.plus,
                      child: const Column(
                        children: [
                          Text('This is expanded content that can be toggled.'),
                          SizedBox(height: 16),
                          Text('You can put any widget here.'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Swipeable Card Example
                    const Text('Swipeable Card (Swipe left/right):',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SwipeableCard(
                        onSwipeLeft: () {},
                        onSwipeRight: () {},
                        leftAction: Container(
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(16)),
                          ),
                          child: const Center(
                            child: Icon(FontAwesomeIcons.trash,
                                color: Colors.white),
                          ),
                        ),
                        rightAction: Container(
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(16)),
                          ),
                          child: const Center(
                            child: Icon(FontAwesomeIcons.check,
                                color: Colors.white),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).secondaryHeaderColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const ListTile(
                            leading: Icon(FontAwesomeIcons.envelope),
                            title: Text('Swipeable Item'),
                            subtitle: Text('Swipe left or right'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Status Card Example
                    const Text('Status Card:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    StatusCard(
                      title: 'Active Status',
                      subtitle: 'Everything is working properly',
                      icon: FontAwesomeIcons.circleCheck,
                      color: Colors.green,
                      onTap: () {},
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Online',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                    _CustomCard(
                      title: tr('Basic Card'),
                      subtitle: tr('Card subtitle'),
                      content: tr('This is a basic card with some content.'),
                    ),
                    const SizedBox(height: 12),
                    _CustomListTile(
                      leading: FontAwesomeIcons.user,
                      title: tr('List Item'),
                      subtitle: tr('Supporting text'),
                    ),
                    const SizedBox(height: 12),
                    _CustomListTile(
                      leading: FontAwesomeIcons.bell,
                      title: tr('Notification'),
                      subtitle: tr('You have a new message'),
                      trailing: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          '1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Progress Indicators
                _WidgetSection(
                  title: tr('Progress'),
                  icon: FontAwesomeIcons.spinner,
                  children: [
                    _CustomProgressBar(
                      label: tr('Download Progress'),
                      value: 0.7,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(height: 8),
                            Text(
                              tr('Loading'),
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const CircularProgressIndicator.adaptive(),
                            const SizedBox(height: 8),
                            Text(
                              tr('Adaptive'),
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              tr('Custom'),
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                // Dialog Examples
                _WidgetSection(
                  title: tr('Dialogs'),
                  icon: FontAwesomeIcons.message,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _showAlertDialog(context),
                            child: Text(tr('Alert')),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _showConfirmDialog(context),
                            child: Text(tr('Confirm')),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _showBottomSheet(context),
                            child: Text(tr('Bottom Sheet')),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _showCustomDialog(context),
                            child: Text(tr('Custom')),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                buildOverlayExamples(context),
                _buildAnimatedListTileExamples(context),
                const SizedBox(height: 32),
                _buildSwipeActionListExamples(context),
                const SizedBox(height: 32),
                _buildGroupedListExamples(context),
                const SizedBox(height: 32),
                _buildExpandableListExamples(context),
                const SizedBox(height: 32),
                _buildReorderableListExamples(context),
              ],
            ),
          ))
    ]));
  }

  Widget _buildAnimatedListTileExamples(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Animated List Tiles',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        AnimatedListTile(
          title: 'Basic List Tile',
          subtitle: 'With subtitle and icon',
          leading: FontAwesomeIcons.star,
          onTap: () {},
        ),
        const SizedBox(height: 8),
        AnimatedListTile(
          title: 'With Custom Color',
          subtitle: 'Using custom accent color',
          leading: FontAwesomeIcons.heart,
          color: Colors.pink,
          onTap: () {},
        ),
        const SizedBox(height: 8),
        AnimatedListTile(
          title: 'With Trailing Widget',
          subtitle: 'Shows additional information',
          leading: FontAwesomeIcons.bell,
          trailing: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'New',
              style: TextStyle(
                color: Colors.green,
                fontSize: 12,
              ),
            ),
          ),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSwipeActionListExamples(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Swipeable List Items',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SwipeActionListTile(
          actions: [
            SwipeAction(
              icon: FontAwesomeIcons.trash,
              backgroundColor: Colors.red,
              onTap: () {
                debugPrint('Delete tapped');
              },
            ),
            SwipeAction(
              icon: FontAwesomeIcons.archive,
              backgroundColor: Colors.orange,
              onTap: () {
                debugPrint('Archive tapped');
              },
            ),
          ],
          child: ListTile(
            title: const Text('Swipe for Actions'),
            subtitle: const Text('Swipe left or right'),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(FontAwesomeIcons.envelope),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SwipeActionListTile(
          actions: [
            SwipeAction(
              icon: FontAwesomeIcons.thumbsUp,
              backgroundColor: Colors.green,
              onTap: () {
                debugPrint('Like tapped');
              },
            ),
            SwipeAction(
              icon: FontAwesomeIcons.share,
              backgroundColor: Colors.blue,
              onTap: () {
                debugPrint('Share tapped');
              },
            ),
          ],
          child: ListTile(
            title: const Text('Custom Actions'),
            subtitle: const Text('With different actions'),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(FontAwesomeIcons.star),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGroupedListExamples(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Grouped Lists',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GroupedListSection(
          title: 'Today',
          children: [
            ListTile(
              leading: const Icon(FontAwesomeIcons.message),
              title: const Text('New Message'),
              subtitle: const Text('10:30 AM'),
              trailing: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const ListTile(
              leading: Icon(FontAwesomeIcons.bell),
              title: Text('Reminder'),
              subtitle: Text('2:00 PM'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        GroupedListSection(
          title: 'Yesterday',
          children: [
            ListTile(
              leading: const Icon(FontAwesomeIcons.checkDouble),
              title: const Text('Completed Task'),
              subtitle: const Text('5:45 PM'),
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExpandableListExamples(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Expandable Lists',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ExpandableListTile(
          title: 'Project Details',
          subtitle: 'Tap to view more',
          leading: FontAwesomeIcons.folderOpen,
          children: [
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(FontAwesomeIcons.file, size: 16),
              ),
              title: const Text('Project Document'),
              subtitle: const Text('PDF - 2.5 MB'),
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(FontAwesomeIcons.image, size: 16),
              ),
              title: const Text('Project Images'),
              subtitle: const Text('12 items'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ExpandableListTile(
          title: 'Team Members',
          subtitle: '5 members',
          leading: FontAwesomeIcons.users,
          initiallyExpanded: true,
          children: [
            ListTile(
              leading: const CircleAvatar(
                child: Text('JD'),
              ),
              title: const Text('John Doe'),
              subtitle: const Text('Project Manager'),
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.green,
                child: Text('AS'),
              ),
              title: const Text('Alice Smith'),
              subtitle: const Text('Developer'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReorderableListExamples(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reorderable List Items',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ReorderableListItem(
          onReorder: () {},
          isFirst: true,
          child: const ListTile(
            leading: Icon(FontAwesomeIcons.listCheck),
            title: Text('High Priority Task'),
            subtitle: Text('Due tomorrow'),
          ),
        ),
        const SizedBox(height: 8),
        ReorderableListItem(
          child: const ListTile(
            leading: Icon(FontAwesomeIcons.listCheck),
            title: Text('Medium Priority Task'),
            subtitle: Text('Due next week'),
          ),
          onReorder: () {},
        ),
        const SizedBox(height: 8),
        ReorderableListItem(
          onReorder: () {},
          isLast: true,
          child: const ListTile(
            leading: Icon(FontAwesomeIcons.listCheck),
            title: Text('Low Priority Task'),
            subtitle: Text('Due next month'),
          ),
        ),
      ],
    );
  }

  Widget buildOverlayExamples(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Toast Examples
        const Text('Toast Messages:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                ToastOverlay.show(
                  context: context,
                  message: 'Success Toast',
                  icon: FontAwesomeIcons.check,
                  backgroundColor: Colors.green,
                );
              },
              icon: const Icon(FontAwesomeIcons.check),
              label: const Text('Success Toast'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                ToastOverlay.show(
                  context: context,
                  message: 'Error Toast',
                  icon: FontAwesomeIcons.xmark,
                  backgroundColor: Colors.red,
                );
              },
              icon: const Icon(FontAwesomeIcons.xmark),
              label: const Text('Error Toast'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                ToastOverlay.show(
                  context: context,
                  message: 'Info Toast',
                  icon: FontAwesomeIcons.info,
                  backgroundColor: Colors.blue,
                );
              },
              icon: const Icon(FontAwesomeIcons.info),
              label: const Text('Info Toast'),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Dialog Examples
        const Text('Dialogs:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: () {
                StyledDialog.show(
                  context: context,
                  title: 'Success Dialog',
                  message: 'Operation completed successfully!',
                  icon: FontAwesomeIcons.check,
                  iconColor: Colors.green,
                  actions: [
                    DialogAction(
                      label: 'OK',
                      onPressed: () => Navigator.pop(context),
                      isPrimary: true,
                    ),
                  ],
                );
              },
              child: const Text('Show Success Dialog'),
            ),
            ElevatedButton(
              onPressed: () {
                StyledDialog.show(
                  context: context,
                  title: 'Confirm Action',
                  message: 'Are you sure you want to proceed?',
                  icon: FontAwesomeIcons.question,
                  iconColor: Colors.orange,
                  actions: [
                    DialogAction(
                      label: 'Cancel',
                      onPressed: () => Navigator.pop(context),
                    ),
                    DialogAction(
                      label: 'Confirm',
                      onPressed: () => Navigator.pop(context),
                      isPrimary: true,
                    ),
                  ],
                );
              },
              child: const Text('Show Confirm Dialog'),
            ),
            ElevatedButton(
              onPressed: () {
                StyledDialog.show(
                  context: context,
                  title: 'Delete Item',
                  message: 'This action cannot be undone.',
                  icon: FontAwesomeIcons.trash,
                  iconColor: Colors.red,
                  actions: [
                    DialogAction(
                      label: 'Cancel',
                      onPressed: () => Navigator.pop(context),
                    ),
                    DialogAction(
                      label: 'Delete',
                      onPressed: () => Navigator.pop(context),
                      isDestructive: true,
                    ),
                  ],
                );
              },
              child: const Text('Show Delete Dialog'),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Bottom Sheet Examples
        const Text('Bottom Sheets:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: () {
                StyledBottomSheet.show(
                  context: context,
                  title: 'Bottom Sheet Title',
                  message: 'This is a sample bottom sheet with some content.',
                  content: Column(
                    children: [
                      ListTile(
                        leading: const Icon(FontAwesomeIcons.image),
                        title: const Text('Gallery'),
                        onTap: () => Navigator.pop(context),
                      ),
                      ListTile(
                        leading: const Icon(FontAwesomeIcons.camera),
                        title: const Text('Camera'),
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Show Bottom Sheet'),
            ),
            ElevatedButton(
              onPressed: () {
                ActionSheet.show(
                  context: context,
                  actions: [
                    ActionSheetItem(
                      label: 'Share',
                      icon: FontAwesomeIcons.share,
                      onPressed: () {},
                    ),
                    ActionSheetItem(
                      label: 'Edit',
                      icon: FontAwesomeIcons.pen,
                      onPressed: () {},
                    ),
                    ActionSheetItem(
                      label: 'Delete',
                      icon: FontAwesomeIcons.trash,
                      onPressed: () {},
                      isDestructive: true,
                    ),
                  ],
                  cancelLabel: 'Cancel',
                );
              },
              child: const Text('Show Action Sheet'),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Loading Overlay Example
        const Text('Loading Overlay:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            LoadingOverlay.show(
              context: context,
              message: 'Loading...',
            );
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pop(context);
            });
          },
          child: const Text('Show Loading Overlay'),
        ),
        const SizedBox(height: 24),

        // Popover Menu Example
        const Text('Popover Menu:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        buildPopoverExample()
      ],
    );
  }

  Widget buildPopoverExample() {
    return Center(
      child: PopoverMenu(
        items: [
          PopoverMenuItem(
            label: 'View Profile',
            icon: FontAwesomeIcons.user,
            onTap: () {
              print('View Profile tapped');
            },
          ),
          PopoverMenuItem(
            label: 'Settings',
            icon: FontAwesomeIcons.gear,
            onTap: () {
              print('Settings tapped');
            },
          ),
          PopoverMenuItem(
            label: 'Share',
            icon: FontAwesomeIcons.share,
            onTap: () {
              print('Share tapped');
            },
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'New',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          PopoverMenuItem(
            label: 'Delete',
            icon: FontAwesomeIcons.trash,
            onTap: () {
              print('Delete tapped');
            },
            isDestructive: true,
          ),
        ],
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: Theme.of(context).colorScheme.onSecondary,
          ),
          onPressed: null, // The onPressed is handled by PopoverMenu
          icon: const Icon(FontAwesomeIcons.ellipsisVertical),
          label: const Text('Show Popover'),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tr('Alert')),
        content: Text(tr('This is an alert dialog.')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(tr('OK')),
          ),
        ],
      ),
    );
  }

  void _showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tr('Confirm')),
        content: Text(tr('Are you sure you want to proceed?')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(tr('Cancel')),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: Text(tr('Confirm')),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              tr('Bottom Sheet'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(tr('This is a bottom sheet dialog.')),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(tr('Close')),
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  FontAwesomeIcons.check,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                tr('Success!'),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                tr('Your action was completed successfully.'),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(tr('Continue')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Widgets
class _WidgetSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _WidgetSection({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Icon(icon, size: 20, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ...children,
        const SizedBox(height: 16),
        const Divider(),
      ],
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String label;
  final String placeholder;
  final bool isPassword;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  const _CustomTextField({
    required this.label,
    required this.placeholder,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  // Continuing from _CustomTextField...

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: placeholder,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20) : null,
            suffixIcon: suffixIcon != null ? Icon(suffixIcon, size: 20) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CustomDropdown extends StatefulWidget {
  final String label;
  final List<String> items;

  const _CustomDropdown({
    required this.label,
    required this.items,
  });

  @override
  State<_CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<_CustomDropdown> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              value: _selectedValue,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                border: InputBorder.none,
              ),
              items: widget.items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedValue = value);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _CustomCheckbox extends StatefulWidget {
  final String label;

  const _CustomCheckbox({required this.label});

  @override
  State<_CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<_CustomCheckbox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(widget.label),
      leading: Checkbox(
        value: _isChecked,
        onChanged: (value) => setState(() => _isChecked = value!),
      ),
    );
  }
}

class _CustomSwitch extends StatefulWidget {
  final String label;

  const _CustomSwitch({required this.label});

  @override
  State<_CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<_CustomSwitch> {
  bool _isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(widget.label),
      trailing: Switch(
        value: _isEnabled,
        onChanged: (value) => setState(() => _isEnabled = value),
      ),
    );
  }
}

class _CustomRadioGroup extends StatefulWidget {
  final String label;
  final List<String> options;

  const _CustomRadioGroup({
    required this.label,
    required this.options,
  });

  @override
  State<_CustomRadioGroup> createState() => _CustomRadioGroupState();
}

class _CustomRadioGroupState extends State<_CustomRadioGroup> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        ...widget.options.map((option) {
          return RadioListTile<String>(
            contentPadding: EdgeInsets.zero,
            title: Text(option),
            value: option,
            groupValue: _selectedOption,
            onChanged: (value) => setState(() => _selectedOption = value),
          );
        }),
      ],
    );
  }
}

class _CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String content;

  const _CustomCard({
    required this.title,
    required this.subtitle,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 12),
            Text(content),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(tr('Cancel')),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () {},
                  child: Text(tr('Action')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final IconData leading;
  final String title;
  final String subtitle;
  final Widget? trailing;

  const _CustomListTile({
    required this.leading,
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            leading,
            size: 20,
            color: theme.colorScheme.primary,
          ),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: trailing,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class _CustomProgressBar extends StatelessWidget {
  final String label;
  final double value;

  const _CustomProgressBar({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${(value * 100).toInt()}%',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 8,
            backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
          ),
        ),
      ],
    );
  }
}
