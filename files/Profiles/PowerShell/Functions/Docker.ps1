# Docker - These functions include general Docker commands that might be useful
function Clear-Docker { docker image prune -a --filter 'until=12h'; docker system prune }