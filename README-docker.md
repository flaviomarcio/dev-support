# Configuração do Docker

Neste documento existe informações de como configura o ambiente docker

[Pagina principal](./README.md)

## Pré Requisitos
- Ferramentas
    - [Docker install](https://docs.docker.com/engine/install/debian/)

## Limpeza do ambiente docker

```bash
#qual quer imagem
docker container rm -f $(docker container ls --quiet)

#se docker swarm ativo(Na duvida não excute)
docker service rm $(docker service ls --quiet)

#limpará containers
docker system prune --volumes --all --force
```

## Instalação do docker on debian

1. Configure o repository do docker no APT.

    ```bash
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    ```

2. Instale os pacotes do docker para debian.
    ```bash
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    ```

3. Teste o docke com a imagem hello-world
    ```bash
    sudo docker run hello-world
    ```

4. Configure seu usuário para acessar o docker sem o uso do SUDO
    ```bash
    sudo usermod -aG docker debian
    ```
