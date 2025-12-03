# Solução: Política de Execução do PowerShell

## ⚠️ Problema
A política de execução do PowerShell está como **"Restricted"**, bloqueando a execução de scripts.

## ✅ Soluções

### Opção 1: Executar Script com Bypass (Mais Rápido)

Execute no PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File .\configurar-git.ps1
```

Ou:

```powershell
powershell -ExecutionPolicy Bypass -File .\executar-comandos.ps1
```

### Opção 2: Habilitar Execução de Scripts (Permanente)

Execute no PowerShell **como Administrador**:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Depois você pode executar scripts normalmente:
```powershell
.\configurar-git.ps1
```

### Opção 3: Executar Comandos Manualmente (Já Configurado)

O Git já foi configurado! Agora você só precisa fazer o push:

```powershell
# Verificar se está tudo certo
git remote -v
git status

# Fazer push para o GitLab
git push -u origin main
```

**Credenciais quando solicitado:**
- **Usuário:** `root`
- **Senha:** `Admin12345`

Se o push falhar, tente:
```powershell
git push -u origin main -f
```

---

## 📋 Comandos Completos (Copy & Paste)

Se preferir fazer tudo manualmente:

```powershell
# 1. Configurar Git (já feito)
git config --global user.name "root"
git config --global user.email "root@localhost.com"
git config --global http.sslVerify false

# 2. Configurar remote (já feito)
git remote remove origin
git remote add origin http://localhost:8929/root/devops-project.git
git branch -M main

# 3. Commit no app (se necessário)
cd app
git add .
git commit -m "feat: Atualização para N3"
cd ..

# 4. Commit no repositório principal (se necessário)
git add .
git commit -m "refactor: Migração para GitLab N3"

# 5. Fazer push
git push -u origin main
```

---

## ✅ Status Atual

✅ Git configurado (user.name, user.email, sslVerify)  
✅ Remote configurado (http://localhost:8929/root/devops-project.git)  
✅ Branch configurado (main)  

**Próximo passo:** Fazer push quando o GitLab estiver rodando!

---

## 🔍 Verificar se GitLab está Rodando

```powershell
# Verificar containers
docker ps

# Se não estiver rodando, inicie:
docker-compose up -d gitlab registry gitlab-runner

# Aguarde 2-5 minutos e acesse:
# http://localhost:8929
```

---

## 💡 Dica

Para evitar esse problema no futuro, execute uma vez (como Administrador):

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Isso permite executar scripts locais sem precisar usar `-ExecutionPolicy Bypass` toda vez.

