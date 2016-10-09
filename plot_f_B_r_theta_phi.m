load('f_decomp.mat')

for i = 1:8
    max_value = max(abs(f_B_r{i}(:)));
    if max_value<=200
        plot_field_map(f_B_r{i})
    else
        plot_field_map(f_B_r{i}, 200)
    end
    print(['f_B_r_', num2str(i), '.eps'], '-depsc')
end