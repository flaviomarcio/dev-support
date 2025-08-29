# Configuração do Docker

Neste documento existem informações de como instalar alguns utilitários no seu linux, como wslcli, editores, formatadores e utilitários

[Pagina principal](./README.md)

## Pré Requisitos
- Ferramentas
    - WSL ou Linux baseado em debian
        - WSL
            - [Install](https://learn.microsoft.com/pt-br/windows/wsl/install)
            - [Configure](https://learn.microsoft.com/en-us/windows/wsl/wsl-config)
        - [Debian](https://www.debian.org/)
        - [Ubuntu](https://ubuntu.com/)
        - [Mint](https://linuxmint.com/)
    - [Docker](https://docs.docker.com/engine/install/debian/)


## Instalação completa
```bash
sudo apt install -y mcedit jq zip tar wget 
```

## Instalação individual

- mcedit
    
    Alternativa eficiente ai **nano** e **vi**
    ```bash
    sudo apt install -y mcedit
    ```

- zip e tar
    
    Utilitário para compatação e descompatação de arquivos e pastas
    ```bash
    sudo apt install -y zip tar
    ```


- jq e yq
    
    Utilitário de formatação e consulta de JSON | YAML
    ```bash
    sudo apt install -y jq
    ```