# Solução de Problemas - Docker Desktop

## Erro: "read-only file system" ou "input/output error"

Se você está enfrentando erros ao baixar ou extrair imagens do Docker, siga estes passos:

### 1. Reiniciar Docker Desktop
1. Feche completamente o Docker Desktop
2. Abra o Gerenciador de Tarefas (Ctrl+Shift+Esc)
3. Finalize todos os processos relacionados ao Docker
4. Reinicie o Docker Desktop como Administrador
5. Aguarde o Docker inicializar completamente

### 2. Limpar Cache do Docker
```powershell
# Parar todos os containers
docker stop $(docker ps -aq) 2>$null

# Limpar sistema Docker
docker system prune -a -f

# Se o comando acima falhar, tente:
docker container prune -f
docker image prune -a -f
docker volume prune -f
```

### 3. Verificar Espaço em Disco
- Certifique-se de ter pelo menos 10GB de espaço livre
- O GitLab requer bastante espaço (4-6GB apenas para a imagem)

### 4. Verificar WSL2 (se aplicável)
Se estiver usando WSL2:
```powershell
wsl --list --verbose
wsl --shutdown
# Depois reinicie o Docker Desktop
```

### 5. Usar Versão Específica do GitLab
O arquivo `docker-compose.yml` já foi atualizado para usar versões específicas ao invés de `latest`, o que é mais estável.

### 6. Baixar Imagens Manualmente
Se o problema persistir, tente baixar as imagens manualmente:

```powershell
# Baixar imagens uma por uma
docker pull gitlab/gitlab-ce:16.11.0-ce.0
docker pull gitlab/gitlab-runner:v16.11.0
docker pull registry:2
```

### 7. Alternativa: Usar GitLab Mais Leve
Se o GitLab CE completo for muito pesado, você pode usar uma versão menor ou considerar usar apenas o GitLab Runner com um repositório Git remoto.

### 8. Verificar Logs do Docker
```powershell
# Ver logs do Docker Desktop
Get-Content "$env:LOCALAPPDATA\Docker\log.txt" -Tail 50
```

### 9. Resetar Docker Desktop (Último Recurso)
⚠️ **ATENÇÃO:** Isso apagará todas as imagens e containers!

1. Abra Docker Desktop
2. Vá em Settings → Troubleshoot
3. Clique em "Clean / Purge data"
4. Reinicie o Docker Desktop

### 10. Verificar Antivírus
Alguns antivírus podem interferir com o Docker. Tente:
- Adicionar exceções para Docker Desktop
- Desabilitar temporariamente o antivírus para testar

---

## Se Nada Funcionar

Como alternativa temporária, você pode:
1. Usar um GitLab hospedado (GitLab.com) para testes
2. Usar apenas o GitLab Runner com um repositório Git remoto
3. Usar uma máquina virtual Linux para rodar o GitLab

---

## Comandos Úteis de Diagnóstico

```powershell
# Verificar status do Docker
docker info

# Verificar espaço usado
docker system df

# Verificar containers rodando
docker ps -a

# Verificar imagens
docker images

# Verificar volumes
docker volume ls

# Verificar redes
docker network ls
```

