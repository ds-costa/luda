# Luda Language

Análisador léxico e sintático para linguagem prova de conceito Luda.

## Requisitos (Pacotes)

* Flex (Fast Lexical Analyzer Generator)
* GNU Make
* GCC

## Instalação de pacotes

Projeto compatível com sistemas operacionais baseados em unix. Insira os seguintes comandos em seu terminal para a instalação das dependências.

* Flex
```bash
 sudo apt install flex
```
* Make
```bash
 sudo apt install make
```
* GCC
```bash
 sudo apt install gcc
```

## Executando o projeto

* Crie um arquivo de entrada com a extensão .luda no diretório src/ ou utilize o arquivo de exemplo src/sample.luda e o especifique no argumento input:
```bash
 make -f lexer/makefile input=src/sample.luda 
```

## Solução de problemas

* Caso o compilador gcc apresente problemas para compilar o análisador léxico, realize os seguintes passos:
    - Instale o pacote build-essential
```bash
 sudo apt install build-essential
```

## Contribuidores

* David Costa - [ds.costa@unesp.br](mailto:ds.costa@unesp.br)

## License

This project is licensed under the MIT GENERAL PUBLIC LICENSE - see the [LICENSE](LICENSE) file for more details.

**Open Source Software** Hell Yeah!!! ヽ(・∀・)ﾉ