Write-Host "=== INSTALADOR DO AMBIENTE DEVOPS ===" -ForegroundColor Cyan

# Verificar se Docker está rodando
Write-Host "1. Verificando Docker..." -ForegroundColor Yellow
try {
    docker version 2>$null
    Write-Host "   ✅ Docker está rodando" -ForegroundColor Green
} catch {
    Write-Host "   ❌ Docker não está rodando. Inicie o Docker Desktop primeiro!" -ForegroundColor Red
    exit 1
}

# Verificar se Git está instalado
Write-Host "2. Verificando Git..." -ForegroundColor Yellow
try {
    git --version 2>$null
    Write-Host "   ✅ Git está instalado" -ForegroundColor Green
} catch {
    Write-Host "   ❌ Git não está instalado. Instale o Git primeiro!" -ForegroundColor Red
    exit 1
}

# Iniciar containers
Write-Host "3. Iniciando containers Docker (GitLab, Registry, GitLab Runner)..." -ForegroundColor Yellow
docker-compose down 2>$null
docker-compose up -d gitlab registry gitlab-runner

Write-Host "   Aguardando containers iniciarem (isso pode levar 2-3 minutos)..." -ForegroundColor White
Write-Host "   ⏳ GitLab está inicializando, aguarde..." -ForegroundColor Yellow
Start-Sleep -Seconds 60

Write-Host "   ✅ Containers iniciados" -ForegroundColor Green

Write-Host "4. Próximos passos MANUAIS:" -ForegroundColor Cyan
Write-Host "   - Acesse: http://localhost:8929" -ForegroundColor White
Write-Host "   - Aguarde o GitLab terminar de inicializar (pode levar mais 2-3 minutos)" -ForegroundColor White
Write-Host "   - Faça login com:" -ForegroundColor White
Write-Host "     Usuário: root" -ForegroundColor White
Write-Host "     Senha: Admin12345" -ForegroundColor White
Write-Host "   - Crie um novo projeto chamado 'devops-project'" -ForegroundColor White
Write-Host "   - Execute: .\configurar-git.ps1" -ForegroundColor White
Write-Host "   - Configure o GitLab Runner (veja README.md)" -ForegroundColor White
Write-Host "   - Faça push para trigger do pipeline" -ForegroundColor White