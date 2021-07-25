function D = Ler_valores_xls(path)
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
    [Nome, Path] = uigetfile(["*.xls";"*.csv"],pwd(),'Abrir')
    
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
