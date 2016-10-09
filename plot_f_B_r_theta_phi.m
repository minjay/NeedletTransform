clear

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

for i = 1:8
    max_value = max(abs(f_B_theta{i}(:)));
    if max_value<=200
        plot_field_map(f_B_theta{i})
    else
        plot_field_map(f_B_theta{i}, 200)
    end
    print(['f_B_theta_', num2str(i), '.eps'], '-depsc')
end

for i = 1:8
    max_value = max(abs(f_B_phi{i}(:)));
    if max_value<=200
        plot_field_map(f_B_phi{i})
    else
        plot_field_map(f_B_phi{i}, 200)
    end
    print(['f_B_phi_', num2str(i), '.eps'], '-depsc')
end