%% For FCC
texfile1= 'TEX_PH1.OUT';
CS = crystalSymmetry('m-3m');
% SS = specimenSymmetry('1')
data= loadOrientation_generic(texfile1,'CS',CS,'ColumnNames',{'Euler1' 'Euler2' 'Euler3'}, 'Bunge');
odf = calcDensity(data);
figure;
plotPDF(odf,Miller(2,0,0,CS),'antipodal')
mtexColorbar
saveas(gcf,'PF_200_FCC.svg')
figure;
plotPDF(odf,Miller(1,1,1,CS),'antipodal')
mtexColorbar
saveas(gcf,'PF_111_FCC.svg')
% Visualize the ODF
figure;
plot(odf,'phi2',[0 45 65]*degree)
mtexColorbar
saveas(gcf,'ODF_0_45_65.svg')
figure;
plotIPDF(odf,zvector)
mtexColorbar
saveas(gcf,'IPF_ND_FCC.svg')

%% For BCC
texfile2= 'TEX_PH2.OUT';
CS = crystalSymmetry('m-3m');
% SS = specimenSymmetry('1');
data= loadOrientation_generic(texfile2,'CS',CS,'ColumnNames',{'Euler1' 'Euler2' 'Euler3'}, 'Bunge');
odf = calcDensity(data);
figure;
plotPDF(odf,Miller(1,1,0,CS),'antipodal')
mtexColorbar
saveas(gcf,'PF_110_BCC.svg')
figure;
plotPDF(odf,Miller(2,0,0,CS),'antipodal')
mtexColorbar
saveas(gcf,'PF_200_BCC.svg')
% Visualize the ODF
figure;
plot(odf,'phi2',[45]*degree);
mtexColorbar
saveas(gcf,'ODF_45.svg')
figure;
plotIPDF(odf,zvector)
mtexColorbar
saveas(gcf,'IPF_ND_BCC.svg')

%% ***********************************************************************
%  $$$$$$$$$$$$ Plotting Other Plots $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
% ************************************************************************
activity1 = readmatrix('ACT_PH1.OUT','FileType','text');
activity2 = readmatrix('ACT_PH2.OUT','FileType','text');
% STAT_AX.OUT  - statistics on grain axes 
% STAT.OUT GENERAL INFORMATION AT SELECTED STEPS
% epsacu = Statistics for deformation
% stat_ax= 'STAT_AX.OUT';
stress_strain_data = readmatrix('STR_STR.OUT','FileType','text');

% Plotting Stress vs Strain
Strain_vm = stress_strain_data(:,1);
Stress_vm = stress_strain_data(:,2);
figure()
plot(Strain_vm,Stress_vm)
%% change settings of PLOT
% &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
plt = Plot(); % create a Plot object and grab the current figure          &
plt.XLabel = 'Strain'; % xlabel                                           &
plt.YLabel = 'Stress'; %ylabel                                            &
plt.Title = 'Von-Mises Strain vs Stress'; % plot title                    &
% Save? comment the following line if you do not want to save             &
% plt.export('Stress-strain.svg');                                        &
% plt.Colors = {[0, 0, 0]};   % [red, green, blue]                        &
plt.LineWidth = 2;        % line width                                    &
plt.LineStyle = {'--'};   % line style: '-', ':', '--' etc                &
% change scale, axis limit, tick and grid:                                &
% plt.YScale = 'log';     % 'linear' or 'log'                             &
% plt.YLim = [12, 13]; % [min, max]                                       &
% plt.XLim = [1E-3, 0.6]; % [min, max]                                    &
% plt.YTick = [1E-3, 1E-1, 1E1, 1E3]; %[tick1, tick2, .. ]                &
% plt.YGrid = 'on';       % 'on' or 'off'                                 &
% &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

%% Plotting AVACS
% X-axis = Strain i.e. Column 1 of either ACT_PHn.OUT file
% Y-axis = Evolution of (g) average active slip systems (AVACS)
% OR average number of activity system per grain (AVACS)
% Variable name above is activity1 and activity2
STRAIN = activity1(:,1);
AVACS_ph1 = activity1(:,2);
AVACS_ph2 = activity2(:,2);
% plot them
plt = Plot(STRAIN, AVACS_ph1, STRAIN, AVACS_ph2);
%% change settings of PLOT
% &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
plt = Plot(); % create a Plot object and grab the current figure          &
plt.XLabel = 'True Strain'; % xlabel                                           &
plt.YLabel = 'AVACS'; %ylabel                                            &
% plt.Title = 'Average number of activity system per grain vs True Strain'; % plot title                    &
% Save? comment the following line if you do not want to save             &
% plt.export('Stress-strain.svg');                                        &
% plt.Colors = {[0, 0, 0]};   % [red, green, blue]                        &
plt.LineWidth = 2;        % line width                                    &
plt.LineStyle = {'--'};   % line style: '-', ':', '--' etc                &
% change scale, axis limit, tick and grid:                                &
% plt.YScale = 'log';     % 'linear' or 'log'                             &
plt.YLim = [6, 8]; % [min, max]                                       &
% plt.XLim = [0, 0.6]; % [min, max]                                    &
% plt.YTick = [1E-3, 1E-1, 1E1, 1E3]; %[tick1, tick2, .. ]                &
% plt.YGrid = 'on';       % 'on' or 'off'                                 &
plt.Legend = {'Matrix', 'Tungsten'}; % legends
% &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


%% Plotting Activity
% X-axis =Strain i.e. Column 1 of either ACT_PHn.OUT file
% Y-axis = Activity of different Modes of Slip-system
% Header of Activity is MODEn
[~, no_of_Col] = size(activity2);
STRAIN = activity1(:,1);
Mode_1_FCC = activity1(:,3);
Mode_1_BCC = activity2(:,3);
if no_of_Col>3
    Mode_2_BCC = activity2(:,4);
end
% plot them
if no_of_Col>3
plt = Plot(STRAIN, Mode_1_FCC, STRAIN, Mode_1_BCC,STRAIN, Mode_2_BCC);
else
    plt = Plot(STRAIN, Mode_1_FCC, STRAIN, Mode_1_BCC);
end
%% change settings of PLOT
% &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
plt = Plot(); % create a Plot object and grab the current figure          &
plt.XLabel = 'True Strain'; % xlabel                                           &
plt.YLabel = 'Relative Activity'; %ylabel                                            &
% plt.Title = 'Average number of activity system per grain vs True Strain'; % plot title                    &
% Save? comment the following line if you do not want to save             &
% plt.export('Stress-strain.svg');                                        &
% plt.Colors = {[0, 0, 0]};   % [red, green, blue]                        &
plt.LineWidth = 2;        % line width                                    &
plt.LineStyle = {'--'};   % line style: '-', ':', '--' etc                &
% change scale, axis limit, tick and grid:                                &
% plt.YScale = 'log';     % 'linear' or 'log'                             &
% plt.YLim = [6, 8]; % [min, max]                                       &
% plt.XLim = [0, 0.6]; % [min, max]                                    &
% plt.YTick = [1E-3, 1E-1, 1E1, 1E3]; %[tick1, tick2, .. ]                &
% plt.YGrid = 'on';       % 'on' or 'off'                                 &
plt.Legend = {'Matrix', 'Tungsten'}; % legends

plt.Colors = {                 % three colors for three data set
    [1,      0,       0]        % data set 1
    [0.25,   0.25,    0.25]     % data set 2
    [0,      0,       1]        % data set 3
    };
plt.LineWidth = [2, 2, 2];       % three line widths
plt.LineStyle = {'-', '-', '-'}; % three line styles
plt.Markers = {'o', '', 's'};
% plt.MarkerSpacing = [15, 15, 15];
plt.Legend = {'FCC', 'BCC-I', 'BCC-II'}; % legends
plt.LegendLoc = 'best';

%% End
