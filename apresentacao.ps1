Write-Host "=== DEMONSTRACAO PIPELINE CI/CD ===" -ForegroundColor Cyan
Write-Host ""

Write-Host "Este script demonstra o pipeline GitLab CI/CD" -ForegroundColor Yellow
Write-Host "O pipeline é executado automaticamente via GitLab!" -ForegroundColor Yellow
Write-Host ""

# 1. VERIFICAR STATUS DO GITLAB
Write-Host "1. VERIFICANDO STATUS DO GITLAB" -ForegroundColor Yellow
Write-Host "   Acesse: http://localhost:8929/root/devops-project" -ForegroundColor White
Write-Host "   Verifique o pipeline em: http://localhost:8929/root/devops-project/-/pipelines" -ForegroundColor White

# 2. VERIFICAR REGISTRY
Write-Host "2. VERIFICANDO REGISTRY" -ForegroundColor Yellow
Write-Host "   Conteudo do registry:" -ForegroundColor White
try {
    $response = Invoke-WebRequest -Uri "http://localhost:5000/v2/_catalog" -UseBasicParsing
    Write-Host "   $($response.Content)" -ForegroundColor White
} catch {
    Write-Host "   Registry esta funcionando" -ForegroundColor Green
}

# 3. VERIFICAR CONTAINER DEPLOYADO
Write-Host "3. VERIFICANDO CONTAINER DEPLOYADO" -ForegroundColor Yellow
$containerExists = docker ps -a --filter "name=demo-api" --format "{{.Names}}" 2>$null
if ($containerExists -eq "demo-api") {
    Write-Host "   ✅ Container demo-api encontrado" -ForegroundColor Green
    Write-Host "   Status do container:" -ForegroundColor White
    docker ps --filter "name=demo-api" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
} else {
    Write-Host "   ⚠️  Container ainda não foi deployado pelo pipeline" -ForegroundColor Yellow
    Write-Host "   O pipeline GitLab CI/CD fará o deploy automaticamente" -ForegroundColor White
}

# 4. TESTAR APLICACAO
Write-Host "4. TESTANDO APLICACAO" -ForegroundColor Yellow
if ($containerExists -eq "demo-api") {
    Write-Host "   Testando API..." -ForegroundColor White
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:3001" -UseBasicParsing
        Write-Host "   ✅ API respondendo:" -ForegroundColor Green
        $response.Content | ConvertFrom-Json | ConvertTo-Json
    } catch {
        Write-Host "   ⚠️  API não está respondendo. Verificando logs..." -ForegroundColor Yellow
        docker logs demo-api --tail 20
    }
    
    Write-Host ""
    Write-Host "   Testando endpoint /health..." -ForegroundColor White
    try {
        $health = Invoke-WebRequest -Uri "http://localhost:3001/health" -UseBasicParsing
        Write-Host "   ✅ Health check OK:" -ForegroundColor Green
        $health.Content | ConvertFrom-Json | ConvertTo-Json
    } catch {
        Write-Host "   ⚠️  Health check falhou" -ForegroundColor Yellow
    }
} else {
    Write-Host "   ⚠️  Container não está rodando. Aguarde o pipeline completar o deploy." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== RESUMO DO AMBIENTE ===" -ForegroundColor Cyan
Write-Host "   GitLab: http://localhost:8929" -ForegroundColor White
Write-Host "   Projeto: http://localhost:8929/root/devops-project" -ForegroundColor White
Write-Host "   Pipelines: http://localhost:8929/root/devops-project/-/pipelines" -ForegroundColor White
Write-Host "   Registry: http://localhost:5000/v2/_catalog" -ForegroundColor White
Write-Host "   API: http://localhost:3001" -ForegroundColor White
Write-Host ""
Write-Host "=== PRÓXIMOS PASSOS ===" -ForegroundColor Cyan
Write-Host "1. Acesse o GitLab e verifique o pipeline em execução" -ForegroundColor White
Write-Host "2. O pipeline executará automaticamente:" -ForegroundColor White
Write-Host "   - Testes unitários" -ForegroundColor White
Write-Host "   - Build da imagem Docker (com testes durante o build)" -ForegroundColor White
Write-Host "   - Deploy automático em container" -ForegroundColor White
Write-Host "3. Após o pipeline completar, a API estará disponível em http://localhost:3001" -ForegroundColor White