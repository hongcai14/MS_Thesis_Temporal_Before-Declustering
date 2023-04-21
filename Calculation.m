%% Loading Data

load SCEDC_1982_to_2022.mat
%^load data 

%% Monthly b_ML, b_LS, D2 Calculations (without declustering) 

bot = 2.5;
%^min magnitude restriction
top = 4.5;
%^max magnitude restriction 

SCEDC_temp = SCEDC_raw(SCEDC_raw(:,7) >= bot & SCEDC_raw(:,7) <= top,:);
%^restricts data to earthquakes with magnitudes contained in the interval
%[bot, top]

month_count = (max(SCEDC_temp(:,3)) - min(SCEDC_temp(:,3)) + 1)*12;

b_ML = NaN(1,month_count);
b_ML_error = NaN(1,month_count);

b_LS = NaN(1,month_count);
b_LS_error = NaN(1,month_count);

D2 = NaN(1,month_count);
D2_error = NaN(1,month_count);

s = 10.^(-1:0.1:3);
i = 11:1:21;
%^s(i) corresponds to s values contained in the interval [1 km, 10 km]

count = 1;

for ii = min(SCEDC_temp(:,3)):1:max(SCEDC_temp(:,3))
    year = SCEDC_temp(SCEDC_temp(:,3) == ii,:);
    for jj = 1:1:12
        month = year(year(:,1) == jj,:);
        if size(month,1) >= 30
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % b_ML value calculation
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            b_ML(count) = b_calc_fun(month(:,7));
            b_ML_error(count) = b_error_calc_fun(month(:,7),b_ML(count));

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % b_LS value calculation 
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            magnitudes = month(:,7);
            
            Fanta = NaN(length(unique(magnitudes)),2);
            Fanta(:,2) = unique(magnitudes);
            %^magnitudes are arranged from top to bottom in ascending order

            for mm = 1:1:length(unique(magnitudes))
                Fanta(mm,1) = sum(magnitudes >= Fanta(mm,2));
            end

            b_LS_linear = polyfit(Fanta(:,2),log10(Fanta(:,1)),1);
            b_LS(count) = -b_LS_linear(1);

            Sunkist = Fanta';

            b_LS_error(count) = error_calc_fun(Sunkist(2,:),log10(Fanta(:,1)));

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % D2 value calculation 
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            CI = CI_calc_fun(month(:,8:10),s);

            D2(count) = D2_calc_fun(CI,s,i);
            D2_error(count) = error_calc_fun(log10(s(i)),log10(CI(i)));

        end
        if count ~= month_count
            count = count + 1;
        end
    end
end

%% Saving Data 

filename = 'Temporal_Results_Before_Declustering.mat';
save(filename)
