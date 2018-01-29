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

% �ѽ����ƶ�����Ļ����
movegui(hObject, 'center');

% ȫ�����ʵı���
global NEXT_BUTTON_ENTRY_CNT; % ��¼show_next_step_button�����ô���
       NEXT_BUTTON_ENTRY_CNT = 0;
global ENCODING_MODE;              % �Ϸ�֧��0�����·�֧��0������
       ENCODING_MODE = 0;

% ����������
set(handles.axes_demoArea,'Visible','off');

% ���������ж�
h_interruptible_list = findobj(hObject, '-property','Interruptible');
set(h_interruptible_list, 'Interruptible', 'off');
% ͳһ����String���ԵĿؼ���������ʽ��ע�⣡��������Ḳ��guide�н��е����ã�
% Ҳ����˵��������guide�и���ť����ʲô�������ƺʹ�С�����ᱻ���ӵ�
% ��Ӱ���GUI����text������axes�ϵ��Ǹ�text������edit��pushbutton��radiobutton
h_property_string_list = findobj(hObject, '-property','String');
set(h_property_string_list, 'FontSize',10.0);
set(h_property_string_list, 'FontName','΢���ź�');
% ͳһ���к���Title���ԵĿؼ���������ʽ
% ��Ӱ��GUI�Ķ���uipanel
h_property_title_list = findobj(hObject, '-property','Title');
set(h_property_title_list, 'FontSize',10.0);
set(h_property_title_list, 'FontName','΢���ź�');

% ���������ݵ���ʼ״̬��
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
%                             �ǻص�����
%--------------------------------------------------------------------------
function guiSetEnable(handles)
% �ÿؼ�Ϊ����ʾ������̡�״̬
set(handles.button_next,'Enable','on');  %  ����һ������ťʹ��
set(handles.button_startDemo, 'Enable','off')  % �����ɹ�����������ť��ֹ
set(handles.button_decode,'Enable','off');             % �����롱��ť��ֹ
set(handles.edit_sourceProbability,'Enable','off');  % ��Դ������ֹ
set(handles.edit_sourceSymbol,'Enable','off');       % ��Դ����������ֹs
set(handles.radiobutton_encodingMode_0, 'Enable', 'off');  % ���õ�ѡ��ť
set(handles.radiobutton_encodingMode_1, 'Enable', 'off');

%--------------------------------------------------------------------------
function guiResetAll(handles)
%guiResetAll ����һ��
guiResetWidget(handles);
guiResetEnable(handles);
%--------------------------------------------------------------------------
function guiResetWidget(handles)
%guiResetWidget ��������Ϊ��ʼ״̬
global NEXT_BUTTON_ENTRY_CNT;
global ENCODING_MODE;
ENCODING_MODE = 0;
set(handles.axes_demoArea,'YDir','reverse');  % ��y����������
axes(handles.axes_demoArea);
cla;
NEXT_BUTTON_ENTRY_CNT = 0;
set(handles.text_decodeResult,'String','');
set(handles.text_averageCodeLength,'string','');
set(handles.text_sourceEntropy,'string','');
set(handles.text_codingEfficiency,'string','');
set(handles.edit_sourceProbability,'string','0.25, 0.25, 0.2, 0.15, 0.10, 0.05');
set(handles.edit_sourceSymbol,'string','''a'',''o'',''r'',''S'',''i'',''t''');
set(handles.edit_sequenceToDecode,'String','11000111101101110');  % �趨һ����ʼ���Ŀ������ֵ
set(handles.radiobutton_encodingMode_1,'Value',0);    % ȡ��ѡ��ģʽ1
set(handles.radiobutton_encodingMode_0,'Value',1);    % ѡ��ģʽ0

%--------------------------------------------------------------------------
function guiResetEnable(handles)
%guiResetEnable ����GUI�ؼ�ʹ��Ϊ��ʼ״̬
set(handles.button_startDemo,'Enable','on');  % ʹ�ܡ���ʼ��ʾ����ť
set(handles.button_decode,'Enable','off');             % �����롱��ť��ֹ
set(handles.button_next, 'Enable', 'off');  % ������һ����ť
set(handles.radiobutton_encodingMode_0, 'Enable', 'on');  % ʹ�ܵ�ѡ��ť
set(handles.radiobutton_encodingMode_1, 'Enable', 'on');
set(handles.edit_sourceProbability,'Enable','on');  % ����ʹ����Դ�����
set(handles.edit_sourceSymbol,'Enable','on');       % ʹ����Դ���������
%--------------------------------------------------------------------------
function [probability, count, symbol] = evalUserInput(input_prob, input_sym)
%evalUserInput ����û�����
% input_string_1����ʾ��Դ���ʵ��ַ���
% input_string_2����ʾ��Դ���ŵ��ַ���
% �����ȷ��status = true��probability��count�ֱ�ֵ��Դ���ʾ������Դ���Ÿ���
% ������󣬵���error��ʾ�� probability = count = NaN
try
    mat = eval(strcat('[', input_prob, ']'));
    symbol = eval(strcat('{', input_sym, '}'));
catch exception
    errordlg('��������...��������','����','modal');
    error('��������...��������');
end
count = length(mat);
mat_sum = sum(mat);
if (any(mat <= 0))  % mat����<0��Ԫ��
    probability = NaN;
    count = NaN;
    symbol = NaN;
    errordlg('�㲻������һ������/����Ϊ���ʡ�������Ϣ����Command Window���ֵĴ�����Ϣ','����');
    error('ERROR: You cannot give a negative number or zero as probability');
end
if (any(mat >= 1))  % mat����>=1��Ԫ��
    probability = NaN;
    count = NaN;
    symbol = NaN;
    errordlg('�㲻��������ڵ���1������Ϊ���ʡ�������Ϣ����Command Window���ֵĴ�����Ϣ','����');
    error('ERROR: You cannot give a number greater equal than 1 as probability');
end

if (abs(mat_sum - 1) >= 1e-5)  % mat_sum ~= 1.0�����������õ�������ǳ���eps�����ƺ���������ʺܶ��ʱ�򲻺�ʹ
    probability = NaN;
    count = NaN;
    symbol = NaN;
    errordlg('�������֮�Ͳ�����1��������Ϣ����Command Window���ֵĴ�����Ϣ','����');
    error('ERROR: Probabilities do not add up to 1');
end

if (length(symbol) ~= length(mat))
    probability = NaN;
    count = NaN;
    symbol = NaN;
    errordlg('��Դ���ʺ���Դ���Ų��ȳ���������Ϣ����Command Window���ֵĴ�����Ϣ','����');
    error('ERROR: The length of probabilty matrix and symbol cell is not equal');
end
probability = mat;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Fano������� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------------------
function node = structSource_new(str_symbol, n_prob)
%fanoTreeNode_new ������Դ�ṹ��
% str_symbol    -    char����Դ����
% n_prob        -    double���˷��ŵĸ���
% ����һ������symbol��prob��code�����Ľ��
% ����str_code�ǶԴ˷��ŵı���.��ʼ��Ϊ''
node = struct('symbol', str_symbol, ...
              'prob',   n_prob);
%--------------------------------------------------------------------------
function [ nodes_sorted ] = structSource_sort( nodes )
%structSource_sort ����Դ��������
len = length(nodes);
[cell_prob{1:len}] = nodes.prob;
arr_prob = cell2mat(cell_prob);
[~, ind] = sort(arr_prob, 'descend');
nodes_sorted = nodes(ind);
%--------------------------------------------------------------------------
function node = fanoTreeNode_new( n_prob, n_range, code, up, down)
%fanoTreeNode_new ����һ���µ�fano���Ľ��
%   n_prob           -  ��������ǰ���ĸ���
%   code             -  char����ǰ���Ӧ����
%   n_range          -  1x2���飬��ǰ���������Դ��������±귶Χ��
%                       n_range(1)��ʾ��Ԫ���±꣬n_range(2)��ʾβԪ���±�
%   node             -  �������Ľ��
%   up, down         -  �Ϸ�֧���·�ָ֧��
node = struct('prob', n_prob, ...
              'code', code, ...
              'range', n_range, ...
              'up', up, ...
              'down', down);
%--------------------------------------------------------------------------
function division = findDivisionInd( arr, ind_start )
%findDivisionInd ��������n_arr�ֽ��
%   arr        -  Ҫ���ҷֽ������顣�������Ѿ���������
%   n_start      -  arr(1)��Ӧ��������Դ���ŵ��±�
%   division_ind -  arr��������Դ�����еķֽ��
len = length(arr);
if len > 2
    d0 = abs( arr(1) - sum(arr(2:len)) );
    for k = 2:len
        d1 = abs( sum(arr(1:k)) - sum(arr((k+1):len)) );
        if d0 <= d1    % �ҵ��ֽ��
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
%fanoTreeNode_makeNextLevel �ɵ�ǰ��Ľ��������һ����
%   source_prob           -  ������Դ��������
%   nodes_current_level   -  ����������Ҳ���������ǰ������н��
n = length(nodes_current_level);
k = 1;    % ָ����һ�����ָ��
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
    
    % �Ϸ�֧����a���·�֧����b
    nodes_next_level{k} = fanoTreeNode_new(s_up, [ind_start, floor(division)], 'a', [], []);
    nodes_current_level{i}.up = k;
    k = k + 1;
    nodes_next_level{k} = fanoTreeNode_new(s_down, [ceil(division), ind_end ], 'b', [], []);
    nodes_current_level{i}.down = k;
    k = k + 1; 
end
%--------------------------------------------------------------------------
function bool = fanoTreeNode_isLeaf( node )
%fanoTreeNode_isLeaf ��ǰ���node�����Ƿ�ʱҶ�ӽ��
if node.range(1) == node.range(2)
    bool = true;
else
    bool = false;
end
%--------------------------------------------------------------------------
function fano_tree = fanoTree_new( nodes_source )
%fanoTree_new ����һ�÷�ŵ��
%  nodes_source  -  ��������structSource_new����Ľṹ��
nodes_source = structSource_sort(nodes_source);      % ��������
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
%fanoTree_makeDict ���ɱ����ֵ�
%   FANO_DICT        - global, cell��������Դ����������ӳ���ϵ��
%                      dict{:,1}Ϊ��Դ���ţ��±꣩
%                      dict{:,2}Ϊ��Ӧ�ı��루��a��b������0��1��Ϊ���ţ�
%   SIZE_FANO_DICT    - global, �������ֵ�������������ע�⣡���ñ�����ǰ
%                      SIZE_FANO_DICT���뱻��ʼ����1��
%   current_node     - ��ǰ���
%   current_level    - ��ǰ����
%   tree             - ������Fano��
% ����һ���ݹ���õĺ������������õ�current_node���Ǹ��ڵ�
% ����fanoTree_makeDict(tree{1}{1}, 1, tree, '');
global FANO_DICT;
global SIZE_FANO_DICT;
% ������ŵ��
if current_node.range(1) ~= current_node.range(2)    % ��ǰ��㲻��Ҷ�ӽ��
    fanoTree_makeDict(tree{current_level + 1}{current_node.up}, ...
                      current_level + 1, ...
                      tree, ...
                      strcat(current_code, current_node.code) );
    fanoTree_makeDict(tree{current_level + 1}{current_node.down}, ...
                      current_level + 1, ...
                      tree, ...
                      strcat(current_code, current_node.code) );
else    % ��ǰ�����Ҷ�ӽ��
    FANO_DICT{SIZE_FANO_DICT, 1} = current_node.range(1);
    FANO_DICT{SIZE_FANO_DICT, 2} = strcat(current_code, current_node.code);
    SIZE_FANO_DICT = SIZE_FANO_DICT + 1;
end
%--------------------------------------------------------------------------
function index = fanoTree_dictLookup(code, dict)
%fanoTree_dictLookup �����ֵ��ѯcode���ֵ�dict�ж�Ӧ���±�index
[n, ~] = size(dict);
index = [];
for i=1:n
    if strcmp(code, dict{i,2})
        index = i;
        break;
    end
end
if isempty(index)
    index = -1;    % û�ҵ�
end
%--------------------------------------------------------------------------
function seq_translated = decodeTranslate(seq, mode)
%fanoTree_decodeModeTranslate ����ģʽ��seq�������Ӧ����a��b������ĸ��ɵ�����
%    �˺������fanoTree_seqDecodeʹ��
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
%fanoTree_seqDecode �������뺯��
%   seq    -  ��������
%   source -  ��structSource_sort������������Դ
%   tree   -  Fano��
%   dict   -  ��fanoTree_makeDict�������ɵ��ֵ�
%   mode   -  ����ģʽ
%   msg    -  ����õ�����Ϣ���С���������������׳��쳣
seq = decodeTranslate(seq, mode);
p = 1;    % ����ָ��
q = 1;    % ��һ������ָ��
node_ptr = [1 1];   % ��ָ�룬��һ������ָ��������ڶ���ָ�����ڲ�Ľ���±�
seq_len = length(seq);   % ���г���
msg = '';


while q <= seq_len
    if seq(q) == 'a'
    node_ptr(2) = tree{node_ptr(1)}{node_ptr(2)}.up;
    node_ptr(1) = node_ptr(1) + 1;
    elseif seq(q) == 'b'
        node_ptr(2) = tree{node_ptr(1)}{node_ptr(2)}.down;
        node_ptr(1) = node_ptr(1) + 1;
    else
        error('seqDecode:invalid_seq', '������������������ֵĶ�����"%c"',seq(q));
    end
    % ����Ҷ�ӽ��Ͳ��ֵ�
    if fanoTreeNode_isLeaf(tree{node_ptr(1)}{node_ptr(2)}) && (node_ptr(1) ~= 1)
        ind = fanoTree_dictLookup( seq(p:q), dict);
        if ind == -1
            error('seqDecode:unexpected_error', '������������������еĳ���Ӧ���뱾��֧');
        end
        msg = strcat(msg, source(ind).symbol);
        q = q + 1;
        p = q;
        node_ptr = [1 1];   % ��ָ������
    else
        q = q + 1;
    end
end

if (p ~= q) && (q >= seq_len)
    error('seqDecode:cannot_decode', '�����а������ܱ����������');
end
%--------------------------------------------------------------------------


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ������� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------------------
function avg_len = getAvgCodeLen(nodes_source, dict)
%getAvgCodeLen ��ƽ���볤
%  nodes_source - ��Դ�ṹ��
%  dict         -  �����ֵ䡣����ʱ��ȫ�ֱ���FANO_DICT����
[source_count, ~] = size(dict);
avg_len = 0;
for i = 1:source_count
    avg_len = avg_len + nodes_source(i).prob * length(dict{i,2});
end
%--------------------------------------------------------------------------
function H = getSourceEntropy(nodes_source)
%getSourceEntropy ����Դ�� ��λbit/����
%   nodes_source����Դ�ṹ��
s = 0;
source_count = length(nodes_source);
for i=1:source_count
    s = s + nodes_source(i).prob * log2(nodes_source(i).prob);
end
s = -s;
H = s;
%--------------------------------------------------------------------------


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ��ͼ��� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------------------
function drawSource(h_axes, nodes_source, source_count)
%drawSource ��h_axes�ϻ�����Դ���ź���Դ����
% �ɻص�����button_startDemo����
axes(h_axes);
text('String','��Դ����','Position', [0, 0], 'HorizontalAlignment', 'center');
text('String','��Դ����','Position', [1, 0], 'HorizontalAlignment', 'center');
for i=1:source_count
    text('String',nodes_source(i).symbol,'Position', [0, i], 'HorizontalAlignment', 'center');
    text('String', num2str(nodes_source(i).prob), 'Position', [1, i], 'HorizontalAlignment', 'center');
end
% ���߿���
line([-0.5, 1.5], [0.5, 0.5]);                  % �ϱ߿�
line([-0.5, 1.5], [source_count+0.5, source_count+0.5]);  % �±߿�
line([-0.5, -0.5], [0.5, source_count+0.5]);    % ��߿�
line([1.5, 1.5], [0.5, source_count+0.5]);      % �ұ߿�
% �ڱ߿�
line([0.5, 0.5], [0.5, source_count+0.5]);    % ��߿�
for i=1:(source_count - 1)
    line([-0.5 1.5], [i+0.5, i+0.5]);
end
%--------------------------------------------------------------------------
function drawLevel(h_axes, tree_level, n_level,nodes_source, encoding_mode)
%drawLevel ��h_axes����tree_level������n_level˵����ǰ���Ƶ��ǵڼ���
% �ɻص�����button_next_Callback����
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
%drawBorder ��h_axes����tree_level�ķֽ��ߡ�����n_level˵����ǰ���Ƶ��ǵڼ���
% ����source_count��Ϊ��ȷ������֮��ķָ���Ӧ�û��೤����Ĳ������μ�����drawSource��
% �ɻص�����button_next_Callback����
axes(h_axes);
cnt = length(tree_level);
% �����������֮��ķָ���
for i=1:(cnt - 1)
    y_pos = (tree_level{i}.range(2) + tree_level{i+1}.range(1)) / 2;
    line([n_level-0.5, n_level+0.5], [y_pos, y_pos]);
end

% ���Ƶ�һ���������һ���ڵ�����µķָ���
y_pos = tree_level{1}.range(1) - 0.5;
line([n_level-0.5, n_level+0.5], [y_pos, y_pos]);
y_pos = tree_level{cnt}.range(2) + 0.5;
line([n_level-0.5, n_level+0.5], [y_pos, y_pos]);
% ����ÿ������Ҳ�ķָ���
for i=1:cnt
    y_pos_start = tree_level{i}.range(1) - 0.5;
    y_pos_end   = tree_level{i}.range(2) + 0.5;
    line([n_level+0.5, n_level+0.5], [y_pos_start, y_pos_end]);
end
%--------------------------------------------------------------------------
function drawCode(h_axes, dict, tree_depth, encoding_mode)
%drawCode �����ֻ��Ƶ�ͼ��
axes(h_axes);
[cnt, ~] = size(dict);
x_pos = tree_depth + 1;
text('String', '����', 'Position', [x_pos, 0], 'HorizontalAlignment', 'center');
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


%----------------------------�ǻص����� end--------------------------------

%--------------------------------------------------------------------------
%                              �ص�����
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
global FANO_DICT;    % fanoTree_makeDict��ʽʹ���˴˱�����Ϊ���롣�벻Ҫɾ������global����
global SIZE_FANO_DICT;
FANO_DICT = {};
SIZE_FANO_DICT = 1;
axes(handles.axes_demoArea);   % set(gcf,'CurrentAxes',handles.axes_demoArea);
cla;  % ���֮ǰ��������

input_prob = get(handles.edit_sourceProbability, 'String');
input_sym = get(handles.edit_sourceSymbol, 'String');
[source_probability, source_count, source_symbol] = evalUserInput(input_prob, input_sym);
% Ԥ�ȷ���洢�ռ�
NODES_SOURCE = struct('prob',zeros(source_count, 1), ...
                      'symbol', char(zeros(source_count,1)));
for i=1:source_count
    NODES_SOURCE(i).prob = source_probability(i);
    NODES_SOURCE(i).symbol = source_symbol(i);
end
NODES_SOURCE = structSource_sort(NODES_SOURCE);
FANO_TREE = fanoTree_new(NODES_SOURCE);
axis([-0.5, length(FANO_TREE)+1.5, -0.5, source_count+0.5]);    % ������Ұ
fanoTree_makeDict(FANO_TREE{1}{1}, 1, FANO_TREE, '');   % ��������ʱ���õ����ֵ�

drawSource(handles.axes_demoArea, NODES_SOURCE, source_count);

guiSetEnable(handles);    % ��������ؼ��ϵ�ʹ��
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
% disp('button_next');    % ������
NEXT_BUTTON_ENTRY_CNT = NEXT_BUTTON_ENTRY_CNT + 1;
% disp(NEXT_BUTTON_ENTRY_CNT);    % ������
axes(handles.axes_demoArea);

if NEXT_BUTTON_ENTRY_CNT < tree_depth
    drawLevel(handles.axes_demoArea, FANO_TREE{NEXT_BUTTON_ENTRY_CNT+1}, ...
              NEXT_BUTTON_ENTRY_CNT+1, NODES_SOURCE, ENCODING_MODE);
    drawBorder(handles.axes_demoArea, FANO_TREE{NEXT_BUTTON_ENTRY_CNT+1}, ...
              NEXT_BUTTON_ENTRY_CNT+1);
end


% �������ƽ���
if NEXT_BUTTON_ENTRY_CNT >= tree_depth - 1
    % ��������
    drawCode(handles.axes_demoArea, FANO_DICT, tree_depth, ENCODING_MODE);
    % ��Դ��
    H = getSourceEntropy(NODES_SOURCE);
    
    % ƽ���볤
    N = getAvgCodeLen(NODES_SOURCE, FANO_DICT);
    
    % ����Ч��
    P = H / N;
    % ����GUI�Ҳ����ʾ��
    set(handles.text_averageCodeLength,'string',num2str(N));
    set(handles.text_sourceEntropy,'string',num2str(H));
    set(handles.text_codingEfficiency,'string',num2str(P));
    NEXT_BUTTON_ENTRY_CNT = 0;  % ��������λ
    set(handles.edit_sourceProbability,'Enable','on');  % ����ʹ����Դ�����
    set(handles.edit_sourceSymbol,'Enable','on');       % ʹ����Դ���������
    set(handles.button_startDemo,'Enable','on');  % ����ʹ�ܡ�������������ť
    set(handles.button_decode,'Enable','on');     % �����롱��ťʹ��
    set(handles.button_next, 'Enable', 'off');  % ���á���һ������ť
    set(handles.radiobutton_encodingMode_0, 'Enable', 'on');  % ʹ�ܵ�ѡ��ť
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
        error('����Ӧ�ý���˷�֧��һ����ʲô�ط������ˣ�');
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
global FANO_DICT;                       % �������롢�������е������ֵ�
global NODES_SOURCE;
global ENCODING_MODE;

% ��ȡ����������
sequence = get(handles.edit_sequenceToDecode,'string');
try
    msg = fanoTree_seqDecode( sequence, NODES_SOURCE, FANO_TREE, FANO_DICT, ENCODING_MODE );
catch exception
    msg = '�޷�����';
    switch(exception.identifier)
        case 'seqDecode:invalid_seq'
            errordlg('�����������ƺ���ʲô��ֵĶ�������','����', 'modal');
        case 'seqDecode:cannot_decode'
            errordlg('��������������������в����ڵ�����','����', 'modal');    
        otherwise
            errordlg('������������Command Window�����','����', 'modal');
            throw(exception);
    end
end
set(handles.text_decodeResult, 'String', msg);

%--------------------------------------------------------------------------
function menuitem_aboutSatori_Callback(hObject, eventdata, handles)
% msgbox('�������������־���޸�','����');
h_fig = figure;
set(h_fig,'units','pixels','Windowstyle','normal','Menubar','none',...
            'Name', '����Satori','NumberTitle','off','CloseRequestFcn','delete(gcf)');
h_axes = axes;
% axis off;

img = imread('Komeiji Satori.png');
h_img = imshow(img, 'Parent', h_axes);

axes_position = get(h_axes, 'Position');

msg_str = ['���𡸱�ѧ��֧��Ŀ־塹', ... 
            char(10),'�����ؾ���Komeiji Satori�����ѿ�����һ��'];
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
%%% ��ģ���漰���֮ʱ���Ҫ�Ѵ���������д�ã�
clear global -regexp NEXT_BUTTON_ENTRY_CNT ENCODING_MODE FANO_DICT SIZE_FANO_DICT NODES_SOURCE FANO_TREE
% disp('��ǵ�������������ı�д');
% Hint: delete(hObject) closes the figure
delete(hObject);

%--------------------------------------------------------------------------
function menuitem_aboutFano_Callback(hObject, eventdata, handles)
web 'https://zh.wikipedia.org/wiki/%E7%BE%85%E4%BC%AF%E7%89%B9%C2%B7%E6%B3%95%E8%AB%BE' -browser
%------------------------------�ص����� end--------------------------------
