# Execute este arquivo com: powershell -ExecutionPolicy Bypass -File .\executar-comandos.ps1
# Ou copie e cole os comandos diretamente no PowerShell

Write-Host "=== CONFIGURANDO GIT PARA GITLAB ===" -ForegroundColor Cyan
Write-Host ""

$projectRoot = "C:\Users\$env:USERNAME\Desktop\devops-project"
cd $projectRoot

# 1. Commit no app
Write-Host "1. Fazendo commit no app..." -ForegroundColor Yellow
cd app
git add .
$status = git status --porcelain
if ($status) {
    git commit -m "feat: Atualização para N3" 2>&1 | Out-Null
    Write-Host "   ✅ Commit realizado no app" -ForegroundColor Green
} else {
    Write-Host "   ℹ️  Nenhuma mudança no app" -ForegroundColor White
}
cd ..

# 2. Configurar Git
Write-Host "2. Configurando Git..." -ForegroundColor Yellow
git config --global user.name "root"
git config --global user.email "root@localhost.com"
git config --global http.sslVerify false

# 3. Commit no repositório principal
Write-Host "3. Fazendo commit no repositório principal..." -ForegroundColor Yellow
git add .
$status = git status --porcelain
if ($status) {
    git commit -m "refactor: Migração para GitLab N3" 2>&1 | Out-Null
    Write-Host "   ✅ Commit realizado" -ForegroundColor Green
} else {
    Write-Host "   ℹ️  Nenhuma mudança" -ForegroundColor White
}

# 4. Configurar remote
Write-Host "4. Configurando repositório remoto..." -ForegroundColor Yellow
git remote remove origin 2>$null
git remote add origin http://localhost:8929/root/devops-project.git
git branch -M main

Write-Host ""
Write-Host "5. Para fazer push, execute:" -ForegroundColor Cyan
Write-Host "   git push -u origin main" -ForegroundColor White
Write-Host ""
Write-Host "   Credenciais quando solicitado:" -ForegroundColor Yellow
Write-Host "   Usuário: root" -ForegroundColor White
Write-Host "   Senha: Admin12345" -ForegroundColor White
Write-Host ""
Write-Host "✅ Configuração concluída!" -ForegroundColor Green

