# **DevFinOps** - Deleção de EBS desatachados

## Objetivo
Automatização do deploy utilizando Terraform dos seguintes recursos:
  - Bucket S3
  - IAM Role
  - Lambda Function

### Conteúdo do Projeto
Módulo terraform automatizando o deploy de recursos AWS para automatização do processo de deleção de ebs desatachados no ambiente e script feito em python, consumindo os serviços SNS, EBS, Lambda e S3

### Como utilizar o repositório
  - Faca um clone do repositório
  - Entre dentro do repositório
  - Inicialize o módulo terraform com "terraform init"
  - Leia a documentação interna do módulo para entende-lo e ajustá-lo
  - Verifique se há necessidade de ajustar as informações do módulo antes de executá-lo


### Resume
<p>Para este laboratório não se esqueça de:</p>

  - Criar a instância para attachar os volumes
  - Verificar a role e suas permissões para o CloudWatch, EventBridge e EC2
  - Criar o agendamento da periodicidade de execução da sua lambda function no EventBridge com a expressão CRON:<b> 0 20 1,15 * ? * </b> = <b>Rodar dia 1 e dia 15 do mês.</b>
  - Aumentar o valor do timeout da lambda function para 1 min para caso sua função demore na execução
  - Editar 'Trust relationships' para que o EventBridge assuma a role
  -  🚨 Ao final dos estudos: <b>Desprovisionar e excluir todos os recursos gerados nesse laborátório para não incorrer em custos na sua conta da AWS;</b>

<figure>
<img src='./resume.png' alt="resumo do laboratório">
<figcaption> Timeline do Laboratório</figcaption>
</figcaption>

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines, engineering expectations, and pull request guidance for this repository.
