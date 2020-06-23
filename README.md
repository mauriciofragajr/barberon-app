# BarberOn

Um aplicativo para barbearias.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)


## Gerenciamento de estado

Para gerenciamento de estado, utilizei o [Mobx](https://mobx.netlify.app/getting-started).

Para gerar o código do Mobx

```
flutter packages pub run build_runner build
```

Para gerar e ficar escurando as alterações

```
flutter packages pub run build_runner watch
```

Para limpar os conflitos enquanto escuta

```
flutter packages pub run build_runner watch --delete-conflicting-outputs

```