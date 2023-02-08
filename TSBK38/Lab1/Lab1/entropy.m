function H = entropy(p)


p_flat = reshape(p.',1,[]);
H = -nansum(p_flat.*log2(p_flat));

end