Write-Host "=== COMMIT E PUSH ===" -ForegroundColor Cyan
Write-Host ""

$projectRoot = "C:\Users\$env:USERNAME\Desktop\devops-project"
cd $projectRoot

# Verificar se há mudanças
$hasChanges = $false

# 1. Commit no app (se necessário)
Write-Host "1. Verificando mudanças no app..." -ForegroundColor Yellow
cd app
if (Test-Path ".git") {
    git add . 2>&1 | Out-Null
    $appStatus = git status --porcelain
    if ($appStatus) {
        $hasChanges = $true
        Write-Host "   Mudanças encontradas no app" -ForegroundColor White
        $commitMessage = Read-Host "   Digite a mensagem do commit para o app (ou Enter para padrão)"
        if ([string]::IsNullOrWhiteSpace($commitMessage)) {
            $commitMessage = "feat: Atualização da aplicação"
        }
        git commit -m $commitMessage
        Write-Host "   ✅ Commit realizado no app" -ForegroundColor Green
    } else {
        Write-Host "   ℹ️  Nenhuma mudança no app" -ForegroundColor Gray
    }
} else {
    Write-Host "   ℹ️  Diretório app não é um repositório Git separado" -ForegroundColor Gray
}
cd ..

# 2. Commit no repositório principal
Write-Host ""
Write-Host "2. Verificando mudanças no repositório principal..." -ForegroundColor Yellow
git add . 2>&1 | Out-Null
$mainStatus = git status --porcelain
if ($mainStatus) {
    $hasChanges = $true
    Write-Host "   Mudanças encontradas:" -ForegroundColor White
    git status --short
    Write-Host ""
    $commitMessage = Read-Host "   Digite a mensagem do commit (ou Enter para padrão)"
    if ([string]::IsNullOrWhiteSpace($commitMessage)) {
        $commitMessage = "chore: Atualização do projeto"
    }
    git commit -m $commitMessage
    Write-Host "   ✅ Commit realizado" -ForegroundColor Green
} else {
    Write-Host "   ℹ️  Nenhuma mudança para commitar" -ForegroundColor Gray
}

# 3. Push
if ($hasChanges) {
    Write-Host ""
    Write-Host "3. Fazendo push..." -ForegroundColor Yellow
    $pushResult = git push 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ✅ Push realizado com sucesso!" -ForegroundColor Green
        Write-Host ""
        Write-Host "   Repositório: https://github.com/IgorSebastiann/devops-project-n3" -ForegroundColor Cyan
    } else {
        Write-Host "   ⚠️  Erro no push. Tentando com force..." -ForegroundColor Yellow
        $forcePush = Read-Host "   Deseja fazer push forçado? (s/N)"
        if ($forcePush -eq "s" -or $forcePush -eq "S") {
            git push -f
            if ($LASTEXITCODE -eq 0) {
                Write-Host "   ✅ Push forçado realizado!" -ForegroundColor Green
            } else {
                Write-Host "   ❌ Erro no push forçado" -ForegroundColor Red
            }
        } else {
            Write-Host "   Push cancelado" -ForegroundColor Yellow
        }
    }
} else {
    Write-Host ""
    Write-Host "ℹ️  Nenhuma mudança para commitar ou fazer push" -ForegroundColor Gray
}

Write-Host ""
Write-Host "=== CONCLUÍDO ===" -ForegroundColor Cyan

