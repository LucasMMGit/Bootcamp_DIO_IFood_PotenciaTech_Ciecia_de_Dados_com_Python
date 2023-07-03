# Desafio: Criando um sistema bancário

# Objetivo Geral: Criar um sistema bancário com as operações: sacar, depositar e visualizar extrato.

# Operação de depósito: Deve ser possível depositar valores positivos para a minha conta bancária. A v1 do projeto trabalha apenas com 1 usuário, dessa forma não precisamos nos preocupar em identificar qual é o número da agência e conta bancária. Todos os depósitos devem ser armazenados em uma variável e exibidos na operação de extrato.

# Operação de saque: O sistema deve permitir realizar 3 saques diários com limite máximo de R$ 500,00 por saque. Caso o usuário não tenha saldo em conta, o sistema deve exibir uma mensagem informando que não será possível sacar o dinheiro por falta de saldo. Todos os saques devem ser armazenados em uma variável e exibidos na operação de extrato.

# Operação de extrato: Essa operação deve listar todos os depósitos e saques realizados na conta. No fim da listagem deve ser exibido o saldo atual da conta. Os valores devem ser exibidos utilizando o formato R$ xxx.xx, exemplo: 1500.45 = R$ 1500.45

menu = """
Bem-vindo(a)! Digite a opção desejada abaixo:
[d] Depositar
[s] Sacar
[e] Extrato
[q] Sair
=> """

saldo = 0
LIMITE_VALOR_SAQUE = 500
extrato_ = ""
extrato = []
numero_saques = 0
LIMITE_NUMERO_DE_SAQUES = 3

while True:
    
    opcao = input(menu)

    if opcao == 'd':
        deposito = float(input("Informe o valor de depósito: "))
        if deposito > 0:
            saldo = saldo + deposito
            print(f"Deposito de R$ {deposito:.2f} realizado!")
            extrato.append(deposito)
            # extrato_ = extrato_ + f"Depósito: R$ {deposito:.2f}\n"
        else:
            print("Operação inválida, por favor selecione um valor maior do que 0.")

    elif opcao == 's':
        if numero_saques >= LIMITE_NUMERO_DE_SAQUES:
            print("Operação inválida. Limite de saques diários atingido.")
        else:
            saque = float(input("Informe o valor de saque: "))
            if saque > 0:
                if saque > LIMITE_VALOR_SAQUE:
                    print("Operação inválida. Valor acima do limite de saque.")
                else:
                    if saque <= saldo:
                        saldo = saldo - saque
                        extrato.append(-saque)
                        # extrato_ = extrato_ + f"Saque: R$ {saque:.2f}\n"
                        numero_saques = numero_saques + 1
                        print(f"Saque de R$ {saque:.2f} realizado!")
                    else:
                        print(f"Operação inválida. Saldo indisponível.")
            else:
                print("Operação inválida, por favor selecione um valor maior do que 0.")
    
    elif opcao == 'e':
        print("\n======================== EXTRATO ========================")
        if bool(extrato) == False:
            print(f"Sem movimentações na conta.")
            print(f"\nSaldo atual: R$ {saldo:.2f}")
        else:
            # print(extrato_)
            for i in range(len(extrato)):
                if extrato[i] > 0:
                    print(f"Operação de número {i+1}: Depósito de R$ {extrato[i]} realizado.")
                elif extrato[i] < 0:
                    print(f"Operação de número {i+1}: Saque de R$ {-extrato[i]} realizado.")
                else:
                    print("Erro! Por favor, contate o seu gerente!")
            # print(extrato)
            print(f"\nSaldo atual: R$ {saldo:.2f}")
        print("=========================================================")
    
    elif opcao == 'q':
        break

    else:
        print("Operação inválida, por favor selecione novamente a operação desejada.")
