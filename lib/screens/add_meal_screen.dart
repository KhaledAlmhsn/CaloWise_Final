import 'package:flutter/material.dart';
import '../services/supabase_service.dart';
import '../widgets/custom_textfield.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final nameController = TextEditingController();
  final caloriesController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    caloriesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.blue),
        title: Image.asset('assets/images/logo_notext.png', height: 35),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomTextField(
              controller: nameController,
              hintText: 'Meal Name (e.g. Apple)',
              icon: Icons.fastfood,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: caloriesController,
              hintText: 'Calories',
              icon: Icons.local_fire_department,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      if (nameController.text.isEmpty ||
                          caloriesController.text.isEmpty)
                        return;
                      setState(() => isLoading = true);
                      try {
                        await SupaBaseService().addMeal(
                          nameController.text.trim(),
                          int.parse(caloriesController.text.trim()),
                        );
                        if (context.mounted) Navigator.pop(context);
                      } catch (e) {
                        setState(() => isLoading = false);
                        if (context.mounted) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text('Error: $e')));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(200, 50),
                    ),
                    child: const Text(
                      "SAVE MEAL",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
