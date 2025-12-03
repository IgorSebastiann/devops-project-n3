# Script alternativo que pode ser copiado e colado diretamente no PowerShell
# ou executado com: powershell -ExecutionPolicy Bypass -File .\configurar-git-manual.ps1

Write-Host "=== CONFIGURANDO GIT (MANUAL) ===" -ForegroundColor Cyan

$projectRoot = "C:\Users\$env:USERNAME\Desktop\devops-project"
cd $projectRoot

Write-Host "1. Navegando para o diretório app..." -ForegroundColor Yellow
cd app

Write-Host "2. Verificando status do Git no app..." -ForegroundColor Yellow
git status

Write-Host "3. Adicionando mudanças no app..." -ForegroundColor Yellow
git add .

Write-Host "4. Fazendo commit no app (se houver mudanças)..." -ForegroundColor Yellow
$hasChanges = git diff --cached --quiet; if ($LASTEXITCODE -ne 0) {
    git commit -m "feat: Atualização para N3"
    Write-Host "   ✅ Commit realizado no app" -ForegroundColor Green
} else {
    Write-Host "   ℹ️  Nenhuma mudança para commitar no app" -ForegroundColor White
}

Write-Host "5. Voltando para o diretório raiz..." -ForegroundColor Yellow
cd ..

Write-Host "6. Configurando Git..." -ForegroundColor Yellow
git config --global user.name "root"
git config --global user.email "root@localhost.com"
git config --global http.sslVerify false

Write-Host "7. Adicionando todas as mudanças..." -ForegroundColor Yellow
git add .

Write-Host "8. Fazendo commit no repositório principal..." -ForegroundColor Yellow
$hasChanges = git diff --cached --quiet; if ($LASTEXITCODE -ne 0) {
    git commit -m "refactor: Migração para GitLab N3"
    Write-Host "   ✅ Commit realizado" -ForegroundColor Green
} else {
    Write-Host "   ℹ️  Nenhuma mudança para commitar" -ForegroundColor White
}

Write-Host "9. Configurando repositório remoto..." -ForegroundColor Yellow
git remote remove origin 2>$null
git remote add origin http://localhost:8929/root/devops-project.git
git branch -M main

Write-Host ""
Write-Host "10. Para fazer push, execute manualmente:" -ForegroundColor Cyan
Write-Host "    git push -u origin main" -ForegroundColor White
Write-Host ""
Write-Host "    Credenciais:" -ForegroundColor Yellow
Write-Host "    Usuário: root" -ForegroundColor White
Write-Host "    Senha: Admin12345" -ForegroundColor White
Write-Host ""
Write-Host "✅ Configuração concluída!" -ForegroundColor Green

