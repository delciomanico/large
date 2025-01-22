# install-project.ps1
# Script para instalar ferramentas e dependências de um projeto Node.js no Windows

# Caminho do arquivo de log para registrar erros e informações
$logPath = "$env:USERPROFILE\Desktop\install-log.txt"

# Função para exibir mensagens no console e registrar no log
function Write-Message {
    param (
        [string]$message,
        [string]$color = "White"
    )
    Write-Host $message -ForegroundColor $color
    Add-Content -Path $logPath -Value $message
}

# Função para verificar se um comando está disponível
function Command-Exists {
    param ([string]$command)
    return (Get-Command $command -ErrorAction SilentlyContinue) -ne $null
}

# Iniciar log
Write-Message "=== Início da instalação do projeto Node.js ===" "Yellow"

# Verificar e instalar o Chocolatey
Write-Message "Verificando se o Chocolatey está instalado..." "Yellow"
if (!(Command-Exists choco)) {
    Write-Message "Chocolatey não encontrado. Instalando o Chocolatey..." "Yellow"
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    if (!(Command-Exists choco)) {
        Write-Message "Erro: Falha ao instalar o Chocolatey." "Red"
        exit 1
    }
} else {
    Write-Message "Chocolatey já está instalado." "Green"
}

# Verificar e instalar o Node.js
Write-Message "Verificando se o Node.js está instalado..." "Yellow"
if (!(Command-Exists node)) {
    Write-Message "Node.js não encontrado. Instalando Node.js..." "Yellow"
    choco install nodejs -y
    if (!(Command-Exists node)) {
        Write-Message "Erro: Falha ao instalar o Node.js." "Red"
        exit 1
    }
} else {
    Write-Message "Node.js já está instalado." "Green"
}

# Verificar e instalar o Git
Write-Message "Verificando se o Git está instalado..." "Yellow"
if (!(Command-Exists git)) {
    Write-Message "Git não encontrado. Instalando Git..." "Yellow"
    choco install git -y
    if (!(Command-Exists git)) {
        Write-Message "Erro: Falha ao instalar o Git." "Red"
        exit 1
    }
} else {
    Write-Message "Git já está instalado." "Green"
}

# Verificar e instalar o MongoDB
Write-Message "Verificando se o MongoDB está instalado..." "Yellow"
if (!(Test-Path -Path "C:\Program Files\MongoDB\Server")) {
    Write-Message "MongoDB não encontrado. Instalando MongoDB..." "Yellow"
    choco install mongodb --version=5.0.5 -y
    if (!(Test-Path -Path "C:\Program Files\MongoDB\Server")) {
        Write-Message "Erro: Falha ao instalar o MongoDB." "Red"
        exit 1
    }
} else {
    Write-Message "MongoDB já está instalado." "Green"
}

# Configurar o MongoDB para rodar como um serviço do Windows
Write-Message "Configurando o MongoDB como um serviço do Windows..." "Yellow"
$mongoServiceName = "MongoDB"
if (!(Get-Service -Name $mongoServiceName -ErrorAction SilentlyContinue)) {
    & "C:\Program Files\MongoDB\Server\5.0\bin\mongod.exe" --config "C:\Program Files\MongoDB\Server\5.0\mongod.cfg" --install
    Start-Service -Name $mongoServiceName
    Write-Message "MongoDB configurado e iniciado como serviço." "Green"
} else {
    Write-Message "O serviço MongoDB já está configurado." "Green"
}

# Clonar o repositório do projeto (substitua pelo link do repositório do projeto)
$repoUrl = "https://github.com/usuario/projeto.git"  # Substitua pelo link do repositório
$projectFolder = "$env:USERPROFILE\projeto" # Caminho onde o projeto será clonado

Write-Message "Clonando o repositório do projeto..." "Yellow"
if (!(Test-Path -Path $projectFolder)) {
    git clone $repoUrl $projectFolder
    if (!(Test-Path -Path $projectFolder)) {
        Write-Message "Erro: Falha ao clonar o repositório." "Red"
        exit 1
    }
} else {
    Write-Message "O repositório já foi clonado." "Green"
}

# Navegar para a pasta do projeto e instalar as dependências
Write-Message "Instalando as dependências do projeto com npm install..." "Yellow"
cd $projectFolder
npm install | Tee-Object -FilePath $logPath -Append

Write-Message "Instalação concluída com sucesso!" "Green"
Write-Message "=== Fim da instalação do projeto Node.js ===" "Yellow"
