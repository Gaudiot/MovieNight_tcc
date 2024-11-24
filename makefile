# Makefile para projeto Flutter

.PHONY: pub-get pub-update gen

# Comando para obter as dependências do Flutter
pub-get:
	flutter pub get

# Comando para atualizar os pacotes para a última versão
pub-update:
	flutter pub upgrade

# Comando para gerar código (por exemplo, para arquivos .g.dart)
gen:
	flutter pub run build_runner build --delete-conflicting-outputs