function Y = Filtro_SG(janela, grau, dados_x, dados_y, ordem, bordas)
    //Função responsável por aplicar o filtro nos dados
    //Verifica se os dados são adequados para as condições do filtro e 
    //calcula os coeficientes com base no grau e janela escolhidos,
    //na versão atual um set de n pontos, aplicados a um filtro com
    //janela m, resulta em um set de n-m+1 pontos.
    
    if ~exists('bordas','local') then
        bordas = 'T'
    end
    
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
    z = Mudanca_variavel(janela) //Mudança de var. p/ calc. dos coef.
    h = dados_x(2) - dados_x(1)
    J = Vandermonde(z, grau)
    C = inv(J'*J)*J'
    a = C(ordem+1,:) //Cada linha contém o coeficiente de expoente diferente
    
    
    //Aplicando o filtro nos dados centrais:
    for i=i_ini:i_fin
        Ycentro(i-n) = h^(-ordem)*a*dados_y(i-n:i+n)
    end
    
    
    
    if bordas == 'T' then
        
        //Aplicando polinomio nas bordas:
        //Inicio:
        ai = h^(-ordem)*C*dados_y(i_ini-n:i_ini+n)
        for i=1:n
            Yini(i) = 0
            for k=ordem:grau
                aux = ai(k+1)*factorial(k)/factorial(k-ordem)*z(i)^(k-ordem)
                Yini(i) = Yini(i) + aux
            end
        end
        //Final:
        ai = h^(-ordem)*C*dados_y(i_fin-n:i_fin+n)
        for i=1:n
            Yfin(i) = 0
            for k=ordem:grau
                aux = ai(k+1)*factorial(k)/factorial(k-ordem)*z(n+1+i)^(k-ordem)
                Yfin(i) = Yfin(i) + aux
            end
        end
        
        Y(1:n) = Yini
        Y(i_ini:i_fin) = Ycentro
        Y(i_fin+1:i_fin+n) = Yfin
    
    elseif bordas == 'F' then
        Y = Ycentro
    else
        disp('Opção inválida, devem ser Verdadeira (T) ou Falsa: (F).')
        disp('Retornando valores sem considerar a borda.')
        
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

function z = Mudanca_variavel(m)
    //Realiza a mudança de variável necessária p/ encontrar os
    //coeficientes do polinômio do filtro
    //z = (x-xcentro)/h -- h é o espaçamento
    
    if modulo(m, 2) == 0 then
        disp('A janela de pontos deve ser um número ímpar.')
        z = 0
        resume
    else
        for i=1:m
            z(i) = -(m-1)/2 + (i-1)
        end
    end
endfunction

function dy = Derivada(dados_x, dados_y, ordem)
    h = dados_x(2)- dados_x(1)
    
    dy = diff(dados_y, ordem)
    dy = dy*h^(-ordem)
endfunction
