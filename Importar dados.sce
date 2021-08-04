//Importar Dados------------------------------------------------------
function D = Ler_valores_xls(path)
    //Le os dados contidos num arquivo do tipo .xls
    //Retorna os dados limpos
    
    planilha = readxls(path)
    p1 = planilha(1).value
    
    i = 1 
    for j=1:size(p1)(2)
        [valores, num] = thrownan(p1(:,j))
        
        linhas = size(valores)(1)
        if linhas > 0 then
            D(1:linhas, i) = valores
            i = i + 1
        end
        
    end
endfunction

function D = Ler_valores_csv(path)
    //Le os dados contidos num arquivo do tipo .csv.
    //Retorna os dados limpos
    
    p1 = csvRead(path,';', ',', 'double')
    
    i = 1 
    for j=1:size(p1)(2)
        [valores, num] = thrownan(p1(:,j))
        
        linhas = size(valores)(1)
        if linhas > 0 then
            D(1:linhas, i) = valores
            i = i + 1
        end
        
    end
endfunction

function D = Abrir()
    //Abre a caixa de diálogo p/ escolha do arquivo a ser lido e 
    //retorna os dados limpos
    [Nome, Path] = uigetfile(["*.xls";"*.csv"],pwd(),'Abrir')
    if Nome == '' then
        D=0
        resume
    end
    i_ponto = strindex(Nome, '.')
    tipo = strsplit(Nome, i_ponto)(2)
    if tipo == 'xls' then
        D = Ler_valores_xls(Path+'\'+Nome)
    elseif tipo == 'csv' then
        D = Ler_valores_csv(Path+'\'+Nome)
    else
        disp('Extensão de arquivo não suportada')
        D = []
    end
    
endfunction

//Exportar Dados------------------------------------------------------
function Exportar(nome, varargin)
    //Cria uma planilha no formato .csv contendo os dados repassados
    //Todos os vetores repassados devem ser vetores coluna!
    
    dados = [0]
    for i=1:size(varargin)(1)
        tam = size(varargin(i))(1)
        dados(1:tam, i) = varargin(i)
    end
    write_csv(dados, nome+'.csv', ';', ',')
endfunction

//Toolbox-------------------------------------------------------------
function l = ultimo_valor(vetorx, vetory)
    //Compara o tamanho de dois vetores e retorna a ultima 
    //posição do menor
    
    tam_x = size(vetorx)(1)
    tam_y = size(vetory)(1)
    
    if tam_x > tam_y then
        l = tam_y
    elseif tam_x < tam_y then
        l = tam_x
    else
        l = tam_x
    end
endfunction
