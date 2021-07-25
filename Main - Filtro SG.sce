clear
clc

exec('Savitzky–Golay.sce',-1)
exec('Importar dados.sce',-1)

//Parâmetros===========================================================
janela = 5 //Qtd. de pontos usados na suavização - DEVE SER ÍMPAR!
grau = 3   //Grau do polinômio usado na suavização

col_x = 1  //Coluna que contém a variável independente
col_y = 2  //Coluna que contém a variável dependente
//=====================================================================

dados = Abrir()

fim = ultimo_valor(dados(:,col_x), dados(:,col_y))

x = dados(1:fim, col_x)
y = dados(1:fim, col_y)

Yf = Filtro_SG(janela, grau, x, y)
