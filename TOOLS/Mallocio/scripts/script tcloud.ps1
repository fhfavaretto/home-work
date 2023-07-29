# Caminho para o executável do Google Chrome
$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"

# URL do site que deseja abrir
$url = "https://tcloud.totvs.com.br/login"

# Email para preencher no campo
$email = "ricardo.souza@upduo.com.br"

# Parâmetros para abrir o Google Chrome em uma guia anônima e navegar até o URL especificado
$chromeArgs = "-incognito", $url

# Iniciar o Google Chrome em uma guia anônima
Start-Process -FilePath $chromePath -ArgumentList $chromeArgs

# Aguardar um pequeno intervalo de tempo para o Chrome abrir a guia
Start-Sleep -Seconds 2

# Enviar o email para o campo adequado no formulário
$wshell = New-Object -ComObject wscript.shell
$wshell.SendKeys($email)

# Aguardar um pequeno intervalo de tempo para que o email seja digitado
Start-Sleep -Milliseconds 500

# Pressionar a tecla Enter
$wshell.SendKeys("{ENTER}")

