import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:flutter_application_1/models/champion.dart';
import 'package:flutter_application_1/services/api_service.dart';

/// Testes SEM internet: o MockClient finge ser o Data Dragon.
/// Rode com:  flutter test
void main() {
  final championJson = {
    'version': '14.1.1',
    'id': 'LeeSin',
    'name': 'Lee Sin',
    'title': 'o Monge Cego',
    'blurb': 'Texto de teste',
    'tags': ['Fighter', 'Assassin'],
    'info': {'attack': 8, 'defense': 5, 'magic': 3, 'difficulty': 6},
  };

  test('fromJson usa id nas URLs e valores padrão quando faltam campos', () {
    final c = Champion.fromJson(championJson);
    expect(c.name, 'Lee Sin');
    expect(c.tags, ['Fighter', 'Assassin']);
    expect(c.difficulty, 6);
    expect(c.imageUrl,
        'https://ddragon.leagueoflegends.com/cdn/14.1.1/img/champion/LeeSin.png');

    final vazio = Champion.fromJson({});
    expect(vazio.name, 'Nome não disponível');
    expect(vazio.attack, 0);
  });

  test('fetchChampions lê versions.json e transforma o mapa data em lista',
      () async {
    final client = MockClient((request) async {
      if (request.url.path.endsWith('versions.json')) {
        return http.Response(jsonEncode(['14.1.1', '13.24.1']), 200);
      }
      expect(request.url.path, '/cdn/14.1.1/data/pt_BR/champion.json');
      return http.Response.bytes(
        utf8.encode(jsonEncode({
          'data': {'LeeSin': championJson}
        })),
        200,
      );
    });

    final champions = await ApiService(client: client).fetchChampions();
    expect(champions.single.title, 'o Monge Cego');
  });

  test('status diferente de 200 vira ApiException', () async {
    final client = MockClient((_) async => http.Response('erro', 500));
    await expectLater(
      ApiService(client: client).fetchChampions(),
      throwsA(isA<ApiException>()),
    );
  });
}
