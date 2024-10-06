![Build](https://github.com/MrErlison/zabbix-asterisk/actions/workflows/docker-image.yml/badge.svg)

## Zabbix e Asterisk

Os arquivos yaml do Zabbix foram obtidos no [repositório oficial](https://github.com/zabbix/zabbix-docker)

Para gerar somente a imagem do Asterisk execute

```shell
docker build -t asterisk .
```

Para levantar o Zabbix e o Asterisk execute  

```shell
docker compose up -d
```

Caso prefira subir somente o Asterisk, sem nenhuma relação com o Zabbix, execute

```shell
docker compose -f aster_env/docker-compose-asterisk.yaml up -d
```

Os arquivos (http.conf, logger.conf e manager.conf) de configuração necessários como habilitar a comunicação entre o Asterisk e Zabbis estão no diretório `aster_env/etc/asterisk/`.

O arquivo `aster_env/docker-compose.yaml`

O template ami_asterisk precisa ser atualizado no Zabbix para a versão que está no diretório `templates`. O arquivo foi retirado do [repositório oficial](https://git.zabbix.com/projects/ZBX/repos/zabbix/browse/templates/tel/asterisk_http/template_tel_asterisk_http.yaml?at=release%2F7.0). O arquivo encontra-se na 

**Troque o usuário e senha** e demais configurações necessárias para suas necessidades.

## TODO

- Reduzir a imagem do Asterisk