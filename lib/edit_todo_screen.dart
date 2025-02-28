import 'package:flutter/material.dart';
import 'package:taskly/main_screen.dart';
import 'package:taskly/models/toDoModel.dart';

class EditTodoScreen extends StatefulWidget {
  const EditTodoScreen({super.key, required this.todoModel});

  final TodoModel todoModel;

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  late TodoColor _selectedColor;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.todoModel.color;
    _titleController = TextEditingController(text: widget.todoModel.title);
    _descriptionController = TextEditingController(text: widget.todoModel.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Details", 
          style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_rounded),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('TITLE', 
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              style: Theme.of(context).textTheme.titleMedium,
              maxLength: 50,
              decoration: InputDecoration(
                hintText: "Enter task title...",
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 24),
            const Text('COLOR LABEL',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            _ColorSelector(
              selectedColor: _selectedColor,
              onColorSelected: (color) => setState(() => _selectedColor = color),
            ),
            const SizedBox(height: 24),
            const Text('DESCRIPTION',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _descriptionController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: "Add detailed description...",
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saveTask,
        icon: const Icon(Icons.save_rounded),
        label: const Text("Save Task"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 2,
      ),
    );
  }

  void _saveTask() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.error_outline_rounded, color: Colors.white),
              SizedBox(width: 12),
              Text("Title is required"),
            ],
          ),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    }

    widget.todoModel
      ..title = _titleController.text.trim()
      ..description = _descriptionController.text.trim()
      ..color = _selectedColor;

    widget.todoModel.isInBox ? widget.todoModel.save() : box.add(widget.todoModel);
    Navigator.pop(context);
  }
}

class _ColorSelector extends StatelessWidget {
  final TodoColor selectedColor;
  final Function(TodoColor) onColorSelected;

  const _ColorSelector({
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: TodoColor.values.map((color) {
        final isSelected = color == selectedColor;
        return GestureDetector(
          onTap: () => onColorSelected(color),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2)
                  : null,
            ),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Color(color.code),
                shape: BoxShape.circle,
              ),
              child: isSelected
                  ? Icon(Icons.check_rounded,
                      size: 20, color: Colors.white)
                  : null,
            ),
          ),
        );
      }).toList(),
    );
  }
}