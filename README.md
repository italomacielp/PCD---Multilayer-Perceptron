# PCD - Multilayer Perceptron
Análise de Perfilamento, escalabilidade e paralelização do modelo Multilayer Perceptron

# Perfilamento
É o processo em que é feito a análise de desempenho do programa em execução. No relatório é retornado variáveis como:
- Quantidade de chamadas de cada função. 
- Percentual em relação ao tempo de execução total do sistema.

# Comandos 
Para executar as principais operações de perfilamento, autovetorização é utilizado o Makefile.
- Para apagar o arquivo executável criado:
make clean
- Gerar os arquivos objeto com código paralelizado:
make PARALLEL=1
- Gerar os arquivos objeto do código não paralelizado:
make
- Executar o perfilamento:
make profile
- Executar a autovetorização:
make vectorization

# Pascal Suíte
É necessário executar os seguintes comandos para gerar as matrizes que demonstram o desempenho do código e utilizar na geração dos mapas de calor.
- Arquivo de configuração para executar e gerar o arquivo .json utilizado para gerar os gráficos:
sbatch pascalanalyzer_job.sh
- Visualizar o arquivo de resultado:
cat result.json
- Gerar o mapa de calor no seguinte link:
https://pascalsuite.imd.ufrn.br/
- Comando para baixar/instalar o pascalSuite:
wget -c https://gitlab.com/lappsufrn/pascal-releases/-/archive/master/pascal-releases-master.zip
- Descompactar o arquivo zip:
unzip pascal-releases-master.zip

# Conversão arquivo .dot (Perfilamento) para .png
- Exemplo: dot -Tpng dotp_gprof_6.dot -o size_6.png

