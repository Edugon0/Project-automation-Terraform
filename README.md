# 🚀 Projeto: Automatizando a criação de EC2 e ECR usando Terraform

## 🎯 Visão Geral

### O que foi construido:
Foi criado arquivos HCL para automatizar o processo manual de criação e configuração de instancia EC2 e ECR, tornando algo mais pratico e facil em levantar uma instancia, e ainda criando um S3 bucket para armazenar na nuvem o arquivo HCL.

### Por que isso é importante?
- **Trabalho manual**: O caos dos cliques manuais e como o Terraform resolve isso.
- **Provisionamento**: Declarar e provisionar recursos AWS.
- **Versionamento**: Manter a infra reproduzível e versionada.
- **Importancia do IaC (Infrastructure as Code)**: IaC é essencial para qualquer pipeline DevOps moderno.

---

## 🔧 Pré-requisitos

### Ferramentas Necessárias

#### 1. **Terraform**
- **Windows/Mac/Linux**: Baixe em [terraform.com/terraform/tutorials-install-terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

#### 2. **AWS CLI**
Instale seguindo a [documentação oficial](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

Para verificar:
```bash
aws --version
```

#### 3. **Conta AWS**
- Crie uma conta gratuita em [aws.amazon.com](https://aws.amazon.com)
- ⚠️ **Importante**: Alguns recursos podem gerar custos. Use o Free Tier quando possível

#### 4. **Editor de Código**
- Recomendado: [Visual Studio Code](https://code.visualstudio.com/)

#### 5. **Chave SSH**
Necessária para acessar a instância EC2 após criada. Gere o par de chaves com o comando:

```bash
ssh-keygen -t rsa -b 4096 -C "seu-email@exemplo.com"
```

O comando vai perguntar onde salvar:
```
Enter file in which to save the key: /home/seu-usuario/chaves/site-prod-key
```

Resultado: dois arquivos gerados:
```
site-prod-key      ← chave PRIVADA (nunca compartilhe!)
site-prod-key.pub  ← chave PÚBLICA (referenciada no Terraform)
```

Antes de usar o SSH, ajuste a permissão da chave privada:
```bash
chmod 400 /home/seu-usuario/chaves/site-prod-key
```

> ⚠️ **Importante**: Nunca suba a chave privada pro GitHub. Adicione ao `.gitignore` se necessário.

---

### Estrutura do Projeto

```
├── main.tf
├── ec2.tf
├── ecr.tf
├── backend.tf
├── provider.tf
└── .terraform.lock.hcl  → gerado após o comando "terraform init"
```

---

## 🛠️ Como Startar o Terraform

### 1. Clone o repositório
```bash
git clone https://github.com/Edugon0/Project-automation-Terraform.git
cd Project-automation-Terraform
```

### 2. Inicialize o Terraform
O comando `init` baixa os providers e prepara o ambiente:
```bash
terraform init
```

### 3. Visualize o plano de execução
Veja quais recursos serão criados/modificados antes de aplicar:
```bash
terraform plan
```

### 4. Aplique a infraestrutura
Cria os recursos na nuvem:
```bash
terraform apply
```

Digite `yes` quando solicitado para confirmar.

### 5. Acesse a instância EC2 via SSH
Após o `terraform apply`, pegue o IP público da instância no console AWS e conecte:

```bash
ssh -i /home/seu-usuario/chaves/site-prod-key ubuntu@<IP-DA-INSTANCIA>
```

> 💡 **Dica**: O IP público da instância pode ser encontrado em:
> `Console AWS → EC2 → Instances → sua instância → Public IPv4 address`

### 6. Destrua a infraestrutura (quando necessário)
Remove todos os recursos criados:
```bash
terraform destroy
```

> ⚠️ **Lembre-se**: Sempre destrua os recursos ao terminar os estudos para evitar cobranças desnecessárias!

---

## 🔄 Fluxo de Trabalho

```
terraform init → terraform plan → terraform apply → ssh -i chave ubuntu@IP
```

---

## 📝 Observações
- Sempre execute `terraform plan` antes do `apply` para revisar as mudanças
- Nunca commite arquivos `.tfstate` ou `.tfvars` com credenciais no GitHub
- Adicione ao `.gitignore`:

```
*.tfstate
*.tfstate.backup
*.tfvars
.terraform/
```

---

## 🎓 O que foi Aprendido

✅ Criar e configurar uma instância EC2 com Terraform  
✅ Provisionar um ECR para armazenar imagens Docker  
✅ Criar Security Groups com regras de entrada e saída  
✅ Atrelar um IAM Profile à EC2 de forma segura  
✅ Substituir cliques manuais por Infraestrutura como Código (IaC)  
✅ Gerar e configurar chave SSH para acesso seguro à EC2  

---

## 📚 Recursos Adicionais
- [Documentação Terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS ECR Documentation](https://docs.aws.amazon.com/ecr/)
- [AWS EC2 User Guide](https://docs.aws.amazon.com/ec2/)
- [Referencia do projeto original](https://www.youtube.com/watch?v=G4sAlfb0gFg&t=3027s)
