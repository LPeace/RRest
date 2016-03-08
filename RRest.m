function RRest(period)
% RRest runs RR algorithms on ECG and PPG signals using each possible
% combination of options, as specified in "setup_universal_params.m".
%
%               RRest('mimic')
%
%	Inputs:
%		data            data files should be stored in the specified format
%                       in the directory specified in
%                       "setup_universal_params.m". Data can be downloaded
%                       using the "
%       period          this string specifies the dataset to be analysed.
%                       Only the 'mimic' dataset has been used with this
%                       version of the toolbox.
%
%	Outputs:
%       for each subject, N, the following files are made:
%           N_int_respSigs      intermediate respiratory signals,
%           N_respSigs          final respiratory signals
%           N_rrEsts            RR estimates
%           N_rrRef             Reference RR values
%           N_sqi               Signal Quality Index values
%       for the entire dataset, the following files are made:
%           alg_names           Names of RR algorithms tested
%           win_data            Data for every algorithm tested, every
%                               window, and every subject.
%
%   Context:    This is the main file used to run the algorithms. It calls
%               lots of other functions, contained in separate files.
%           
%   Further Information:
%       This version of the RRest is provided to facilitate reproduction of
%       the analysis performed in:
%           Charlton P.H. et al., "Waveform Analysis to Estimate
%           Respiratory Rate" [In Press]
%       Further information on this study can be obtained at:
%           http://peterhcharlton.github.io/RRest/waveform_analysis.html
%       In addition, further information on RRest, including future
%       versions, can be obtained at:
%           http://peterhcharlton.github.io/RRest/index.html
%
%   Comments, Questions, Criticisms, Feedback, Contributions:
%       See: http://peterhcharlton.github.io/RRest/contributions.html
%
%   Version:
%       v.1 - published on 23rd Feb 2016 by Peter Charlton
%
%   Licence:
%       please see the accompanying file named "LICENSE"
%

%% Setup Universal Parameters
% The universal parameters are used throughout the algorithms
up = setup_universal_params(period);

%% Estimate RRs from ECG and PPG
% Carry out processing for each stage of the algorithms
for key_comp_no = 1 : length(up.al.key_components)
    feval(up.al.key_components{key_comp_no}, up);
end

%% Conduct Signal Quality Assessment of Signals
% Each window
calculate_sqi(up);

%% Estimate Reference RRs
estimate_ref_rr(up);

%% Statistical Analysis
calc_stats4(up);
create_table_of_algorithms(up);

end