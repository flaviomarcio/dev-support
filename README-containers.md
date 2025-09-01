# Configuração dos containers
Neste docuemnto existem informações de como instalar ferramentas essenciais e deploy das aplicações

[Pagina principal](./README.md)

## Instalação assistida

1. Clone e Execução
    ```bash
    #Clonando este repositório
    git clone git@github.com:flaviomarcio/dev-support.git

    #Execute o configurador usando
    ./run
    
    #Ou
    
    #Execute o configurador em modo debug
    ./run -d 
    # ou
    ./run --debug 
    ```

2. Opções
    - Usando menu
        ```bash
        Deploy util

        1) Quit                 # Fecha o configurador  
        2) Services             # Instala serviços essenciais
        3) Components           # Builda e faz o deploy dos componentes
        4) Postgres-Update      # Atualiza o script no postgres
        5) Info                 # Exibi informações sobre serviços

        Selecione uma opção para instalação: 1 #Digite aqui a opção
        ```
    - Usando argumentos
        ```bash
        Options
            - ./run.sh --selector        #Para exibir menu de opções
            - ./run.sh --services        #Para serviços necessários
            - ./run.sh --components      #Para deploy dos componentes do sistema
            - ./run.sh --postgres-update #Para atualização do postgres
            - ./run.sh --print-info      #Para exibir informações e comandos
        ```

## Instalação manual
```bash
git clone git@github.com:flaviomarcio/dev-support.git
cd ./docker

#carrege algumas variaveis necessárias
source ./lib-envs.sh

#builda imagens e prepara os containers para execução
docker compose up -d;

#destroy os containers
docker compose down;
```
