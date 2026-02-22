import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/meal_model.dart';

class SupaBaseService {
  final supabase = Supabase.instance.client;

  Future signUp(String email, String password) async {
    await supabase.auth.signUp(email: email, password: password);
  }

  Future logIn(String email, String password) async {
    await supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future logOut() async {
    await supabase.auth.signOut();
  }

  Future resetPassword(String email) async {
    await supabase.auth.resetPasswordForEmail(
      email,
      redirectTo: 'io.supabase.calowise://reset-callback/',
    );
  }

  Future updatePassword(String newPassword) async {
    await supabase.auth.updateUser(UserAttributes(password: newPassword));
  }

  Future<List<Meal>> getMeals() async {
    final userId = supabase.auth.currentUser!.id;
    final response = await supabase
        .from('meals')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List).map((data) => Meal.fromJson(data)).toList();
  }

  Future addMeal(String name, int calories) async {
    final userId = supabase.auth.currentUser!.id;
    await supabase.from('meals').insert({
      'user_id': userId,
      'name': name,
      'calories': calories,
    });
  }

  Future deleteMeal(String id) async {
    await supabase.from('meals').delete().eq('id', id);
  }
}
