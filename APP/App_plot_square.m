function App_plot_square(pts,color,word,app)
    %起点终点方块绘制
    axes=app.UIAxes;
    if isempty(pts)
        return
    end
    rectangle(app.UIAxes,'Position',[pts(2),pts(1),1,1],'FaceColor',color);
    text(app.UIAxes,pts(2),pts(1)+0.5,word)
end

