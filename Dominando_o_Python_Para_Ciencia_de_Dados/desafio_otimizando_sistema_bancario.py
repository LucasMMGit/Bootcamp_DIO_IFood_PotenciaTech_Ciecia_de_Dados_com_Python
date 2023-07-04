# Desafio 2: Otimizando o Sistema Bancário com Funções Python

# Objetivo Geral: "Separar as funções existentes de saque, depósito e extrato em funções. Criar duas novas funções: cadastrar usuário (cliente) e cadastrar conta bancária."

# Saque: "A função saque deve receber os argumentos apenas por nome (keyword only). Sugestão de argumentos: saldo, valor, extrato, limite, numero_saques, limite_saques. Sugestão de retorno: saldo e extrato."

# Depósito: "A função depósito deve receber os argumentos apenas por posição (positional only). Sugestão de argumentos: saldo, valor, extrato. Sugestão de retorno: saldo e extrato."

# Extrato: "A função extrato deve receber os argumentos por posição e nome (positional only e keyword only). Argumentos posicionais: saldo, argumentos nomeados: extrato."

# Criar usuário (Cliente): "O programa deve armazenar os usuários em uma lista, um usuário é composto por: nome, data de nascimento, CPF e endereço. O endereço é uma string com formato: logradouro, numero - bairro - cidade/sigla_estado. CPF somente em numeros. Não podemos cadastrar 2 usuários com o mesmo CPF."
# (???) - O professor falou para criar em lista porém disse para criar as coisas em chave-valor. Chave-valor não é lista e sim dicionário!

# Criar conta corrente: "O programa deve armazenar contas em uma lista, uma conta é composta por: agência, número da conta e usuário. O número da conta é sequencial, iniciando em 1. O número da agência é fixo: "0001". O usuário pode ter mais de uma conta, mas uma conta pertence a somente um usuário."
# (???) - Novamente ele diz lista porém um dicionário faz muito mais sentido ser usado!

# Dica: "Para vincular um usuário a uma conta, filtre a lista de usuários buscando o número do CPF informado para cada usuário da lista."

#------------------------------------------------------------------------
# Desafio Passado: Criando um sistema bancário

# Objetivo Geral: "Criar um sistema bancário com as operações: sacar, depositar e visualizar extrato."

# Operação de depósito: "Deve ser possível depositar valores positivos para a minha conta bancária. A v1 do projeto trabalha apenas com 1 usuário, dessa forma não precisamos nos preocupar em identificar qual é o número da agência e conta bancária. Todos os depósitos devem ser armazenados em uma variável e exibidos na operação de extrato."

# Operação de saque: "O sistema deve permitir realizar 3 saques diários com limite máximo de R$ 500,00 por saque. Caso o usuário não tenha saldo em conta, o sistema deve exibir uma mensagem informando que não será possível sacar o dinheiro por falta de saldo. Todos os saques devem ser armazenados em uma variável e exibidos na operação de extrato."

# Operação de extrato: "Essa operação deve listar todos os depósitos e saques realizados na conta. No fim da listagem deve ser exibido o saldo atual da conta. Os valores devem ser exibidos utilizando o formato R$ xxx.xx, exemplo: 1500.45 = R$ 1500.45"
#------------------------------------------------------------------------


def menu():
    menu = """\n
    ================ MENU ================
    [d]  Deposito
    [s]  Saque
    [e]  Extrato
    [nu] Novo usuário
    [lu] Listar usuários
    [nc] Nova conta
    [lc] Listar contas
    [q]  Sair
    => """
    return input(menu)


def depositar(saldo, valor, extrato, /):

    if valor > 0:
        saldo = saldo + valor
        extrato.append(valor)
        print("\n===== Depósito realizado com sucesso! =====")
    else:
        print("\n##### Operação falhou! O valor informado é inválido. #####")

    return saldo, extrato


def sacar(*, saldo, valor, extrato, limite, numero_saques, limite_saques):

    excedeu_saldo = valor > saldo
    excedeu_limite = valor > limite
    excedeu_saques = numero_saques >= limite_saques

    if excedeu_saldo:
        print("\n##### Operação falhou! Saldo insuficiente! #####")

    elif excedeu_limite:
        print("\n##### Operação falhou! Limite de saque excedido! #####")

    elif excedeu_saques:
        print("\n##### Operação falhou! Número máximo de saques excedido! #####")

    elif valor > 0:
        saldo = saldo - valor
        extrato.append(-valor)
        numero_saques = numero_saques + 1
        print("\n===== Saque realizado com sucesso! =====")

    else:
        print("\n##### Operação falhou! O valor informado é inválido. #####")

    return saldo, extrato, numero_saques


def exibir_extrato(saldo, /, *, extrato):
    print("\n======================== EXTRATO ========================")
    if bool(extrato) == False:
        print(f"Sem movimentações na conta.")
    else:
        for i in range(len(extrato)):
            if extrato[i] > 0:
                print(f"Operação {i+1}: Depósito:\tR$ {extrato[i]}")
            elif extrato[i] < 0:
                print(f"Operação {i+1}: Saque:\tR$ {-extrato[i]}")
            else:
                print("Erro! Por favor, contate o seu gerente!")

    print(f"\nSaldo:\tR$ {saldo:.2f}")
    print("=========================================================")


def criar_usuario(usuarios):
    cpf = input("Informe o CPF (somente número): ")
    usuario = filtrar_usuario(cpf, usuarios)

    # if usuario:
    if bool(usuario) == True:
        print("\n##### Usuário já existente! #####")
        return

    nome = input("Informe o nome completo: ")
    data_nascimento = input("Informe a data de nascimento (dd-mm-aaaa): ")
    endereco = input("Informe o endereço (logradouro, nro - bairro - cidade/sigla estado): ")

    usuarios.append({"nome": nome, "data_nascimento": data_nascimento, "cpf": cpf, "endereco": endereco})

    print("===== Usuário criado com sucesso! =====")


def filtrar_usuario(cpf, usuarios):

    # usuarios_filtrados = [usuario for usuario in usuarios if usuario["cpf"] == cpf]
    usuarios_filtrados = []
    for usuario in usuarios:
        if usuario["cpf"] == cpf:
            # usuarios_filtrados.append(usuario)
            usuarios_filtrados = [usuario]
    
    # return usuarios_filtrados[0] if usuarios_filtrados else None
    if bool(usuarios_filtrados) == True:
        return usuarios_filtrados[0]
    else:
        return None


def criar_conta(agencia, numero_conta, usuarios):
    cpf = input("Informe o CPF do usuário: ")
    usuario = filtrar_usuario(cpf, usuarios)

    # if usuario:
    if bool(usuario) == True:
        print("\n=== Conta criada com sucesso! ===")
        return {"agencia": agencia, "numero_conta": numero_conta, "usuario": usuario}

    print("\n##### Usuário não encontrado, fluxo de criação de conta encerrado! #####")


def listar_contas(contas):
    if bool(contas) == True:
        for conta in contas:
            linha = f"""\
Agência:\t{conta['agencia']}
C/C:\t\t{conta['numero_conta']}
Titular:\t{conta['usuario']['nome']}
"""
            print("=" * 100)
            print(linha)
    else:
        print("Não há contas cadastradas!")
    print("=" * 100)


def listar_usuarios(usuarios):
    print(usuarios)


def main():
    LIMITE_SAQUES = 3
    AGENCIA = "0001"

    saldo = 0
    limite = 500
    extrato = []
    numero_saques = 0
    usuarios = []
    contas = []

    while True:
        opcao = menu()

        if opcao == "d":
            valor = float(input("Informe o valor do depósito: "))
            saldo, extrato = depositar(saldo, valor, extrato)

        elif opcao == "s":
            valor = float(input("Informe o valor do saque: "))
            saldo, extrato, numero_saques = sacar(
                saldo=saldo,
                valor=valor,
                extrato=extrato,
                limite=limite,
                numero_saques=numero_saques,
                limite_saques=LIMITE_SAQUES,
            )

        elif opcao == "e":
            exibir_extrato(saldo, extrato=extrato)

        elif opcao == "nu":
            criar_usuario(usuarios)

        elif opcao == "nc":
            numero_conta = len(contas) + 1
            conta = criar_conta(AGENCIA, numero_conta, usuarios)

            if conta:
                contas.append(conta)

        elif opcao == "lc":
            listar_contas(contas)

        elif opcao == "lu":
            listar_usuarios(usuarios)

        elif opcao == "q":
            break

        else:
            print("Operação inválida, por favor selecione novamente a operação desejada.")


main()