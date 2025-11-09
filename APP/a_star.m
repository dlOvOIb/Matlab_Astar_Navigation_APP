function [path, goal_reached, cost] = a_star(map, start, goal,mode)

OPEN = [];%储存待检查的点
CLOSED = [];%储存已检查的点

cost = 0;%从起始点到当前点的成本
goal_reached = false;%判断是否抵达目的地
motion = [-1, -1, sqrt(2); ...
    0, -1, 1; ...
    1, -1, sqrt(2); ...
    -1, 0, 1; ...
    1, 0, 1; ...
    -1, 1, sqrt(2); ...
    0, 1, 1; ...
    1, 1, sqrt(2)];%可能移动的方向以及成本

motion_num = size(motion, 1);%motion数组的行数，即可能移动的方向

%起始节点的 坐标 成本 启发式成本 父节点坐标（直接用了起始点作为父节点）
node_s = [start, 0, h(start, goal), start];
OPEN = [OPEN; node_s];%将起始节点添加到OPEN列表中

while ~isempty(OPEN)
    f = OPEN(:, 3) + OPEN(:, 4);%计算OPEN列表中每个节点的f值（g值 + h值，其中g是从起始点到当前节点的实际成本，h是启发式成本）
    [~, index] = min(f);%找到OPEN中f值最小的节点，记录其位置
    cur_node = OPEN(index, :);%让cur_node(当前节点)等于这个f值最小的节点
    OPEN(index, :) = [];%将这个f值最小的节点删除

    %如果当前节点在CLOSED中，则跳过本次执行
    if loc_list(cur_node, CLOSED, [1, 2])
        continue
    end
...........................

    %判断是否找到目标
    if cur_node(1) == goal(1) && cur_node(2) == goal(2)
        CLOSED = [cur_node; CLOSED];%将当前节点添加到CLOSED的顶部
        goal_reached = true;
        cost = cur_node(3);
        break
    end

    %向8个方向搜索
    for i = 1:motion_num
        node_n = [
            cur_node(1) + motion(i, 1), ...
            cur_node(2) + motion(i, 2), ...
            cur_node(3) + motion(i, 3), ...
            0, ...
            cur_node(1), cur_node(2)];%得到可能方向的相邻节点 其中0为额外成本 后两个为父节点坐标
        node_n(4) = h(node_n(1:2), goal);%额外成本=启发式成本

        %如果相邻节点已经在CLOSED中，则跳过该次循环
        if loc_list(node_n, CLOSED, [1, 2])
            continue
        end
        
        %如果为体力优先
        if mode=="stamina"
            %如果该相邻节点为斜坡，cost设置为1.5(在原有基础上+0.5)
            if map(node_n(1), node_n(2)) == 2
                node_n(3)=node_n(3)+0.5;
            end
             %如果该相邻节点为楼梯，cost设置为2(在原有基础上+1)
            if map(node_n(1), node_n(2)) == 3
                node_n(3)=node_n(3)+1;
            end
        end
        
        
        %如果该相邻节点为墙壁，跳过该次循环
        if map(node_n(1), node_n(2)) == 4
            continue
        end

        %如果该节点可以走，将其放入OPEN尾部
        OPEN = [OPEN; node_n];
    end
    CLOSED = [cur_node; CLOSED]; %将cur_node放在CLOSED顶部
end

%生成路径
path = extract_path(CLOSED, start);
end

%%
%启发式成本
function h_val = h(node, goal)
%计算得到曼哈顿距离（即水平距离+垂直距离）
h_val = abs(node(1) - goal(1)) + abs(node(2) - goal(2));
end

%判断一个节点是否在给定的list中，并给出它的位置
function index = loc_list(node, list, range)
num = size(list);
index = 0;

if ~num(1)
    return
else
    for i = 1:num(1)
        if isequal(node(range), list(i, range))
            index = i;
            return
        end
    end
end
end

%计算出最短路径
function path = extract_path(close, start)
path = [];
closeNum = size(close, 1);
index = 1;

while 1
    path = [path; close(index, 1:2)];

    if isequal(close(index, 1:2), start)
        break
    end

    for i = 1:closeNum
        if isequal(close(i, 1:2), close(index, 5:6))
            index = i;
            break
        end
    end
end
end
