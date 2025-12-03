# Comandos Manuais - Configurar Git e Fazer Push

Como a política de execução do PowerShell está bloqueando scripts, use estes comandos manualmente:

## 🔧 Opção 1: Habilitar Execução de Scripts (Recomendado)

Execute no PowerShell **como Administrador**:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Depois você pode executar os scripts normalmente:
```powershell
.\configurar-git.ps1
```

---

## 📋 Opção 2: Executar Comandos Manualmente

### Passo 1: Configurar Git no diretório app

```powershell
cd "C:\Users\$env:USERNAME\Desktop\devops-project\app"
git add .
git commit -m "feat: Atualização para N3"
cd ..
```

### Passo 2: Configurar Git no repositório principal

```powershell
cd "C:\Users\$env:USERNAME\Desktop\devops-project"
git config --global user.name "root"
git config --global user.email "root@localhost.com"
git config --global http.sslVerify false
git add .
git commit -m "refactor: Migração para GitLab N3"
```

### Passo 3: Configurar repositório remoto

```powershell
git remote remove origin
git remote add origin http://localhost:8929/root/devops-project.git
git branch -M main
```

### Passo 4: Fazer push para o GitLab

```powershell
git push -u origin main
```

**Quando solicitado:**
- **Usuário:** `root`
- **Senha:** `Admin12345`

Se o push falhar, tente:
```powershell
git push -u origin main -f
```

---

## 🚀 Opção 3: Executar Script com Bypass

Execute o script ignorando a política de execução:

```powershell
powershell -ExecutionPolicy Bypass -File .\configurar-git.ps1
```

Ou para o script manual:
```powershell
powershell -ExecutionPolicy Bypass -File .\configurar-git-manual.ps1
```

---

## ✅ Verificação

Após fazer push, verifique:

```powershell
# Ver commits
git log --oneline -3

# Verificar remote
git remote -v

# Verificar branch
git branch
```

---

## 🔍 Troubleshooting

### Erro: "fatal: not a git repository"
```powershell
cd "C:\Users\$env:USERNAME\Desktop\devops-project"
git init
```

### Erro: "remote origin already exists"
```powershell
git remote remove origin
git remote add origin http://localhost:8929/root/devops-project.git
```

### Erro: "authentication failed"
- Verifique se o GitLab está rodando: http://localhost:8929
- Confirme as credenciais: `root` / `Admin12345`
- Tente fazer push novamente

### GitLab não está acessível
1. Verifique se os containers estão rodando:
   ```powershell
   docker ps
   ```
2. Se não estiverem, inicie:
   ```powershell
   docker-compose up -d gitlab registry gitlab-runner
   ```
3. Aguarde 2-5 minutos para o GitLab inicializar

