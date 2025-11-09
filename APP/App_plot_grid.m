function App_plot_grid(grid_map,location,UIAxes)
%在UIAxes中要将"多个绘图"中的"next plot"改为add，否则会使用图像坐标系，原点在左上角
% 1 正常道路
% 2 楼梯
% 3 斜坡
% 4 障碍
    
    cmap = [1 1 1; ...        
            0 1 1; ...  
            1 0.5 0.6; ... 
            0 0 0;];
    cla(UIAxes);%
    colormap(UIAxes,cmap);%设置坐标区的颜色映射
    
    [rows, cols] = size(grid_map);%获得行列大小
    image(UIAxes,1.5,1.5,grid_map);%图像显示
    set(UIAxes,'xtick', 1:cols+1, 'ytick', 1:rows+1);
    xlim(UIAxes,[1 cols+1])
    ylim(UIAxes,[1 rows+1])

    for row = 1:rows
        line(UIAxes,[1, cols + 1], [row, row], 'Color', '#eee');
    end
    for col = 1:cols
        line(UIAxes,[col, col], [1, rows + 1], 'Color', '#eee');
    end
    %地图地点文字显示
    if(~isempty(location))
        for i=1:size(location,1)
            text(UIAxes,location{i,1},location{i,2},location{i,3})
        end
    end
    %close all;
end