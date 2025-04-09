
![image](https://github.com/user-attachments/assets/775b5c1f-8298-4736-942b-4e6b160760d8)

<h1 align="center">
 Teste Técnico Mottu
</h1>

<div><a href="https://git.io/typing-svg"><a href="https://git.io/typing-svg"><img src="https://readme-typing-svg.herokuapp.com?font=&size=18&duration=3000&pause=1000&color=F7F7F7&width=400&lines=Ol%C3%A1!+Bem+vindo+ao+meu+projeto+%F0%9F%91%8B" alt="Typing SVG" /></a></div>
Este aplicativo tem como objetivo ajudar os usuários a encontrarem e visualizarem detalhes sobre seus Pokémon favoritos. Através dele, é possível acessar informações completas, como tipo, habilidades, e outras características importantes de cada Pokémon. 
<div >&nbsp;</div>


https://github.com/user-attachments/assets/7dc1ae07-2a34-4db0-b715-c8aae7ee00f0


# 💉 Gerenciador de Estado e Injetor de Dependências
Pokedex utiliza [GetX](https://pub.dev/packages/get) como gerenciador de estado, sendo uma solução leve e rápida para Flutter, que permite criar um projeto organizado e com código limpo.
<div >&nbsp;</div>

![Screen_Recording_20250409_121342](https://github.com/user-attachments/assets/c7d88fca-19d8-4e4f-871d-cdca2428db66)

# :rocket: Requisições Http
O app ultiliza o package [Dio](https://pub.dev/packages/dio) para realizar todas as requisições de forma simples e eficiente. O Dio oferece diversas funcionalidades de alto nível, como interceptadores, formatação automática de JSON, cancelamento de requisições e suporte completo a requisições assíncronas, tornando o processo de comunicação com a API mais ágil e robusto.
<div >&nbsp;</div>

![Screen_Recording_20250409_122016](https://github.com/user-attachments/assets/e178acdd-0f72-4532-a994-7e1d75803a8c)

# :file_folder: Cache
O app ultiliza o package  [Hive](https://pub.dev/packages/hive) como banco de dados para armanezar dados do cache, Hive é um banco de dados não relacional leve e extremamente rápido, escrito inteiramente em Dart. Ele é ideal para armazenar dados localmente de forma eficiente, oferecendo excelente desempenho mesmo em dispositivos com recursos limitados.
<div >&nbsp;</div>

![image](https://github.com/user-attachments/assets/ebc0c353-a5f4-4e92-a337-53ba3dc4f58c)

# ✨ Arquitetura Limpa
O projeto segue os princípios da Arquitetura Limpa (Clean Architecture), com o objetivo de manter o código bem organizado, modular e de fácil manutenção. Essa abordagem separa claramente as responsabilidades em camadas — como domain, infrastucture e application — permitindo que as regras de negócio fiquem independentes de frameworks, interfaces e detalhes de implementação.
Dessa forma, é possível escalar o projeto com mais segurança, facilitar os testes e promover maior reutilização de código entre diferentes partes da aplicação.
<div >&nbsp;</div>

![image](https://github.com/user-attachments/assets/e4af733c-5253-42b0-aeba-85d8d394bd35)


# 👨‍💻 Como Rodar o Projeto

É necessário ter [Flutter](https://flutter.dev/) e [Android Studio](https://developer.android.com/studio?hl=pt-br) instalados e configurados corretamente.

1 - Clonar o repositório.
```shell
git clone https://github.com/jpDEVsekiro/im-mottu-mobile.git
```

2 - Abrir o projeto no Android Studio.

3 - Rodar `flutter pub get` no terminal.
```shell
flutter pub get
```

4 - Rodar o projeto.
```shell
flutter run
```

# </> Como Rodar os Testes

Para rodar os [testes unitários](https://docs.flutter.dev/cookbook/testing/unit/introduction) é necessário rodar o comando `flutter test` no terminal.
```shell
flutter test
```
<div >&nbsp;</div>

![im-mottu-mobile – pokemon_details_use_case_test dart 2025-04-09 12-47-47](https://github.com/user-attachments/assets/f4601d1f-1743-409e-91c6-18eccc54a2dc)

Para rodar os [testes de integração](https://docs.flutter.dev/testing/integration-tests) é necessário rodar o comando `flutter test integration_test/all_integration_test.dart` no terminal.
```shell
flutter test integration_test/all_integration_test.dart
```
<div >&nbsp;</div>

https://github.com/user-attachments/assets/60d170de-e77f-4050-8b41-02cd7f52d58c

