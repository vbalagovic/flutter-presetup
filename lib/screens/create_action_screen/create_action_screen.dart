import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateActionScreen extends ConsumerStatefulWidget {
  const CreateActionScreen({super.key});

  @override
  ConsumerState<CreateActionScreen> createState() => _CreateActionScreenState();
}

class _CreateActionScreenState extends ConsumerState<CreateActionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedPriority = 'Medium';
  final List<String> _selectedTags = [];

  final _priorityOptions = ['Low', 'Medium', 'High'];
  final _tagOptions = [
    'Work',
    'Personal',
    'Shopping',
    'Health',
    'Family',
    'Study',
    'Travel'
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Add your form submission logic here
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('Create New Task'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.xmark),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton.icon(
            onPressed: _submitForm,
            icon: const Icon(FontAwesomeIcons.check, size: 18),
            label: Text(tr('Save')),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Input
                _FormField(
                  title: tr('Task Title'),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: tr('Enter task title'),
                      prefixIcon:
                          const Icon(FontAwesomeIcons.noteSticky, size: 20),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return tr('Please enter a title');
                      }
                      return null;
                    },
                  ),
                ),

                // Description Input
                _FormField(
                  title: tr('Description'),
                  child: TextFormField(
                    controller: _descriptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: tr('Enter task description'),
                      alignLabelWithHint: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 84),
                        child: const Icon(FontAwesomeIcons.paragraph, size: 20),
                      ),
                    ),
                  ),
                ),

                // Due Date Picker
                _FormField(
                  title: tr('Due Date'),
                  child: InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) {
                        setState(() => _selectedDate = picked);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.outline.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(FontAwesomeIcons.calendar, size: 20),
                          const SizedBox(width: 12),
                          Text(
                            _selectedDate != null
                                ? DateFormat.yMMMd().format(_selectedDate!)
                                : tr('Select due date'),
                            style: _selectedDate == null
                                ? theme.textTheme.bodyLarge?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.5),
                                  )
                                : theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Priority Selection
                _FormField(
                  title: tr('Priority'),
                  child: Row(
                    children: _priorityOptions.map((priority) {
                      final isSelected = _selectedPriority == priority;
                      final color = priority == 'High'
                          ? Colors.red
                          : priority == 'Medium'
                              ? Colors.orange
                              : Colors.green;

                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: InkWell(
                            onTap: () =>
                                setState(() => _selectedPriority = priority),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color:
                                    isSelected ? color.withOpacity(0.1) : null,
                                border: Border.all(
                                  color: isSelected
                                      ? color
                                      : theme.colorScheme.outline
                                          .withOpacity(0.2),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.flag,
                                    size: 16,
                                    color: isSelected
                                        ? color
                                        : theme.colorScheme.onSurface
                                            .withOpacity(0.5),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    priority,
                                    style: TextStyle(
                                      color: isSelected
                                          ? color
                                          : theme.colorScheme.onSurface,
                                      fontWeight:
                                          isSelected ? FontWeight.w600 : null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                // Tags Selection
                _FormField(
                  title: tr('Tags'),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _tagOptions.map((tag) {
                      final isSelected = _selectedTags.contains(tag);
                      return FilterChip(
                        label: Text(tag),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedTags.add(tag);
                            } else {
                              _selectedTags.remove(tag);
                            }
                          });
                        },
                        backgroundColor: theme.colorScheme.surface,
                        selectedColor:
                            theme.colorScheme.primary.withOpacity(0.1),
                        checkmarkColor: theme.colorScheme.primary,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurface,
                          fontWeight: isSelected ? FontWeight.w600 : null,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                      );
                    }).toList(),
                  ),
                ),

                // Attachments Section (Optional)
                _FormField(
                  title: tr('Attachments'),
                  child: InkWell(
                    onTap: () {
                      // Add attachment logic
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.outline.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: theme.colorScheme.surface,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.paperclip,
                            size: 20,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            tr('Add attachments'),
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
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

class _FormField extends StatelessWidget {
  final String title;
  final Widget child;

  const _FormField({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
