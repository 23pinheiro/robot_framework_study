*** Settings ***
Library     RequestsLibrary
Library     String
Library     Collections


*** Test Cases ***
Performando os primeiros passos de robot
    Criar um novo email aleatorio
    Criar um nome aleatorio
    Cadastrando um usuario na serveRest
    Conferir se o usuario foi cadastrado corretamente

# Solicitar os dados do meu usuário
# Get Request Test
#    Create Session    google    http://www.google.com

#    ${resp_google}=    GET On Session    google    /    expected_status=200
#    ${resp_json}=    GET On Session    jsonplaceholder    /posts/1

#    Should Be Equal As Strings    ${resp_google.reason}    OK
#    Dictionary Should Contain Value    ${resp_json.json()}    sunt aut facere repellat provident

# Post Request Test
#    &{data}=    Create dictionary    title=Robotframework requests    body=This is a test!    userId=1
#    ${resp}=    POST On Session    jsonplaceholder    /posts    json=${data}    expected_status=anything

#    Status Should Be    201    ${resp}


*** Keywords ***
# Criando um usuario com email aleatorio.
Criar um novo email aleatorio
    ${PALAVRA_ALEATORIA}    Generate Random String    length=4    chars=[LETTERS]
    ${PALAVRA_ALEATORIA}    Convert To Lower Case    ${PALAVRA_ALEATORIA}
    Set Test Variable    ${EMAIL_TEST}    ${PALAVRA_ALEATORIA}@gmail.com
    Log To Console    ${EMAIL_TEST}
# Criar um dicionario formata os dados abaixo em formato json na hora enviar um body    para API

Criar um nome aleatorio
    ${NOME_ALEATORIO}    Generate Random String    length=6    chars=[LETTERS]
    ${NOME_ALEATORIO}    Convert To Lower Case    ${NOME_ALEATORIO}
    Log To Console    ${NOME_ALEATORIO}

Cadastrando um usuario na serveRest
    ${body}    Create Dictionary
    ...    nome=Germano Brendo
    ...    email=${EMAIL_TEST}
    ...    password=1234
    ...    administrador=true
    Log    ${body}
    Criar sessao na serveRest    # chamando a keyword criada abaixo
    ${resposta}    POST On Session
    ...    alias=serveRest
    ...    url=/usuarios    # Para este caso é utilizado o endpoint da chamada em que esta sendo executada
    ...    json=${body}    # convertendo o    body acima para json.
    Log    ${resposta.json()}
    Set Test Variable    ${RESPOSTA}    ${resposta.json()}
    # Dictionary Should Contain Value    ${resposta.json()}
# Criando uma seção na API

Criar sessao na serveRest
# Quando se cria a seção deve-se apenas apontar a URL base.
    # O header abaixo foi inserido devido ao ser pre requisito para o inicio    de seção. Ele foi invocado novamente dentro de Create session, conforme abaixo.
    ${header}    Create Dictionary
    ...    accept=application/json
    ...    Content-Type=application/json
    Create Session    alias=serveRest    url=https://serverest.dev    headers=${header}

Conferir se o usuario foi cadastrado corretamente
    Log    ${RESPOSTA}
    Dictionary Should Contain Item    ${RESPOSTA}    message    Cadastro realizado com sucesso
# A Keyword acima requer 3 argumentos, a variavel que foi setada como global, a chave e o mensagem.
