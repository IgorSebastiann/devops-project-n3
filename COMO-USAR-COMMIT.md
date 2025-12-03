# Como Usar o Script de Commit

## 🚀 Script Único: `commit.ps1`

Este é o único script que você precisa para fazer commits e push para o GitHub.

## 📋 Como Executar

### Opção 1: Com Bypass (Recomendado)

```powershell
powershell -ExecutionPolicy Bypass -File .\commit.ps1
```

### Opção 2: Se a Política Permitir

```powershell
.\commit.ps1
```

## ✨ O que o Script Faz

1. **Verifica mudanças no app/** - Se houver mudanças, faz commit
2. **Verifica mudanças no repositório principal** - Se houver mudanças, faz commit
3. **Faz push para o GitHub** - Envia todos os commits

## 💡 Fluxo de Uso

1. Faça suas alterações nos arquivos
2. Execute: `powershell -ExecutionPolicy Bypass -File .\commit.ps1`
3. Digite a mensagem do commit quando solicitado (ou pressione Enter para usar a padrão)
4. O script faz tudo automaticamente!

## 📝 Exemplo de Uso

```powershell
# Você fez algumas mudanças...
# Agora execute:
powershell -ExecutionPolicy Bypass -File .\commit.ps1

# O script vai perguntar:
# "Digite a mensagem do commit (ou Enter para padrão)"
# Você digita: "feat: Adicionada nova funcionalidade"
# Ou apenas pressiona Enter para usar a mensagem padrão

# O script faz:
# ✅ Commit no app (se houver mudanças)
# ✅ Commit no repositório principal
# ✅ Push para o GitHub
```

## ⚙️ Configuração

O script já está configurado com:
- **Usuário:** IgorSebastiann
- **Email:** igor.sebastian23@gmail.com
- **Repositório:** https://github.com/IgorSebastiann/devops-project-n3.git

## 🔧 Troubleshooting

### Erro: "execution of scripts is disabled"
Use a Opção 1 com `-ExecutionPolicy Bypass`

### Erro: "failed to push"
O script vai perguntar se você quer fazer push forçado. Use apenas se tiver certeza!

### Erro: "authentication failed"
Configure suas credenciais do GitHub:
- Use Personal Access Token como senha
- Ou configure SSH

## 📌 Dica

Crie um alias no PowerShell para facilitar:

```powershell
# Adicione ao seu perfil PowerShell ($PROFILE)
function Commit-Project {
    powershell -ExecutionPolicy Bypass -File "C:\Users\$env:USERNAME\Desktop\devops-project\commit.ps1"
}

# Depois você pode usar apenas:
Commit-Project
```

---

**Simples assim!** Um único comando e tudo é feito automaticamente. 🎉

