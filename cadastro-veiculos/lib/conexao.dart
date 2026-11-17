import 'package:dotenv/dotenv.dart';
import 'package:supabase/supabase.dart';

SupabaseClient conectar() {
 var env = DotEnv()..load();

 String? url = env['SUPABASE_URL'];
 String? chave = env['SUPABASE_PUBLISHABLE_KEY'];

 if (url == null || chave == null) {
   throw Exception('Erro: verifique o arquivo .env');
 }
 return SupabaseClient(url, chave);
}