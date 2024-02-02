Lab 1
Usando variáveis:
- Criar VPC com CIDR 10.0.0.0/16 *
- Criar 2 Subnets Públicas /24 dinamicamente baseado no valor do CIDR da VPC. *
- Criar 2 Subnets Privadas com Nat Gateway /24 dinamicamente baseado no valor do CIDR da VPC. *


- Usando count, criar uma EC2 do tipo Ubuntu em cada subnet privada com Nat Gateway, instalar Nginx e criar index.html que mostre a seguinte informação:
   "Olá. Sou o servidor <instance id> and estou na AZ <az id>."
   O valor de <instance id> deve ser buscado através de meta-data enquanto o AZ, através do template_file no Terraform. *
- Criar App Load Balancer na subnet pública e anexar os dois servidores à ele.
- EC2 deve permitir tráfego HTTP somente do LB. LB deve receber tráfego HTTP de qualquer origem.
- Enviar para o GitHub em um diretório chamado Lab1. Não deve ser enviado os arquivos tfstate (adicionar no .gitignore)
