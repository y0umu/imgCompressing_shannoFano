% imgCompressing_shannonFano.m

function varargout = imgCompressing_shannonFano(varargin)
% IMGCOMPRESSING_SHANNONFANO MATLAB code for imgCompressing_shannonFano.fig
%      IMGCOMPRESSING_SHANNONFANO, by itself, creates a new IMGCOMPRESSING_SHANNONFANO or raises the existing
%      singleton*.
%
%      H = IMGCOMPRESSING_SHANNONFANO returns the handle to a new IMGCOMPRESSING_SHANNONFANO or the handle to
%      the existing singleton*.
%
%      IMGCOMPRESSING_SHANNONFANO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMGCOMPRESSING_SHANNONFANO.M with the given input arguments.
%
%      IMGCOMPRESSING_SHANNONFANO('Property','Value',...) creates a new IMGCOMPRESSING_SHANNONFANO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before imgCompressing_shannonFano_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to imgCompressing_shannonFano_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imgCompressing_shannonFano

% Last Modified by GUIDE v2.5 27-Mar-2017 15:43:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imgCompressing_shannonFano_OpeningFcn, ...
                   'gui_OutputFcn',  @imgCompressing_shannonFano_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before imgCompressing_shannonFano is made visible.
function imgCompressing_shannonFano_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to imgCompressing_shannonFano (see VARARGIN)

% 把界面移动到屏幕中央
movegui(hObject, 'center');

% 全局性质的变量
global NEXT_BUTTON_ENTRY_CNT; % 记录show_next_step_button被调用次数
       NEXT_BUTTON_ENTRY_CNT = 0;
global ENCODING_MODE;              % 上分支编0还是下分支编0的问题
       ENCODING_MODE = 0;

% 隐藏坐标轴
set(handles.axes_demoArea,'Visible','off');

% 屏蔽所有中断
h_interruptible_list = findobj(hObject, '-property','Interruptible');
set(h_interruptible_list, 'Interruptible', 'off');
% 统一含有String属性的控件的字体样式。注意！下面的语句会覆盖guide中进行的设置！
% 也就是说不管你在guide中给按钮设置什么字体名称和大小，都会被无视掉
% 受影响的GUI对象：text（不是axes上的那个text！）、edit、pushbutton、radiobutton
h_property_string_list = findobj(hObject, '-property','String');
set(h_property_string_list, 'FontSize',10.0);
set(h_property_string_list, 'FontName','微软雅黑');
% 统一所有含有Title属性的控件的字体样式
% 受影响GUI的对象：uipanel
h_property_title_list = findobj(hObject, '-property','Title');
set(h_property_title_list, 'FontSize',10.0);
set(h_property_title_list, 'FontName','微软雅黑');

% 置所有数据到初始状态。
guiResetAll(handles);

% Choose default command line output for imgCompressing_shannonFano
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes imgCompressing_shannonFano wait for user response (see UIRESUME)
% uiwait(handles.figure_imgCompressing_shannonFano);


% --- Outputs from this function are returned to the command line.
function varargout = imgCompressing_shannonFano_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%--------------------------------------------------------------------------
%                             非回调函数
%--------------------------------------------------------------------------
function guiSetEnable(handles)
% 置控件为“显示编码过程”状态
set(handles.button_next,'Enable','on');  %  “下一步”按钮使能
set(handles.button_startDemo, 'Enable','off')  % “生成哈夫曼树”按钮禁止
set(handles.button_decode,'Enable','off');             % “译码”按钮禁止
set(handles.edit_sourceProbability,'Enable','off');  % 信源输入框禁止
set(handles.edit_sourceSymbol,'Enable','off');       % 信源符号输入框禁止s
set(handles.radiobutton_encodingMode_0, 'Enable', 'off');  % 禁用单选按钮
set(handles.radiobutton_encodingMode_1, 'Enable', 'off');

%--------------------------------------------------------------------------
function guiResetAll(handles)
%guiResetAll 重置一切
guiResetWidget(handles);
guiResetEnable(handles);
%--------------------------------------------------------------------------
function guiResetWidget(handles)
%guiResetWidget 重置数据为初始状态
global NEXT_BUTTON_ENTRY_CNT;
global ENCODING_MODE;
ENCODING_MODE = 0;
set(handles.axes_demoArea,'YDir','reverse');  % 让y轴正方向朝下
axes(handles.axes_demoArea);
cla;
NEXT_BUTTON_ENTRY_CNT = 0;
set(handles.text_decodeResult,'String','');
set(handles.text_averageCodeLength,'string','');
set(handles.text_sourceEntropy,'string','');
set(handles.text_codingEfficiency,'string','');
set(handles.edit_sourceProbability,'string','0.25, 0.25, 0.2, 0.15, 0.10, 0.05');
set(handles.edit_sourceSymbol,'string','''a'',''o'',''r'',''S'',''i'',''t''');
set(handles.edit_sequenceToDecode,'String','11000111101101110');  % 设定一个初始化的可译码的值
set(handles.radiobutton_encodingMode_1,'Value',0);    % 取消选中模式1
set(handles.radiobutton_encodingMode_0,'Value',1);    % 选中模式0

%--------------------------------------------------------------------------
function guiResetEnable(handles)
%guiResetEnable 重置GUI控件使能为初始状态
set(handles.button_startDemo,'Enable','on');  % 使能“开始演示”按钮
set(handles.button_decode,'Enable','off');             % “译码”按钮禁止
set(handles.button_next, 'Enable', 'off');  % 禁用下一步按钮
set(handles.radiobutton_encodingMode_0, 'Enable', 'on');  % 使能单选按钮
set(handles.radiobutton_encodingMode_1, 'Enable', 'on');
set(handles.edit_sourceProbability,'Enable','on');  % 重新使能信源输入框
set(handles.edit_sourceSymbol,'Enable','on');       % 使能信源符号输入框
%--------------------------------------------------------------------------
function [probability, count, symbol] = evalUserInput(input_prob, input_sym)
%evalUserInput 检查用户输入
% input_string_1：表示信源概率的字符串
% input_string_2：表示信源符号的字符串
% 如果正确，status = true，probability和count分别赋值信源概率矩阵和信源符号个数
% 如果错误，弹出error提示， probability = count = NaN
try
    mat = eval(strcat('[', input_prob, ']'));
    symbol = eval(strcat('{', input_sym, '}'));
catch exception
    errordlg('输入有误啊...请重新输','错误','modal');
    error('输入有误啊...请重新输');
end
count = length(mat);
mat_sum = sum(mat);
if (any(mat <= 0))  % mat中有<0的元素
    probability = NaN;
    count = NaN;
    symbol = NaN;
    errordlg('你不能输入一个负数/零作为概率。更多信息请检查Command Window出现的错误信息','错误');
    error('ERROR: You cannot give a negative number or zero as probability');
end
if (any(mat >= 1))  % mat中有>=1的元素
    probability = NaN;
    count = NaN;
    symbol = NaN;
    errordlg('你不能输入大于等于1的数作为概率。更多信息请检查Command Window出现的错误信息','错误');
    error('ERROR: You cannot give a number greater equal than 1 as probability');
end

if (abs(mat_sum - 1) >= 1e-5)  % mat_sum ~= 1.0，本来这里用的误差限是常数eps，但似乎在输入概率很多的时候不好使
    probability = NaN;
    count = NaN;
    symbol = NaN;
    errordlg('输入概率之和不等于1。更多信息请检查Command Window出现的错误信息','错误');
    error('ERROR: Probabilities do not add up to 1');
end

if (length(symbol) ~= length(mat))
    probability = NaN;
    count = NaN;
    symbol = NaN;
    errordlg('信源概率和信源符号不等长。更多信息请检查Command Window出现的错误信息','错误');
    error('ERROR: The length of probabilty matrix and symbol cell is not equal');
end
probability = mat;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Fano编码相关 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------------------
function node = structSource_new(str_symbol, n_prob)
%fanoTreeNode_new 创建信源结构体
% str_symbol    -    char，信源符号
% n_prob        -    double，此符号的概率
% 返回一个具有symbol、prob、code分量的结点
% 其中str_code是对此符号的编码.初始化为''
node = struct('symbol', str_symbol, ...
              'prob',   n_prob);
%--------------------------------------------------------------------------
function [ nodes_sorted ] = structSource_sort( nodes )
%structSource_sort 让信源降序排序
len = length(nodes);
[cell_prob{1:len}] = nodes.prob;
arr_prob = cell2mat(cell_prob);
[~, ind] = sort(arr_prob, 'descend');
nodes_sorted = nodes(ind);
%--------------------------------------------------------------------------
function node = fanoTreeNode_new( n_prob, n_range, code, up, down)
%fanoTreeNode_new 构造一个新的fano树的结点
%   n_prob           -  标量，当前结点的概率
%   code             -  char，当前结点应编码
%   n_range          -  1x2数组，当前结点代表的信源符号组的下标范围。
%                       n_range(1)表示首元素下标，n_range(2)表示尾元素下标
%   node             -  输出构造的结点
%   up, down         -  上分支、下分支指针
node = struct('prob', n_prob, ...
              'code', code, ...
              'range', n_range, ...
              'up', up, ...
              'down', down);
%--------------------------------------------------------------------------
function division = findDivisionInd( arr, ind_start )
%findDivisionInd 查找数组n_arr分界点
%   arr        -  要查找分界点的数组。此数组已经降序排序
%   n_start      -  arr(1)对应于整个信源符号的下标
%   division_ind -  arr在整个信源符号中的分界点
len = length(arr);
if len > 2
    d0 = abs( arr(1) - sum(arr(2:len)) );
    for k = 2:len
        d1 = abs( sum(arr(1:k)) - sum(arr((k+1):len)) );
        if d0 <= d1    % 找到分界点
            k = k - 0.5;
            break;
        else
            d0 = d1;
        end
    end
else
    k = 1.5;
end
division = ind_start - 1 + k ;
%--------------------------------------------------------------------------
function [ nodes_next_level, nodes_current_level] = fanoTreeNode_makeNextLevel( source_prob, nodes_current_level )
%fanoTreeNode_makeNextLevel 由当前层的结点生成下一层结点
%   source_prob           -  整个信源概率向量
%   nodes_current_level   -  （既是输入也是输出）当前层的所有结点
n = length(nodes_current_level);
k = 1;    % 指向下一层结点的指针
nodes_next_level = {};
for i = 1:n
    if fanoTreeNode_isLeaf(nodes_current_level{i});
        continue;
    end
    ind_start = nodes_current_level{i}.range(1);
    ind_end = nodes_current_level{i}.range(2);
    division = findDivisionInd(source_prob(ind_start:ind_end), ...
                              ind_start);
    
    s_up = sum( source_prob(ind_start : floor(division) ) );
    s_down = sum(source_prob(ceil(division) : ind_end ) );
    
    % 上分支编码a，下分支编码b
    nodes_next_level{k} = fanoTreeNode_new(s_up, [ind_start, floor(division)], 'a', [], []);
    nodes_current_level{i}.up = k;
    k = k + 1;
    nodes_next_level{k} = fanoTreeNode_new(s_down, [ceil(division), ind_end ], 'b', [], []);
    nodes_current_level{i}.down = k;
    k = k + 1; 
end
%--------------------------------------------------------------------------
function bool = fanoTreeNode_isLeaf( node )
%fanoTreeNode_isLeaf 当前结点node返回是否时叶子结点
if node.range(1) == node.range(2)
    bool = true;
else
    bool = false;
end
%--------------------------------------------------------------------------
function fano_tree = fanoTree_new( nodes_source )
%fanoTree_new 创造一棵费诺树
%  nodes_source  -  必须是由structSource_new创造的结构体
nodes_source = structSource_sort(nodes_source);      % 降序排序
num_nodes_source = length(nodes_source);
[cell_prob{1:num_nodes_source}] = nodes_source.prob;
source_prob = cell2mat(cell_prob);

fano_tree{1} = fanoTreeNode_new(1, [1, num_nodes_source], '', [], []);
is_all_leaves = false;
nodes_current = fano_tree(1);
k = 1;
[nodes_next, nodes_current] = fanoTreeNode_makeNextLevel( source_prob, nodes_current );
while ~isempty(nodes_next)   
    fano_tree{k} = nodes_current;
    fano_tree{k+1} = nodes_next;
    nodes_current = nodes_next;
    k = k + 1;
    [nodes_next, nodes_current] = fanoTreeNode_makeNextLevel( source_prob, nodes_current );
end
%--------------------------------------------------------------------------
function fanoTree_makeDict( current_node, current_level, tree, current_code )
%fanoTree_makeDict 生成编码字典
%   FANO_DICT        - global, cell。建立信源符号与编码的映射关系。
%                      dict{:,1}为信源符号（下标）
%                      dict{:,2}为对应的编码（以a、b而不是0、1作为符号）
%   SIZE_FANO_DICT    - global, 标量。字典容量计数器。注意！调用本函数前
%                      SIZE_FANO_DICT必须被初始化成1！
%   current_node     - 当前结点
%   current_level    - 当前层数
%   tree             - 完整的Fano树
% 这是一个递归调用的函数。最外层调用的current_node就是根节点
% 例如fanoTree_makeDict(tree{1}{1}, 1, tree, '');
global FANO_DICT;
global SIZE_FANO_DICT;
% 遍历费诺树
if current_node.range(1) ~= current_node.range(2)    % 当前结点不是叶子结点
    fanoTree_makeDict(tree{current_level + 1}{current_node.up}, ...
                      current_level + 1, ...
                      tree, ...
                      strcat(current_code, current_node.code) );
    fanoTree_makeDict(tree{current_level + 1}{current_node.down}, ...
                      current_level + 1, ...
                      tree, ...
                      strcat(current_code, current_node.code) );
else    % 当前结点是叶子结点
    FANO_DICT{SIZE_FANO_DICT, 1} = current_node.range(1);
    FANO_DICT{SIZE_FANO_DICT, 2} = strcat(current_code, current_node.code);
    SIZE_FANO_DICT = SIZE_FANO_DICT + 1;
end
%--------------------------------------------------------------------------
function index = fanoTree_dictLookup(code, dict)
%fanoTree_dictLookup 根据字典查询code在字典dict中对应的下标index
[n, ~] = size(dict);
index = [];
for i=1:n
    if strcmp(code, dict{i,2})
        index = i;
        break;
    end
end
if isempty(index)
    index = -1;    % 没找到
end
%--------------------------------------------------------------------------
function seq_translated = decodeTranslate(seq, mode)
%fanoTree_decodeModeTranslate 根据模式将seq翻译成相应的由a、b两个字母组成的序列
%    此函数配合fanoTree_seqDecode使用
if mode == 0
    seq(seq == '0') = 'a';
    seq(seq == '1') = 'b';
else
    seq(seq == '0') = 'b';
    seq(seq == '1') = 'a';
end
seq_translated = seq;
%--------------------------------------------------------------------------
function msg = fanoTree_seqDecode( seq, source, tree, dict, mode )
%fanoTree_seqDecode 序列译码函数
%   seq    -  输入序列
%   source -  由structSource_sort函数排序后的信源
%   tree   -  Fano树
%   dict   -  由fanoTree_makeDict函数生成的字典
%   mode   -  编码模式
%   msg    -  译码得到的消息序列。如果不能译码则抛出异常
seq = decodeTranslate(seq, mode);
p = 1;    % 序列指针
q = 1;    % 另一个序列指针
node_ptr = [1 1];   % 树指针，第一个分量指向层数，第二个指向所在层的结点下标
seq_len = length(seq);   % 序列长度
msg = '';


while q <= seq_len
    if seq(q) == 'a'
    node_ptr(2) = tree{node_ptr(1)}{node_ptr(2)}.up;
    node_ptr(1) = node_ptr(1) + 1;
    elseif seq(q) == 'b'
        node_ptr(2) = tree{node_ptr(1)}{node_ptr(2)}.down;
        node_ptr(1) = node_ptr(1) + 1;
    else
        error('seqDecode:invalid_seq', '您的序列中输入了奇怪的东西："%c"',seq(q));
    end
    % 碰到叶子结点就查字典
    if fanoTreeNode_isLeaf(tree{node_ptr(1)}{node_ptr(2)}) && (node_ptr(1) ~= 1)
        ind = fanoTree_dictLookup( seq(p:q), dict);
        if ind == -1
            error('seqDecode:unexpected_error', '程序设计有误。正常运行的程序不应进入本分支');
        end
        msg = strcat(msg, source(ind).symbol);
        q = q + 1;
        p = q;
        node_ptr = [1 1];   % 树指针重置
    else
        q = q + 1;
    end
end

if (p ~= q) && (q >= seq_len)
    error('seqDecode:cannot_decode', '序列中包含不能被译码的码字');
end
%--------------------------------------------------------------------------


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 计算相关 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------------------
function avg_len = getAvgCodeLen(nodes_source, dict)
%getAvgCodeLen 求平均码长
%  nodes_source - 信源结构体
%  dict         -  编码字典。调用时以全局变量FANO_DICT代入
[source_count, ~] = size(dict);
avg_len = 0;
for i = 1:source_count
    avg_len = avg_len + nodes_source(i).prob * length(dict{i,2});
end
%--------------------------------------------------------------------------
function H = getSourceEntropy(nodes_source)
%getSourceEntropy 求信源熵 单位bit/符号
%   nodes_source是信源结构体
s = 0;
source_count = length(nodes_source);
for i=1:source_count
    s = s + nodes_source(i).prob * log2(nodes_source(i).prob);
end
s = -s;
H = s;
%--------------------------------------------------------------------------


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 画图相关 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------------------
function drawSource(h_axes, nodes_source, source_count)
%drawSource 在h_axes上绘制信源符号和信源概率
% 由回调函数button_startDemo调用
axes(h_axes);
text('String','信源符号','Position', [0, 0], 'HorizontalAlignment', 'center');
text('String','信源概率','Position', [1, 0], 'HorizontalAlignment', 'center');
for i=1:source_count
    text('String',nodes_source(i).symbol,'Position', [0, i], 'HorizontalAlignment', 'center');
    text('String', num2str(nodes_source(i).prob), 'Position', [1, i], 'HorizontalAlignment', 'center');
end
% 画边框线
line([-0.5, 1.5], [0.5, 0.5]);                  % 上边框
line([-0.5, 1.5], [source_count+0.5, source_count+0.5]);  % 下边框
line([-0.5, -0.5], [0.5, source_count+0.5]);    % 左边框
line([1.5, 1.5], [0.5, source_count+0.5]);      % 右边框
% 内边框
line([0.5, 0.5], [0.5, source_count+0.5]);    % 左边框
for i=1:(source_count - 1)
    line([-0.5 1.5], [i+0.5, i+0.5]);
end
%--------------------------------------------------------------------------
function drawLevel(h_axes, tree_level, n_level,nodes_source, encoding_mode)
%drawLevel 在h_axes绘制tree_level。参数n_level说明当前绘制的是第几层
% 由回调函数button_next_Callback调用
% text('String', 'test', 'Position', [n_level, 1], 'HorizontalAlignment', 'center');
axes(h_axes);
cnt = length(tree_level);
source_cnt = length(nodes_source);
[cell_prob{1:source_cnt}] = nodes_source.prob;
arr_prob = cell2mat(cell_prob);
for i=1:cnt
    y_pos = (tree_level{i}.range(1) + tree_level{i}.range(2)) / 2;
    code = tree_level{i}.code;
    if encoding_mode == 0
        code(code == 'a') = '0';
        code(code == 'b') = '1';
    else
        code(code == 'a') = '1';
        code(code == 'b') = '0';
    end
    prob = sum(arr_prob(tree_level{i}.range(1) : tree_level{i}.range(2)) );
    words = strcat(num2str(prob), ' (', code, ')');
    text('String', words, 'Position', [n_level, y_pos], 'HorizontalAlignment', 'center');
end
%--------------------------------------------------------------------------
function drawBorder(h_axes, tree_level, n_level)
%drawBorder 在h_axes绘制tree_level的分界线。参数n_level说明当前绘制的是第几层
% 参数source_count是为了确定两层之间的分割线应该画多长所需的参数（参见函数drawSource）
% 由回调函数button_next_Callback调用
axes(h_axes);
cnt = length(tree_level);
% 绘制两个结点之间的分割线
for i=1:(cnt - 1)
    y_pos = (tree_level{i}.range(2) + tree_level{i+1}.range(1)) / 2;
    line([n_level-0.5, n_level+0.5], [y_pos, y_pos]);
end

% 绘制第一个结点和最后一个节点的上下的分割线
y_pos = tree_level{1}.range(1) - 0.5;
line([n_level-0.5, n_level+0.5], [y_pos, y_pos]);
y_pos = tree_level{cnt}.range(2) + 0.5;
line([n_level-0.5, n_level+0.5], [y_pos, y_pos]);
% 绘制每个结点右侧的分割线
for i=1:cnt
    y_pos_start = tree_level{i}.range(1) - 0.5;
    y_pos_end   = tree_level{i}.range(2) + 0.5;
    line([n_level+0.5, n_level+0.5], [y_pos_start, y_pos_end]);
end
%--------------------------------------------------------------------------
function drawCode(h_axes, dict, tree_depth, encoding_mode)
%drawCode 把码字绘制到图上
axes(h_axes);
[cnt, ~] = size(dict);
x_pos = tree_depth + 1;
text('String', '码字', 'Position', [x_pos, 0], 'HorizontalAlignment', 'center');
for i=1:cnt
    code = dict{i,2};
    if encoding_mode == 0
        code(code == 'a') = '0';
        code(code == 'b') = '1';
    else
        code(code == 'a') = '1';
        code(code == 'b') = '0';
    end
    text('String', code, 'Position', [x_pos, i], 'HorizontalAlignment', 'center');
end
%--------------------------------------------------------------------------


%----------------------------非回调函数 end--------------------------------

%--------------------------------------------------------------------------
%                              回调函数
%--------------------------------------------------------------------------


% --- Executes during object creation, after setting all properties.
function edit_sourceProbability_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sourceProbability (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in button_startDemo.
function button_startDemo_Callback(hObject, eventdata, handles)
global NODES_SOURCE;
global FANO_TREE;
global FANO_DICT;    % fanoTree_makeDict隐式使用了此变量作为输入。请不要删除这条global声明
global SIZE_FANO_DICT;
FANO_DICT = {};
SIZE_FANO_DICT = 1;
axes(handles.axes_demoArea);   % set(gcf,'CurrentAxes',handles.axes_demoArea);
cla;  % 清除之前画的内容

input_prob = get(handles.edit_sourceProbability, 'String');
input_sym = get(handles.edit_sourceSymbol, 'String');
[source_probability, source_count, source_symbol] = evalUserInput(input_prob, input_sym);
% 预先分配存储空间
NODES_SOURCE = struct('prob',zeros(source_count, 1), ...
                      'symbol', char(zeros(source_count,1)));
for i=1:source_count
    NODES_SOURCE(i).prob = source_probability(i);
    NODES_SOURCE(i).symbol = source_symbol(i);
end
NODES_SOURCE = structSource_sort(NODES_SOURCE);
FANO_TREE = fanoTree_new(NODES_SOURCE);
axis([-0.5, length(FANO_TREE)+1.5, -0.5, source_count+0.5]);    % 调整视野
fanoTree_makeDict(FANO_TREE{1}{1}, 1, FANO_TREE, '');   % 生成译码时会用到的字典

drawSource(handles.axes_demoArea, NODES_SOURCE, source_count);

guiSetEnable(handles);    % 调整界面控件上的使能
%--------------------------------------------------------------------------

% --- Executes during object creation, after setting all properties.
function text_averageCodeLength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_averageCodeLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%--------------------------------------------------------------------------

% --- Executes during object creation, after setting all properties.
function text_sourceEntropy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_sourceEntropy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%--------------------------------------------------------------------------

% --- Executes during object creation, after setting all properties.
function text_codingEfficiency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_codingEfficiency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%--------------------------------------------------------------------------
% --- Executes on button press in button_reset.
function button_reset_Callback(hObject, eventdata, handles)
guiResetAll(handles);
%--------------------------------------------------------------------------

% --- Executes during object creation, after setting all properties.
function button_startDemo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to button_startDemo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
function menuitem_file_Callback(hObject, eventdata, handles)
%--------------------------------------------------------------------------
function menuitem_edit_Callback(hObject, eventdata, handles)
%--------------------------------------------------------------------------
function menuitem_view_Callback(hObject, eventdata, handles)
%--------------------------------------------------------------------------
function menuitem_help_Callback(hObject, eventdata, handles)
%--------------------------------------------------------------------------
function menuitem_showDoc_Callback(hObject, eventdata, handles)
web 'https://zh.wikipedia.org/wiki/%E9%A6%99%E5%86%9C-%E8%8C%83%E8%AF%BA%E7%BC%96%E7%A0%81' -browser
%--------------------------------------------------------------------------
function button_next_Callback(hObject, eventdata, handles)
global NODES_SOURCE;
global FANO_TREE;
global FANO_DICT;
global NEXT_BUTTON_ENTRY_CNT;
global ENCODING_MODE;
tree_depth = length(FANO_TREE);
% disp('button_next');    % 调试用
NEXT_BUTTON_ENTRY_CNT = NEXT_BUTTON_ENTRY_CNT + 1;
% disp(NEXT_BUTTON_ENTRY_CNT);    % 调试用
axes(handles.axes_demoArea);

if NEXT_BUTTON_ENTRY_CNT < tree_depth
    drawLevel(handles.axes_demoArea, FANO_TREE{NEXT_BUTTON_ENTRY_CNT+1}, ...
              NEXT_BUTTON_ENTRY_CNT+1, NODES_SOURCE, ENCODING_MODE);
    drawBorder(handles.axes_demoArea, FANO_TREE{NEXT_BUTTON_ENTRY_CNT+1}, ...
              NEXT_BUTTON_ENTRY_CNT+1);
end


% 码树绘制结束
if NEXT_BUTTON_ENTRY_CNT >= tree_depth - 1
    % 绘制码字
    drawCode(handles.axes_demoArea, FANO_DICT, tree_depth, ENCODING_MODE);
    % 信源熵
    H = getSourceEntropy(NODES_SOURCE);
    
    % 平均码长
    N = getAvgCodeLen(NODES_SOURCE, FANO_DICT);
    
    % 编码效率
    P = H / N;
    % 填入GUI右侧的显示区
    set(handles.text_averageCodeLength,'string',num2str(N));
    set(handles.text_sourceEntropy,'string',num2str(H));
    set(handles.text_codingEfficiency,'string',num2str(P));
    NEXT_BUTTON_ENTRY_CNT = 0;  % 计数器复位
    set(handles.edit_sourceProbability,'Enable','on');  % 重新使能信源输入框
    set(handles.edit_sourceSymbol,'Enable','on');       % 使能信源符号输入框
    set(handles.button_startDemo,'Enable','on');  % 重新使能“生成码树”按钮
    set(handles.button_decode,'Enable','on');     % “译码”按钮使能
    set(handles.button_next, 'Enable', 'off');  % 禁用“下一步”按钮
    set(handles.radiobutton_encodingMode_0, 'Enable', 'on');  % 使能单选按钮
    set(handles.radiobutton_encodingMode_1, 'Enable', 'on');
end
%--------------------------------------------------------------------
function encoding_mode_SelectionChangeFcn(hObject, eventdata, handles)
global ENCODING_MODE;
set(handles.button_decode, 'Enable', 'off');
chosen_val = get(hObject,'tag');
switch chosen_val
    case 'radiobutton_encodingMode_0'
        ENCODING_MODE = 0;
%         disp('0');
    case 'radiobutton_encodingMode_1'
        ENCODING_MODE = 1;
%         disp('1');
    otherwise
        disp('Something must be wrong!');
        error('程序不应该进入此分支，一定是什么地方出错了！');
end
%--------------------------------------------------------------------------
function edit_sourceSymbol_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%--------------------------------------------------------------------------
function edit_sequenceToDecode_Callback(hObject, eventdata, handles)

%--------------------------------------------------------------------------
function edit_sequenceToDecode_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%--------------------------------------------------------------------------
function button_decode_Callback(hObject, eventdata, handles)
global FANO_TREE;
global FANO_DICT;                       % 用来编码、解码序列的数据字典
global NODES_SOURCE;
global ENCODING_MODE;

% 获取待解码序列
sequence = get(handles.edit_sequenceToDecode,'string');
try
    msg = fanoTree_seqDecode( sequence, NODES_SOURCE, FANO_TREE, FANO_DICT, ENCODING_MODE );
catch exception
    msg = '无法译码';
    switch(exception.identifier)
        case 'seqDecode:invalid_seq'
            errordlg('您的序列中似乎有什么奇怪的东西啊？','错误', 'modal');
        case 'seqDecode:cannot_decode'
            errordlg('输入序列译码包含码树中不存在的码字','错误', 'modal');    
        otherwise
            errordlg('其他错误，请检查Command Window的输出','错误', 'modal');
            throw(exception);
    end
end
set(handles.text_decodeResult, 'String', msg);

%--------------------------------------------------------------------------
function menuitem_aboutSatori_Callback(hObject, eventdata, handles)
% msgbox('本程序最后由徐志超修改','关于');
h_fig = figure;
set(h_fig,'units','pixels','Windowstyle','normal','Menubar','none',...
            'Name', '关于Satori','NumberTitle','off','CloseRequestFcn','delete(gcf)');
h_axes = axes;
% axis off;

img = imread('Komeiji Satori.png');
h_img = imshow(img, 'Parent', h_axes);

axes_position = get(h_axes, 'Position');

msg_str = ['想起「被学霸支配的恐惧」', ... 
            char(10),'古明地觉（Komeiji Satori）早已看穿了一切'];
% h_text = uicontrol(h_fig,'Style','text','Units','Normalized',...
%                    'FontSize',9.0,'Position',[0.05 0.01 0.90 0.075],...
%                    'String',msg_str);
h_text = uicontrol(h_fig,'Style','text','Units','Normalized',...
                   'FontSize',9.0,'Position',[0.05, axes_position(2)-0.077, 0.90, 0.075],...
                   'String',msg_str);

%--------------------------------------------------------------------------
function menuitem_aboutShannon_Callback(hObject, eventdata, handles)
web 'https://zh.wikipedia.org/wiki/%E5%85%8B%E5%8A%B3%E5%BE%B7%C2%B7%E9%A6%99%E5%86%9C' -browser
% get(h1);

%--------------------------------------------------------------------------
function figure_imgCompressing_shannonFano_CloseRequestFcn(hObject, eventdata, handles)
%%% 本模块涉及完成之时务必要把此析构函数写好！
clear global -regexp NEXT_BUTTON_ENTRY_CNT ENCODING_MODE FANO_DICT SIZE_FANO_DICT NODES_SOURCE FANO_TREE
% disp('请记得完成析构函数的编写');
% Hint: delete(hObject) closes the figure
delete(hObject);

%--------------------------------------------------------------------------
function menuitem_aboutFano_Callback(hObject, eventdata, handles)
web 'https://zh.wikipedia.org/wiki/%E7%BE%85%E4%BC%AF%E7%89%B9%C2%B7%E6%B3%95%E8%AB%BE' -browser
%------------------------------回调函数 end--------------------------------
