Write-Host "=== CONFIGURANDO GIT E GITEA (CORRIGIDO) ===" -ForegroundColor Cyan

cd "C:\Users\Igor Sebastian\Desktop\devops-project\app"

Write-Host "1. Verificando branch atual..." -ForegroundColor Yellow
git branch

Write-Host "2. Renomeando branch para main..." -ForegroundColor Yellow
git branch -M main

Write-Host "3. Verificando arquivos para commit..." -ForegroundColor Yellow
git status

Write-Host "4. Adicionando arquivos..." -ForegroundColor Yellow
git add .

Write-Host "5. Fazendo commit..." -ForegroundColor Yellow
git commit -m "feat: initial commit - API DevOps com pipeline completo"

Write-Host "6. Configurando remote..." -ForegroundColor Yellow
git remote set-url origin http://localhost:3000/admin/devops-project.git

Write-Host "7. Fazendo push para o Gitea..." -ForegroundColor Yellow
Write-Host "   Usuario: admin" -ForegroundColor White
Write-Host "   Senha: Admin12345" -ForegroundColor White
git push -u origin main

if ($LASTEXITCODE -ne 0) {
    Write-Host "Tentando push forçado..." -ForegroundColor Red
    git push -u origin main -f
}

Write-Host "✅ Concluído!" -ForegroundColor Green
Write-Host "Acesse: http://localhost:3000/admin/devops-project" -ForegroundColor Cyan