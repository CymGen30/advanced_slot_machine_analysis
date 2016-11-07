function [q] = excel_to_questionnaire(FILENAME, varargin)
% Run function:
% [questionnaire_struct] = excel_to_questionnaire_struct(FILENAME, varargin: extra_fields)
[data text raw] = xlsread(FILENAME);
fields = text(1,:);

%% Pull all total fields
total_idx = [];
for i = 1:length(fields)
    if strfind(fields{i},'Total')
        total_idx = [total_idx i];
    elseif strfind(fields{i},'ID');
        id_idx = i;
    end
end

%% Pull extra fields
if length(varargin)>0
    for n = 1:length(varargin)
        for m = 1:length(fields)
            if strfind(fields{m},varargin(n))
                extra_idx = m;
            end
        end
    end
end
%% Append fields to structure
q = struct;
q.labels = data(:,id_idx);
for k = 1:length(total_idx)
    fieldname = strrep(fields{total_idx(k)},' ','_');
    q.(fieldname) = data(:,total_idx(k));
end



