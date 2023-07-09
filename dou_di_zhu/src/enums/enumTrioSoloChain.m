
%枚举所有飞机带小翼(连三带一)，最少2连
%实际上 手牌最多有20张，所以最多只有5连
function ret = enumTrioSoloChain(len)
load('CARDS.mat');
    chain_base = [2, 11];
    trio_chain_number = chain_base(2)-(len-chain_base(1));
    [~,size_rank] = size(CARDS_RANK);
    total_number = trio_chain_number * ( (size_rank-2)*(size_rank-2) -2);
    ret = cell(2, total_number);
    ed = 1; 
    for i = 1:(size_rank -len - 2) %飞机开头的数量
        residual = [CARDS_RANK(1:(i-1)), CARDS_RANK(i+len:13) ];
        residual = [residual,residual,residual,residual, 14, 15];
        kickers = combnk(residual,len);
        kickers = unique(sort(kickers,2),'row');
        [extend,~] = size(kickers);
        ret(1, ed:ed+extend-1) = repmat( cellstr(strjoin(CARDS_TRIO(i:i+len-1),"-")),1,extend);        
        ret(2, ed:ed+extend-1) = {CARDS_RANK(i)};
        for j = 1:(extend) %
            ret{1, ed+j-1} = ret{1,ed+j-1} + "-"+ strjoin(CARDS(kickers(j,:)), "-");
        end
        ed = ed + extend;
    end
    id= cellfun('length', ret);
    ret(id==0) = [];
    ret = reshape(ret, 2, []);
    [~,size_t] = size(ret);
    for i = 1:size_t
        ret{1,i} = strjoin(sortCards(chain2cards(ret{1,i})),"-");
    end
end
