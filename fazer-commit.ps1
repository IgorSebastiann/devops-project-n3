Write-Host "=== FAZENDO COMMIT DAS MUDANÇAS ===" -ForegroundColor Cyan
Write-Host ""

# Navegar para o diretório raiz do projeto
$projectRoot = "C:\Users\$env:USERNAME\Desktop\devops-project"
cd $projectRoot

Write-Host "1. Fazendo commit no diretório app/..." -ForegroundColor Yellow
cd app
if (Test-Path ".git") {
    Write-Host "   Adicionando mudanças no app..." -ForegroundColor White
    git add .
    git commit -m "feat: Implementação completa para N3" -m "- Adicionados testes unitários reais com Jest`n- Dockerfile atualizado para executar testes durante build`n- Pipeline GitLab CI/CD configurado (.gitlab-ci.yml)`n- Removido .drone.yml`n- package.json atualizado com Jest e Supertest`n- app.js refatorado para suportar testes"
    Write-Host "   ✅ Commit no app realizado!" -ForegroundColor Green
} else {
    Write-Host "   ⚠️  Diretório app não é um repositório Git" -ForegroundColor Yellow
}
cd ..

Write-Host ""
Write-Host "2. Adicionando todos os arquivos no repositório principal..." -ForegroundColor Yellow
git add .

Write-Host ""
Write-Host "3. Verificando arquivos que serão commitados..." -ForegroundColor Yellow
git status

Write-Host ""
Write-Host "4. Fazendo commit no repositório principal..." -ForegroundColor Yellow
git commit -m "refactor: Migração completa de Gitea para GitLab (N3)" -m "- Substituído Gitea por GitLab CE (versão 16.11.0)`n- Removido Drone CI, adicionado GitLab CI/CD integrado`n- Adicionado GitLab Runner para execução de pipelines`n- docker-compose.yml atualizado com GitLab e rede compartilhada`n- Scripts PowerShell atualizados`n- README.md completamente reescrito`n- Adicionados guias de solução de problemas`n- Versões específicas para maior estabilidade"

Write-Host ""
Write-Host "✅ Commits realizados com sucesso!" -ForegroundColor Green
Write-Host ""
Write-Host "5. Verificando commits..." -ForegroundColor Cyan
git log --oneline -2

Write-Host ""
Write-Host "6. Próximos passos:" -ForegroundColor Cyan
Write-Host "   - Se o GitLab estiver rodando, execute: .\configurar-git.ps1" -ForegroundColor White
Write-Host "   - Ou faça push manualmente: git push origin main" -ForegroundColor White
Write-Host ""

