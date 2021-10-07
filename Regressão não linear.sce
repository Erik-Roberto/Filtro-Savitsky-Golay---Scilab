function erro = Residuos(coef, dados)
    
    x = dados(:,1)
    y = dados(:,2)
    
    for i=1:size(x)(1)
        Y(i) = Modelo(coef, x(i))
        erro(i) = (y(i) - Y(i))
    end
        
endfunction

function x_ot = Gauss_Newton(estimativa, dados)
    tol = 10E-4
    it_max = 100
    it = 0
    erro_max = 1
    
    x_ot = estimativa'
    x_ant = estimativa'
    while erro_max > tol & it <= it_max
        
        for i=1:size(dados)(1)
            J(i,:) = numderivative(list(Modelo, dados(i,1)), x_ot)
        end
        res = Residuos(x_ot, dados)
        
        dx = inv(J'*J)*J'*res
        x_ot = x_ot + dx
        
        for i=1:size(x_ot)(1)
            erro(i) =  abs((x_ot(i)-x_ant(i))/x_ot(i))
        end
        
        x_ant = x_ot
        erro_max = max(erro)
        it = it + 1
    end
endfunction



//a = linspace(0,1,50)'
//for i=1:size(a)(1)
//    b(i) = 2*exp(2*a(i)) + 1.5*sin(rand()*6)
//end
//dados = [a,b]


//chute = [1, 1]
//coeficientes = Gauss_Newton(chute, dados)
//
//for i=1:size(dados)(1)
//    ymodelo(i) = Modelo(coeficientes, dados(i,1))
//end
//
//scatter(dados(:,1),dados(:,2), 1 , 'fill')
//plot(dados(:,1), ymodelo,'red')

