# Projeto de Infraestrutura como Código (IaC) - AWS

## Descrição do Projeto

Este projeto implementa uma infraestrutura baseada na AWS utilizando o Terraform como ferramenta de IaC. A solução é composta pelos seguintes componentes:

- **API Gateway**: Gerencia consultas síncronas.
- **Lambda Functions**:
  - `queryLambda`: Processa consultas síncronas.
  - `commandLambda`: Processa comandos provenientes de mensagens na fila SQS.
- **SQS Queue**: Gerencia mensagens assíncronas.
- **CloudWatch Logs**: Centraliza os logs das funções Lambda.
- **IAM Roles**: Gerencia permissões específicas para os componentes.

## Estrutura do Projeto

```
terraform/
├── main.tf          # Recursos principais do Terraform
├── variables.tf     # Variáveis configuráveis
├── providers.tf     # Configuração do provider AWS
├── outputs.tf       # Saídas de recursos para fácil acesso
lambdas/
├── queryLambda.py  # Código da função queryLambda
├── commandLambda.py # Código da função commandLambda
docs/
├── arquitetura.png  # Diagrama da arquitetura (PlantUML)
├── README.md        # Este arquivo
```

---

## Pré-requisitos

Antes de começar, você precisará:

1. **Terraform instalado**:

   - Faça o download e instale o Terraform em: [https://www.terraform.io/downloads](https://www.terraform.io/downloads)
2. **Configuração de credenciais AWS**:

   - Configure as credenciais AWS no seu ambiente. Por exemplo:
     ```bash
     aws configure

     C:\Users\Mikasa TU Cassa>aws configure
     AWS Access Key ID [****************BCVN]:
     AWS Secret Access Key [****************4Ya6]:
     Default region name [us-east-1]:
     Default output format [json]:
     ```
   - Certifique-se de que a conta possui permissões para gerenciar:
     - API Gateway
     - Lambda
     - SQS
     - IAM
     - CloudWatch
3. **Python instalado**:

   - Versão 3.9 ou superior.
   - Instale o Python em: [https://www.python.org/downloads/](https://www.python.org/downloads/)

---

## Configuração e Deploy

### 1. Clone o repositório

Clone este repositório localmente:

```bash
git clone https://github.com/LimaAnthonyY/finalProjectSRE
cd finalProjectSRE
```

### 2. Inicialize o Terraform

Entre na pasta `terraform/`:

```bash
cd terraform
terraform init
```

### 3. Valide a configuração

Verifique a sintaxe e as configurações:

```bash
terraform validate
```

### 4. Planeje o deployment

Visualize o que será criado no ambiente:

```bash
terraform plan
```

### 5. Aplique as mudanças

Realize o deploy na AWS:

```bash
terraform apply
```

Confirme com `yes` quando solicitado.

---

## Testes

### 1. Teste da `queryLambda` (Síncrono)

- Copie o endpoint do API Gateway gerado pelo Terraform.
- Faça uma requisição HTTP ao endpoint:

  ```bash
  curl <API_GATEWAY_ENDPOINT>

  curl https://7g236oq7t4.execute-api.us-east-1.amazonaws.com/query
  ```
- A resposta esperada é:

  ```json
  {"message": "Consulta processada com sucesso!"}
  ```

### 2. Teste da `commandLambda` (Assíncrono)

- Publique uma mensagem na fila SQS:

  ```bash
  aws sqs send-message --queue-url <SQS_QUEUE_URL> --message-body "Teste de comando"

  aws sqs send-message --queue-url https://sqs.us-east-1.amazonaws.com/533267099671/command-queue --message-body "Teste de comando"
  ```
- Verifique os logs no CloudWatch para confirmar o processamento:

  - Navegue até o CloudWatch no console AWS.
  - Acesse os logs do `commandLambda`.

---

## Variáveis Configuráveis

O arquivo `variables.tf` contém as variáveis necessárias para personalizar o deploy. Exemplos de variáveis configuráveis incluem:

- **queue_name**: Nome da fila SQS.
- **lambda_runtime**: O tempo de execução das funções Lambda (por exemplo, `python3.9`).
- **api_gateway_name**: Nome da API do API Gateway.

Exemplo de `variables.tf`:

```hcl
variable "queue_name" {
  description = "Nome da fila SQS"
  default     = "command-queue"
}

variable "lambda_runtime" {
  description = "Tempo de execução da Lambda"
  default     = "python3.9"
}

variable "api_gateway_name" {
  description = "Nome da API Gateway"
  default     = "query-api"
}
```

---

## Arquivos de Saída

No arquivo `outputs.tf`, você encontrará as saídas dos recursos criados, como o URL do API Gateway e o ARN da fila SQS, para facilitar o acesso após o deploy.

Exemplo de `outputs.tf`:

```hcl
output "api_gateway_url" {
  description = "URL do endpoint do API Gateway"
  value       = aws_api_gateway_deployment.query_api.invoke_url
}

output "sqs_queue_arn" {
  description = "ARN da fila SQS"
  value       = aws_sqs_queue.command_queue.arn
}
```

---

## Limpeza de Recursos

Para evitar cobranças na AWS, remova os recursos após os testes:

```bash
terraform destroy
```

Confirme com `yes` quando solicitado.

---

## Autor

- **Anthony Lima Campelo**
- **Email**: 10442330@mackenzista.com.br
- **LinkedIn**: [https://www.linkedin.com/in/limaanthonyy/](https://www.linkedin.com/in/limaanthonyy/)

---

## Licença

Este projeto está licenciado sob a [Licença MIT](LICENSE).

---
