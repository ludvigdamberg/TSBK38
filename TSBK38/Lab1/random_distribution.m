function p = random_distribution(signal)

%Random distribution


 symbol_count = zeros(max(signal), 1);

    for i = 1:size(signal, 1)
        index = signal(i);
        symbol_count(index) = symbol_count(index) + 1;
    end
    
    p = symbol_count/size(signal, 1);
    
    
end

