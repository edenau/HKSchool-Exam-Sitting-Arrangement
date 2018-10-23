%%% Try to replace all names with fake ones
clear

%% Check if there is any repeated name
table = readtable('ele_list_sensitive.csv');
name = readtable('gen_name.csv');
name = name(:,2);

student_class = cell2mat(table2cell(table(:,1))); % 4A to 6E
student_form = str2num(student_class(:,1)); % 4 to 6
student_class = double(student_class(:,2)) - 64*ones(length(student_class),1); % A to E -> 1 to 5
% since ASCII('A') = 65
student_no = table2array(table(:,2)); % 1 to 45

%% Check if there is any repeated name (very inefficient code but who cares)
%for cnt = 1:(height(name)-1)
%    for cnt2 = (cnt+1):height(name)
%        if strcmp(name(cnt,1),name(cnt2,1))
%            print('Shit');
%        end
%    end
%end

%% 

for cnt = 1:height(table)
    index = (student_form(cnt)-4) * (45*5) + (student_class(cnt)-1) * 45 + student_no(cnt); % which index in table 'name' should be retrieved
    table(cnt,3) = name(index,1);
end

writetable(table,'ele_list.csv')