# Comandos para Commit e Push no GitHub

## ✅ Configuração Realizada

- ✅ Git configurado: **IgorSebastiann** / **igor.sebastian23@gmail.com**
- ✅ Remote configurado: **https://github.com/IgorSebastiann/devops-project-n3.git**
- ✅ Branch: **main**

## 🚀 Comandos para Fazer Push

### Opção 1: Push Normal (Recomendado)

```powershell
git push -u origin main
```

### Opção 2: Se o Push Falhar (Forçar)

```powershell
git push -u origin main -f
```

⚠️ **Atenção:** Use `-f` apenas se tiver certeza, pois sobrescreve o histórico remoto.

---

## 📋 Sequência Completa (Se Precisar Fazer Tudo Novamente)

```powershell
# 1. Configurar Git
git config --global user.name "IgorSebastiann"
git config --global user.email "igor.sebastian23@gmail.com"

# 2. Configurar Remote
git remote remove origin
git remote add origin https://github.com/IgorSebastiann/devops-project-n3.git

# 3. Commit no app (se necessário)
cd app
git add .
git commit -m "feat: Implementação completa para N3"
cd ..

# 4. Commit no repositório principal
git add .
git commit -m "refactor: Migração completa de Gitea para GitLab (N3)"

# 5. Fazer Push
git push -u origin main
```

---

## 🔐 Autenticação GitHub

Se solicitado, você pode usar:

1. **Personal Access Token (Recomendado):**
   - Vá em: GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
   - Crie um token com permissão `repo`
   - Use o token como senha

2. **GitHub CLI:**
   ```powershell
   gh auth login
   ```

3. **SSH (Alternativa):**
   ```powershell
   git remote set-url origin git@github.com:IgorSebastiann/devops-project-n3.git
   ```

---

## ✅ Verificação

Após o push, verifique:

```powershell
# Ver commits
git log --oneline -5

# Verificar remote
git remote -v

# Ver status
git status
```

Acesse seu repositório: https://github.com/IgorSebastiann/devops-project-n3

