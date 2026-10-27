# Campeões de League of Legends

Aplicativo Flutter baseado no material do professor. Lista campeões da API Data Dragon em português, com busca por nome, atualização da lista, tela de detalhes, atributos e imagens.

## Executar

Com o Flutter instalado (Dart >=3.8.0 e <4.0.0), execute na pasta deste projeto:

```sh
flutter pub get
flutter analyze
flutter test
flutter run
```

Para executar no Chrome:

```sh
flutter run -d chrome
```

O aplicativo precisa de internet para carregar os campeões e suas imagens. Os testes da API usam MockClient e não fazem chamadas de rede.

## Windows: dubious ownership no SDK

Se o Flutter instalado em `C:/Dev/flutter` pertencer ao grupo Administradores e o Git bloquear esse SDK, execute com seu usuário normal:

```sh
git config --global --add safe.directory C:/Dev/flutter
flutter doctor
```

Essa configuração é local ao computador; baixar o repositório não a aplica.

## Organização

- `lib/models`: modelo Champion.
- `lib/services`: consultas HTTP ao Data Dragon.
- `lib/screens`: lista e detalhes.
- `lib/widgets`: componentes visuais.
- `lib/theme`: tema Hextech.
- `lib/data`: dados de exemplo.
- `test/api_service_test.dart`: testes do modelo e da API.

League of Legends e o conteúdo do Data Dragon pertencem à Riot Games. Uso educacional.
