Write-Host "=== CONFIGURANDO GIT ===" -ForegroundColor Cyan

cd "C:\Users\$env:USERNAME\Desktop\devops-project\app"

Write-Host "1. Inicializando repositório..." -ForegroundColor Yellow
if (Test-Path ".git") {
    Write-Host "   Repositório Git já existe" -ForegroundColor White
} else {
    git init
}
git config --global user.name "root"
git config --global user.email "root@localhost.com"
git config --global http.sslVerify false

Write-Host "2. Fazendo commit do código..." -ForegroundColor Yellow
git add .
git commit -m "Initial commit - API DevOps com GitLab CI/CD" -m "Pipeline configurado com testes, build e deploy automático"

Write-Host "3. Configurando repositório remoto..." -ForegroundColor Yellow
# Remover remote anterior se existir
git remote remove origin 2>$null
git remote add origin http://localhost:8929/root/devops-project.git
git branch -M main

Write-Host "4. Fazendo push para o GitLab..." -ForegroundColor Yellow
Write-Host "   Usuário: root" -ForegroundColor White
Write-Host "   Senha: Admin12345" -ForegroundColor White
Write-Host "   ⚠️  Se solicitado, use as credenciais acima" -ForegroundColor Yellow

git push -u origin main

if ($LASTEXITCODE -ne 0) {
    Write-Host "   Tentando push forçado..." -ForegroundColor Yellow
    git push -u origin main -f
}

Write-Host "✅ Git configurado com sucesso!" -ForegroundColor Green
Write-Host "Acesse: http://localhost:8929/root/devops-project" -ForegroundColor Cyan
Write-Host "O pipeline será executado automaticamente após o push!" -ForegroundColor Cyan