import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static final SupabaseClient _supabase = Supabase.instance.client;

  // Signup: cria no auth e insere na tabela usuarios
  static Future<AuthResponse> signUp(
    String username,
    String email,
    String password,
  ) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
    );

    final user = response.user;

    if (user != null) {
      try {
        final existingUser =
            await _supabase
                .from('usuarios')
                .select('id')
                .eq('user_name', username)
                .maybeSingle();

        if (existingUser != null) {
          await _supabase.auth.admin.deleteUser(user.id);
          throw Exception("Nome de usuário já existe.");
        }

        await _supabase.from('usuarios').insert({
          'id': user.id,
          'user_name': username,
          'email': email,
        });
      } catch (e) {
        await _supabase.auth.admin.deleteUser(user.id);
        throw Exception("Erro ao salvar dados do usuário: $e");
      }
    }

    return response;
  }

  // Login por username — busca email e depois autentica
  static Future<AuthResponse> signInWithUsername(
    String username,
    String password,
  ) async {
    // Busca o email do usuário, a policy permite isso
    final response =
        await _supabase
            .from('usuarios')
            .select('email')
            .eq('user_name', username)
            .maybeSingle();

    if (response == null || response['email'] == null) {
      throw Exception("Usuário '$username' não encontrado.");
    }

    final email = response['email'];

    final authResponse = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (authResponse.user == null) {
      throw Exception("Email ou senha incorretos.");
    }

    return authResponse;
  }

  // Logout
  static Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  static User? get currentUser => _supabase.auth.currentUser;
}
