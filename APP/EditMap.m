function EditMap(app,path,mouth) 
    %地图编辑函数
    %加载当前地图
    map=load(path);
    grid_map=map.grid_map;
    location=map.location;
    %获得鼠标点击处XY坐标
    x = floor(mouth(1));
    y = floor(mouth(2));
    boder=size(grid_map);
    %防止边缘线被修改
    if x<2||y<2||x>boder(2)-1||y>boder(1)-1
        return;
    end
    
    % 改变格子数据
    if grid_map(y, x)==1
        grid_map(y, x)=4;
    elseif grid_map(y, x)==4
        grid_map(y, x) = 2;
    elseif grid_map(y, x) == 2
        grid_map(y, x) = 3;
    else
        grid_map(y, x)=1;
    end
    %更新地图显示并保存
    App_plot_grid(grid_map,location,app.UIAxes);
    drawnow;
    save(path,'grid_map','location');
    
end