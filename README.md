*Cadastro de Veículos*

Projeto desenvolvido em Dart com integração ao Supabase, com o objetivo de realizar o cadastro e o gerenciamento de veículos de uma concessionária.
Funcionalidades

*O sistema permite realizar quatro operações básicas:*

Cadastrar: adicionar um veículo ao banco de dados.
Listar: consultar os veículos cadastrados.
Atualizar: alterar os dados de um veículo pelo ID.
Excluir: remover um veículo mediante confirmação.

*Tecnologias utilizadas*

Dart
Supabase
PostgreSQL
Pacotes supabase e dotenv

*Estrutura do projeto*

bin/main.dart: menu principal e interação com o usuário.
lib/conexao.dart: conexão com o Supabase.
lib/veiculos.dart: funções responsáveis pelo CRUD.

*Configuração da conexão*

Primeiro, é necessário criar um projeto no Supabase e configurar a tabela veiculos com os campos id, marca, modelo, ano, valor e quilometragem.
Na pasta principal do projeto, crie um arquivo .env com as seguintes informações:
SUPABASE_URL=https://seu-projeto.supabase.co
SUPABASE_PUBLISHABLE_KEY=sua_chave_publicavel
Substitua os exemplos pela URL e pela chave publicável do seu projeto Supabase.
O arquivo .env não deve ser enviado ao GitHub. Também é necessário configurar as permissões de acesso à tabela no Supabase.

*Como executar*

Com o Dart SDK instalado, abra o terminal na pasta principal do projeto e execute:
dart pub get
dart run bin/main.dart

*Funcionamento*

O programa apresenta um menu com as opções de cadastrar, listar, atualizar e excluir veículos. Todas as operações podem ser realizadas sem reiniciar o sistema.
As informações ficam armazenadas no banco de dados Supabase, permitindo consultar os registros mesmo depois de encerrar o programa.

*Objetivo*

Praticar os conceitos básicos da linguagem Dart, estruturas de repetição e decisão, funções, validação de dados e integração com banco de dados por meio das operações CRUD.
