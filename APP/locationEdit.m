function locationEdit(app,path,x,y,text)
%地点编辑函数
    map=load(path);
    grid_map=map.grid_map;
    location=map.location;
    %存入地点数据
    if(isempty(location))
        location={x,y,text};
    else
        new={x,y,text};
        location=[location;new];%元胞的串联使用[]
    end
    save(path,'grid_map','location');
    App_plot_grid(grid_map,location,app);
    drawnow;
end