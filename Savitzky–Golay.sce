function Y = Filtro_SG(janela, grau, dados_x, dados_y)
    //Função responsável por aplicar o filtro nos dados
    //Verifica se os dados são adequados para as condições do filtro e 
    //calcula os coeficientes com base no grau e janela escolhidos,
    //na versão atual um set de n pontos, aplicados a um filtro com
    //janela m, resulta em um set de n-m+1 pontos.
    
    if Verificar_caso(dados_x) == 1 then
        disp('O espaçamento em x não é constante')
        Y = 0
        resume
    end
    
    n = (janela - 1)/2       //Pontos ao redor do centro
    n_pts = size(dados_x)(1) //Quantidade de pontos nos dados
    i_ini = 1 + n            //Indice inicial
    i_fin = n_pts - n        //Indice final
    
    //Calculando os coeficientes:
    h = Mudanca_variavel(janela) //Mudança de var. p/ calc. dos coef.
    J = Vandermonde(h, grau)
    C = inv(J'*J)*J'
    a0 = C(1,:)                 //Somente a0 é utilizado no filtro
    
    Y = dados_y(i_ini:i_fin)
    
     //Aplicando o filtro:
    for i=i_ini:i_fin
        Y(i-n) = a0*dados_y(i-n:i+n)
    end
    
endfunction

function J = Vandermonde(vetor_x, p)
    //Gera a matriz responsável por encontrar os coeficientes 
    //utilizados no filtro
    
    //vetor_x é um vetor coluna
    
    for i=1:size(vetor_x)(1)
        for j=1:p+1
            J(i,j) = vetor_x(i)^(j-1)
        end
    end
    
endfunction

function resp = Verificar_caso(vetor_x)
    //Verifica se o espaçamento em x é constante.
    
    //vetor_x é um vetor coluna
    
    dec = 3 // Casa decimal comparada
    
    h_ant = abs(vetor_x(2) - vetor_x(1))
    h_ant = round(h_ant*10^(dec))
    
    for i=3:size(vetor_x)(1)
        h_novo = abs(vetor_x(i) - vetor_x(i-1))
        h_novo = round(h_novo*10^(dec))
        
        if h_novo ~= h_ant then
            resp = resume(1) //Intervalo em x variável
        end
        
        h_ant = h_novo
    end
    resp = 0
endfunction

function h = Mudanca_variavel(m)
    //Realiza a mudança de variável necessária p/ encontrar os
    //coeficientes do polinômio do filtro
    //z = (x-xcentro)/h -- h é o espaçamento
    
    if modulo(m, 2) == 0 then
        disp('A janela de pontos deve ser um número ímpar.')
        h = 0
        resume
    else
        for i=1:m
            h(i) = -(m-1)/2 + (i-1)
        end
    end
endfunction

