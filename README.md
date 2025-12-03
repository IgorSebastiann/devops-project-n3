# DevOps Pipeline - Projeto de Avaliação N3

## 📋 Descrição do Projeto
Reprodução de um fluxo DevOps completo utilizando ferramentas open source para versionamento de código, automação de build, publicação e execução de imagens Docker. Este projeto é uma continuidade da N2, migrando de Gitea para GitLab e implementando testes unitários durante o build da imagem Docker.

**Equipe:** [Nomes dos integrantes]  
**Disciplina:** [Nome da disciplina]  
**Professor:** [Nome do professor]

---

## 🎯 Objetivos da N3
- ✅ Execução de testes unitários durante a construção da imagem Docker
- ✅ Utilização da imagem Docker na execução de um container, de forma automática através do pipeline
- ✅ Pipeline completo com build, testes e deploy automático
- ✅ Demonstração prática do fluxo DevOps end-to-end

---

## 🏗️ Arquitetura do Sistema
```
[VS Code] → [Git Push] → [GitLab] → [GitLab CI/CD Pipeline] → [Testes Unitários] → [Docker Build (com testes)] → [Registry] → [Deploy Automático]
```

---

## 🛠️ Ferramentas Utilizadas

| Ferramenta       | Finalidade               | Justificativa                                   |
|------------------|--------------------------|-------------------------------------------------|
| **GitLab CE**    | Versionamento e CI/CD    | Open source, integração nativa de CI/CD, alternativa completa ao GitHub |
| **GitLab Runner**| Executor de pipelines    | Executa os jobs do GitLab CI/CD de forma automática |
| **Docker**       | Containerização          | Padrão de mercado para empacotamento            |
| **Docker Registry** | Armazenamento de imagens | Simples e eficiente para registry local         |
| **Jest**         | Framework de testes       | Padrão da indústria para testes unitários em Node.js |
| **Node.js**      | Aplicação de exemplo     | Simples para demonstrar o fluxo                 |
| **PowerShell**   | Automação de scripts     | Nativo no Windows, fácil execução               |

---

## 📁 Estrutura do Projeto
```
devops-project/
├── docker-compose.yml          # Orquestração de containers (GitLab, Registry, Runner)
├── apresentacao.ps1            # Script de demonstração
├── instalar-tudo.ps1           # Script de instalação
├── configurar-git.ps1          # Configuração do Git
├── app/                        # Código da aplicação
│   ├── src/
│   │   ├── app.js              # API REST em Node.js
│   │   └── app.test.js         # Testes unitários (Jest)
│   ├── package.json            # Dependências Node.js
│   ├── Dockerfile              # Build da imagem Docker (com testes)
│   └── .gitlab-ci.yml          # Configuração do pipeline GitLab CI/CD
└── README.md                   # Este arquivo
```

---

## 🚀 Como Executar o Projeto

### Pré-requisitos
- Docker Desktop instalado e rodando  
- Git instalado  
- PowerShell (já incluso no Windows)
- Mínimo 4GB de RAM disponível para o GitLab

### Passo a Passo

#### 1. Iniciar os serviços
```powershell
.\instalar-tudo.ps1
```

Ou manualmente:
```powershell
docker-compose up -d gitlab registry gitlab-runner
```

**⚠️ Importante:** O GitLab pode levar 2-5 minutos para inicializar completamente.

#### 2. Configurar o GitLab
Acesse: [http://localhost:8929](http://localhost:8929)

**Primeira vez:**
- Aguarde a página de login aparecer (pode levar alguns minutos)
- Faça login com:
  - **Usuário:** `root`
  - **Senha:** `Admin12345`
- Você será solicitado a alterar a senha (opcional para ambiente de teste)

#### 3. Criar repositório no GitLab
- Faça login como `root`
- Clique em **"New project"** ou **"+"** → **"New project/repository"**
- Selecione **"Create blank project"**
- Nome do projeto: `devops-project`
- Visibilidade: **Private** (recomendado)
- **NÃO** marque "Initialize repository with a README"
- Clique em **"Create project"**

#### 4. Configurar GitLab Runner
Após criar o projeto, você precisa registrar o GitLab Runner:

1. No GitLab, vá em **Settings** → **CI/CD** → **Runners**
2. Expanda a seção **"Specific runners"**
3. Copie o **Registration token**

4. Execute o comando para registrar o runner:
```powershell
docker exec -it gitlab-runner gitlab-runner register \
  --non-interactive \
  --url "http://gitlab:8929/" \
  --registration-token "SEU_TOKEN_AQUI" \
  --executor "docker" \
  --docker-image "docker:24-dind" \
  --docker-privileged \
  --docker-volumes "/var/run/docker.sock:/var/run/docker.sock" \
  --description "docker-runner" \
  --tag-list "docker" \
  --run-untagged="true"
```

**Alternativa (mais simples):** Edite o arquivo `gitlab-runner/config/config.toml` manualmente (veja exemplo abaixo).

#### 5. Configurar Git e fazer push
```powershell
.\configurar-git.ps1
```

Este script irá:
- Inicializar o repositório Git
- Fazer commit do código
- Configurar o remote para o GitLab
- Fazer push (use `root` / `Admin12345` quando solicitado)

#### 6. Verificar o pipeline
Após o push, o pipeline será executado automaticamente:
- Acesse: [http://localhost:8929/root/devops-project/-/pipelines](http://localhost:8929/root/devops-project/-/pipelines)
- Você verá 3 estágios: **test** → **build** → **deploy**

#### 7. Executar demonstração
```powershell
.\apresentacao.ps1
```

---

## ⚙️ Scripts Automatizados
- **instalar-tudo.ps1** — Verifica pré-requisitos e inicia containers  
- **configurar-git.ps1** — Configura repositório Git e faz push automático  
- **apresentacao.ps1** — Demonstra o ambiente e verifica status do pipeline  

---

## 📊 Fluxo DevOps Implementado

### 1. Versionamento (GitLab)
✅ Repositório Git auto-hospedado  
✅ Histórico de commits demonstrável  
✅ Operações colaborativas (clone, push, pull)  
✅ Interface web completa

### 2. Pipeline CI/CD (GitLab CI)
✅ **Estágio Test:** Execução de testes unitários com Jest  
✅ **Estágio Build:** Construção da imagem Docker com testes durante o build  
✅ **Estágio Deploy:** Deploy automático da imagem em container  
✅ Execução automática a cada push

### 3. Testes Unitários
✅ Testes reais implementados com Jest  
✅ Cobertura de código  
✅ Execução durante o build da imagem Docker  
✅ Validação de endpoints da API

### 4. Containerização
✅ Dockerfile funcional com multi-stage build  
✅ Testes executados durante o build  
✅ Imagem otimizada (Node.js Alpine)  
✅ Imagem de produção sem dependências de desenvolvimento

### 5. Registry
✅ Armazenamento de imagens Docker  
✅ Tags versionadas (commit SHA + latest)  
✅ Acesso via HTTP (ambiente local)  

### 6. Deploy Automático
✅ Container criado automaticamente pelo pipeline  
✅ Health check da aplicação  
✅ API disponível após deploy

---

## 🎯 Demonstração Prática

### Serviços Disponíveis
- **GitLab:** [http://localhost:8929](http://localhost:8929)
- **Projeto:** [http://localhost:8929/root/devops-project](http://localhost:8929/root/devops-project)
- **Pipelines:** [http://localhost:8929/root/devops-project/-/pipelines](http://localhost:8929/root/devops-project/-/pipelines)
- **Registry:** [http://localhost:5000/v2/_catalog](http://localhost:5000/v2/_catalog)
- **API:** [http://localhost:3001](http://localhost:3001)

### Endpoints da API
```bash
GET /          # Informações da aplicação
GET /health    # Status de saúde da aplicação
```

### Comandos de Verificação
```powershell
# Verificar containers
docker ps

# Testar API
Invoke-WebRequest http://localhost:3001
Invoke-WebRequest http://localhost:3001/health

# Verificar registry
Invoke-WebRequest http://localhost:5000/v2/_catalog

# Ver logs da aplicação
docker logs demo-api

# Ver logs do GitLab
docker logs gitlab --tail 50

# Ver logs do GitLab Runner
docker logs gitlab-runner --tail 50
```

---

## 🔧 Configuração do GitLab Runner

Se o registro automático não funcionar, você pode configurar manualmente:

1. Crie o diretório: `gitlab-runner/config`
2. Crie o arquivo `gitlab-runner/config/config.toml`:

```toml
concurrent = 1
check_interval = 0

[session_server]
  session_timeout = 1800

[[runners]]
  name = "docker-runner"
  url = "http://gitlab:8929/"
  token = "SEU_TOKEN_DO_GITLAB"
  executor = "docker"
  [runners.docker]
    tls_verify = false
    image = "docker:24-dind"
    privileged = true
    disable_entrypoint_overwrite = false
    oom_kill_disable = false
    disable_cache = false
    volumes = ["/var/run/docker.sock:/var/run/docker.sock", "/cache"]
    shm_size = 0
  [runners.cache]
    [runners.cache.s3]
    [runners.cache.gcs]
    [runners.cache.azure]
```

Substitua `SEU_TOKEN_DO_GITLAB` pelo token obtido em **Settings** → **CI/CD** → **Runners**.

---

## 🔧 Solução de Problemas

### Problemas Comuns

**GitLab não carrega:**
- Aguarde 3-5 minutos após iniciar o container
- Verifique os logs: `docker logs gitlab --tail 100`
- Verifique se há espaço em disco suficiente

**Portas em uso:**
- Feche programas usando portas `8929`, `5000`, `3001`, `2224`
- Ou altere as portas no `docker-compose.yml`

**Pipeline não executa:**
- Verifique se o GitLab Runner está registrado e rodando
- Verifique os logs: `docker logs gitlab-runner`
- Confirme que o runner tem a tag `docker`

**Docker não inicia:**
- Execute Docker Desktop como Administrador
- Verifique se o WSL2 está configurado (Windows)

**Git push falha:**
- Use `git push -u origin main -f` para forçar
- Verifique as credenciais (root / Admin12345)
- Confirme que o repositório foi criado no GitLab

**Testes falham:**
- Execute localmente: `cd app && npm install && npm test`
- Verifique se todas as dependências estão no `package.json`

### Comandos Úteis
```powershell
# Reiniciar serviços
docker-compose down
docker-compose up -d gitlab registry gitlab-runner

# Limpar demonstração anterior
docker stop demo-api
docker rm demo-api

# Verificar logs
docker-compose logs gitlab
docker-compose logs gitlab-runner
docker logs demo-api

# Limpar tudo e recomeçar
docker-compose down -v
Remove-Item -Recurse -Force gitlab, registry, gitlab-runner
```

---

## 📋 Pipeline GitLab CI/CD

O pipeline está configurado em `.gitlab-ci.yml` e possui 3 estágios:

### 1. Test (test)
- Instala dependências
- Executa testes unitários com Jest
- Gera relatório de cobertura

### 2. Build (build)
- Constrói imagem Docker
- Executa testes durante o build (conforme requisito N3)
- Faz push da imagem para o registry
- Cria tags: `latest` e `commit-sha`

### 3. Deploy (deploy)
- Para container anterior (se existir)
- Faz pull da imagem do registry
- Inicia novo container
- Executa health check
- API fica disponível em http://localhost:3001

---

## 💡 Dificuldades e Soluções

### Desafios Encontrados
- **Migração Gitea → GitLab:** Necessidade de reconfigurar todo o ambiente
- **Configuração GitLab Runner:** Complexidade na integração Docker-in-Docker
- **Testes durante build:** Implementação de multi-stage build no Dockerfile
- **Registry inseguro:** Configuração para permitir HTTP em ambiente local
- **Tempo de inicialização:** GitLab leva vários minutos para inicializar

### Soluções Adotadas
- Pipeline GitLab CI/CD nativo (sem dependências externas)
- Docker-in-Docker (DinD) para build de imagens
- Multi-stage build no Dockerfile para executar testes
- Registry local com configuração HTTP
- Scripts PowerShell para automação e facilitar reprodução
- Documentação detalhada para configuração do runner

---

## 🚀 Melhorias para Ambiente Corporativo

### Segurança
- HTTPS com certificados válidos (Let's Encrypt)
- Autenticação robusta no registry (Harbor ou GitLab Container Registry)
- Scan de vulnerabilidades em imagens (Trivy, Clair)
- Secrets management (HashiCorp Vault, GitLab CI/CD Variables)
- Políticas de segurança de código (SAST, DAST)

### Monitoramento
- Logs centralizados (ELK Stack, Loki)
- Métricas de performance (Prometheus, Grafana)
- Alertas automáticos (Alertmanager)
- Health checks e auto-healing

### Escalabilidade
- Orchestrator (Kubernetes, Docker Swarm)
- Pipeline multi-estágio (dev, staging, production)
- Deploy blue-green ou canary
- Auto-scaling baseado em métricas

### Integração
- Webhooks para notificações (Slack, Teams, Discord)
- Integração com ferramentas de gestão (Jira, Trello)
- Dashboard de métricas (GitLab Analytics, Grafana)
- Integração com ferramentas de qualidade (SonarQube)

---

## 📝 Evidências do Pipeline

### Como Capturar Evidências

1. **Screenshots do Pipeline:**
   - Acesse: http://localhost:8929/root/devops-project/-/pipelines
   - Capture a tela mostrando os 3 estágios (test, build, deploy)
   - Capture os logs de cada estágio

2. **Screenshot do Registry:**
   - Acesse: http://localhost:5000/v2/_catalog
   - Capture mostrando as imagens armazenadas

3. **Screenshot da API:**
   - Acesse: http://localhost:3001
   - Capture a resposta JSON da API

4. **Logs do Pipeline:**
   - No GitLab, clique em cada job para ver os logs completos
   - Capture os logs mostrando:
     - Execução dos testes
     - Build da imagem Docker
     - Deploy do container

---

## 👥 Contribuições da Equipe
- [Nome]: Configuração GitLab, Docker e Desenvolvimento da API  
- [Nome]: Pipeline GitLab CI/CD e scripts  
- Igor Sebastian: Documentação, testes unitários, refatoração para GitLab e apresentação
- [Nome]: Registry e deploy automático   

---

## 📞 Suporte
Em caso de problemas na execução:
- Verifique se Docker está rodando  
- Confirme que as portas estão livres  
- Execute os scripts como Administrador  
- Consulte a seção de **Solução de Problemas**
- Verifique os logs dos containers

---

## 🎉 Projeto desenvolvido para avaliação N3 - Fluxo DevOps Completo com GitLab

### Requisitos da N3 Atendidos:
✅ Execução de testes unitários durante a construção da imagem Docker  
✅ Utilização da imagem Docker na execução de um container, de forma automática através do pipeline  
✅ Pipeline configurado para realizar build e deploy automático  
✅ Geração correta da imagem Docker, realizando os testes unitários de forma automática  
✅ Execução automática de um container Docker, utilizando a imagem gerada  
✅ Todas as ferramentas são open source e auto-hospedadas  
