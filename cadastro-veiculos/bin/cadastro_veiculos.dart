import 'dart:io';
import '../lib/conexao.dart';
import '../lib/veiculos.dart';


String lerTexto(String mensagem, int limite) {
  stdout.write(mensagem);
  String texto = stdin.readLineSync()?.trim() ?? '';
  if (texto.isEmpty) {
    throw FormatException('O campo não pode ficar vazio.');
  }
  if (texto.length > limite) {
    throw FormatException('Limite de $limite caracteres.');
  }
  return texto;
}

int lerInteiro(String mensagem, int minimo) {
  stdout.write(mensagem);
  String texto = stdin.readLineSync()?.trim() ?? '';
  int? numero = int.tryParse(texto);
  if (numero == null || numero < minimo) {
    throw FormatException('Digite um número inteiro válido.');
  }
  return numero;
}

int lerAno(String mensagem) {
  int ano = lerInteiro(mensagem, 1900);
  if (ano > DateTime.now().year + 1) {
    throw FormatException('Ano fora do limite permitido.');
  }
  return ano;
}

double lerValor(String mensagem) {
  stdout.write(mensagem);
  String texto = stdin.readLineSync()?.trim() ?? '';
  RegExp formato = RegExp(r'^\d+([.,]\d{1,2})?$');
  if (!formato.hasMatch(texto)) {
    throw FormatException('Digite um valor com até duas casas decimais.');
  }
  double? valor = double.tryParse(
    texto.replaceAll(',', '.'),
  );

  if (valor == null ||
    !valor.isFinite ||
     valor <= 0 ||
     valor >= 10000000000) {

    throw FormatException('Valor inválido.');

  }
  return valor;
}

void mostrarVeiculo(Map<String, dynamic> veiculo) {
  double valor = double.parse(veiculo['valor'].toString());
  print('ID: ${veiculo['id']}');
  print('Marca: ${veiculo['marca']}');
  print('Modelo: ${veiculo['modelo']}');
  print('Ano: ${veiculo['ano']}');
  print('Valor: R\$ ${valor.toStringAsFixed(2)}');
  print('Quilometragem: ${veiculo['quilometragem']} km');
  print('------------------------------');

}

Future<void> main() async {
  final cliente = conectar();
  try {
    while (true) {
      print('\n===== CADASTRO DE VEÍCULOS =====');
      print('1 - Cadastrar veículo');
      print('2 - Listar veículos');
      print('3 - Atualizar veículo');
      print('4 - Excluir veículo');
      print('0 - Sair');
      stdout.write('O que deseja fazer? ');
      String opcao = stdin.readLineSync()?.trim() ?? '';

      if (opcao == '0') {
        print('Sistema encerrado.');
        break;
      }
      try {
        switch (opcao) {
          case '1':
            print('\n--- CADASTRAR VEÍCULO ---');
            String marca = lerTexto('Marca: ', 50);
            String modelo = lerTexto('Modelo: ', 100);
            int ano = lerAno('Ano: ');
            double valor = lerValor('Valor: ');
            int km = lerInteiro('Quilometragem: ', 0);

            final veiculo = await cadastrarVeiculo(
              cliente, marca, modelo, ano, valor, km,
            );
            print('\nVeículo cadastrado!');
            mostrarVeiculo(veiculo);
            break;

          case '2':
            print('\n--- LISTA DE VEÍCULOS ---');
            final veiculos = await listarVeiculos(cliente);

            if (veiculos.isEmpty) {
              print('Nenhum veículo cadastrado.');

            } else {

              for (var veiculo in veiculos) {
                mostrarVeiculo(veiculo);

              }

            }

            break;
          case '3':
            print('\n--- ATUALIZAR VEÍCULO ---');
            int id = lerInteiro('ID do veículo: ', 1);
            print('Digite todos os novos dados:');
            String marca = lerTexto('Nova marca: ', 50);
            String modelo = lerTexto('Novo modelo: ', 100);
            int ano = lerAno('Novo ano: ');
            double valor = lerValor('Novo valor: ');
            int km = lerInteiro('Nova quilometragem: ', 0);

            final veiculo = await atualizarVeiculo(

              cliente, id, marca, modelo, ano, valor, km,

            );

            if (veiculo == null) {
              print('Veículo não encontrado.');
            } else {
              print('\nVeículo atualizado!');
              mostrarVeiculo(veiculo);
            }
            break;

          case '4':
            print('\n--- EXCLUIR VEÍCULO ---');
            int id = lerInteiro('ID do veículo: ', 1);
            stdout.write('Confirma a exclusão? S/N: ');
            String resposta =
                stdin.readLineSync()?.trim().toUpperCase() ?? '';
            if (resposta == 'S') {
              final veiculo = await excluirVeiculo(cliente, id);
              if (veiculo == null) {
                print('Veículo não encontrado.');
              } else {
                print('Veículo excluído!');
                mostrarVeiculo(veiculo);
              }
            } else if (resposta == 'N') {
              print('Exclusão cancelada.');
            } else {
              print('Resposta inválida. Exclusão não realizada.');
            }
            break;
          default:
            print('Opção inválida. Tente novamente.');

        }
      } on FormatException catch (erro) {
        print('Entrada inválida: ${erro.message}');
      } catch (erro) {
        print('Erro ao realizar operação: $erro');
      }

    }

  } finally {

    cliente.dispose();

  }

}