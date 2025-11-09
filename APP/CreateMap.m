function Mappath=CreateMap(app,row,col,path,name)
    %地图创建函数
    location={};%创建空元胞
    %创建地图
    grid_map=ones(row,col);
    %边缘围墙建立
    grid_map(1:row,1)=4;
    grid_map(1:row,col)=4;
    grid_map(1,1:col)=4;
    grid_map(row,1:col)=4;
    %地图显示
    if ~isempty(path)&&~isempty(name)
        App_plot_grid(grid_map,location,app.UIAxes);
    else
        return;
    end
    %地图路径输出
    Mappath = [path filesep name ,'.mat'];
    save(Mappath, "grid_map","location");
end