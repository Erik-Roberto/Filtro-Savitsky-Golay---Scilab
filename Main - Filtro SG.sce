if exists('Yf') then
    resposta = messagebox("Limpar memória? Todas as variáveis e calculos serão perdidas", "modal", "info", ["Sim" "Não"])

    if resposta == 1 then
        clear
    end
end


clc

exec('Savitzky–Golay.sce',-1)
exec('Importar dados.sce',-1)

//Parâmetros===========================================================
//Para efeito de filtro: janela>grau
janela = 5 //Qtd. de pontos usados na suavização - DEVE SER ÍMPAR!
grau = 2   //Grau do polinômio usado na suavização

col_x = 1  //Coluna que contém a variável independente
col_y = 2  //Coluna que contém a variável dependente

//=====================================================================
Yf = 0

if ~exists('dados') then
    //Abrindo os dados do arquivo selecionado:
    dados = Abrir()
end


//Garantindo que a qtd de pontos em x seja igual a y:
fim = ultimo_valor(dados(:,col_x), dados(:,col_y))

//Separando os dados em dois vetores separados
x = dados(1:fim, col_x)
y = dados(1:fim, col_y)

//Aplicando o filtro:
Yf = Filtro_SG(janela, grau, x, y, 0)

//A função filtro segue a seguinte ordem:
//Filtro_SG(janela, grau, dados_x, dados_y, ordem, bordas)
//Agora, existem 2 novos parâmetros no filtro, ordem e bordas.
//O parâmetro odem define a ordem da derivada que deseja-se obter, sendo
// o valor 0 referente a função filtrada, 1 a primeira derivada, ...
//O parâmetro borda define como tratar os dados nas pontas, sendo um parâmetro
//opcional, como valor padrão de True (T), caso queira desligar o tratamento
//das bordas é só colocar 'F' como ultimo parâmetro, a resposta ficara sem as
//bordas e a rsposta terá janela-1 pontos a menos.

//Existe uma nova função Derivada(dados_x, dados_y, ordem) que calcula
//a derivada dos dados com base em diferenças


//Salvando os dados em um arquivo .csv
nome_arq = 'Dados filtrados'
//Exportar(nome, x, y, Yf)

//Obs 1:
//Deixei a função Exportar comentada só para evitar ficar criando
//arquivos toda vez que rodar o programa. Quando quiser salvar os dados
//você pode só descomentar a linha e rodar dnv ou colar no console
//e executar a instrução de lá

//Obs 2:
//A função exportar suporta qualquer quantidade de argmentos de entrada
//desde que você siga a ordem: nome_arquivo, dados1, dados2, ...
//Os argumentos contendo os dados podem ser escalares ou vetores coluna
//Vetores linha ou matrizes gerarão erros
//Posso mudar isso escrevendo uma função mais robusta caso 
//você ache necessário


//Plotando dados:
    //Plot dos dados originais:
    //plot(x,y, '.')
    
    //Plot do filtro:
    n = (janela-1)/2
    i = n+1
    f = size(x)(1)-n
    //plot(x(i:f),Yf)
    
    //Plot dados originais + filtro
    plot(x,y,'.-',x,Yf,'red')

//Obs:
//Eu deixei as linhas de plot para facilitar e mostrar que o filtro
//funcionou, ai fica mais fácil brincar com os parâmetros.
//Mas se não quiser que os gráficos fiquem aparecendo é só comentar 
//ou apagar as linhas do plot

