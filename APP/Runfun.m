function Runfun(grid_map,location,start,goal,mode,app)

%清空坐标区
cla(app.UIAxes);

%路径规划
[path, goal_reached, ~] = a_star(grid_map, start, goal,mode);

if ~goal_reached
    msgbox('死路！请重新输入坐标', '警告', 'error');
    App_plot_grid(grid_map,location,app);
    return;
end

%绘制地图
App_plot_grid(grid_map,location,app.UIAxes);

%绘制路径
App_plot_path(path,app.UIAxes);
    
%绘制起点和终点
App_plot_square(start,[1 0.5 0.2],'起点',app);
App_plot_square(goal,[0 1 0.5],'终点',app);