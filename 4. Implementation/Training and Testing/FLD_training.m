function base_learner = FLD_training(Xc,Xs,base_learner,OOB,settings)
%pause(4);
% FLD TRAINING
Xm = Xc(OOB.SUB,base_learner.subspace);
Xp = Xs(OOB.SUB,base_learner.subspace);

% remove constants
remove = false(1,size(Xm,2));
adepts = unique([find(Xm(1,:)==Xm(2,:)) find(Xp(1,:)==Xp(2,:))]);
for ad_id = adepts
    U1=unique(Xm(:,ad_id));
    if numel(U1)==1
        U2=unique(Xp(:,ad_id));
        if numel(U2)==1, if U1==U2, remove(ad_id) = true; end; end
    end
end

muC  = sum(Xm,1); muC = double(muC)/size(Xm,1);
muS  = sum(Xp,1); muS = double(muS)/size(Xp,1);
mu = (muS-muC)';

% calculate sigC
xc = bsxfun(@minus,Xm,muC);
sigC = xc'*xc;  
sigC = double(sigC)/size(Xm,1);

% calculate sigS
xc = bsxfun(@minus,Xp,muS);
sigS = xc'*xc;
sigS = double(sigS)/size(Xp,1);

sigCS = sigC + sigS;

% regularization
sigCS = sigCS + 1e-10*eye(size(sigC,1));

% check for NaN values (may occur when the feature value is constant over images)
nan_values = sum(isnan(sigCS))>0;
nan_values = nan_values | remove;

sigCS = sigCS(~nan_values,~nan_values);
mu = mu(~nan_values);
lastwarn('');
warning('off','MATLAB:nearlySingularMatrix');
warning('off','MATLAB:singularMatrix');
base_learner.w = sigCS\mu;
% regularization (if necessary)
[txt,warnid] = lastwarn(); %#ok<ASGLU>
while strcmp(warnid,'MATLAB:singularMatrix') || (strcmp(warnid,'MATLAB:nearlySingularMatrix') && ~settings.ignore_nearly_singular_matrix_warning)
    lastwarn('');
    if ~exist('counter','var'), counter=1; else counter = counter*5; end
    sigCS = sigCS + counter*eps*eye(size(sigCS,1));
    base_learner.w = sigCS\mu;
    [txt,warnid] = lastwarn(); %#ok<ASGLU>
end    
warning('on','MATLAB:nearlySingularMatrix');
warning('on','MATLAB:singularMatrix');
if length(sigCS)~=length(sigC)
    % resolve previously found NaN values, set the corresponding elements of w equal to zero
    w_new = zeros(length(sigC),1);
    w_new(~nan_values) = base_learner.w;
    base_learner.w = w_new;
end

% find threshold to minimize FA+MD
[base_learner] = findThreshold(Xm,Xp,base_learner);

function [base_learner] = findThreshold(Xm,Xp,base_learner)
%pause(3);
% find threshold through minimizing (MD+FA)/2, where MD stands for the
% missed detection rate and FA for the false alarms rate
P1 = Xm*base_learner.w;
P2 = Xp*base_learner.w;
L = [-ones(size(Xm,1),1);ones(size(Xp,1),1)];
[P,IX] = sort([P1;P2]);
L = L(IX);
Lm = (L==-1);
sgn = 1;

MD = 0;
FA = sum(Lm);
MD2=FA;
FA2=MD;
Emin = (FA+MD);
Eact = zeros(size(L-1));
Eact2 = Eact;
for idTr=1:length(P)-1
    if L(idTr)==-1
        FA=FA-1;
        MD2=MD2+1;
    else
        FA2=FA2-1;
        MD=MD+1;
    end
    Eact(idTr) = FA+MD;
    Eact2(idTr) = FA2+MD2;
    
    if Eact(idTr)<Emin
        Emin = Eact(idTr);
        iopt = idTr;
        sgn=1;
    end
    if Eact2(idTr)<Emin
        Emin = Eact2(idTr);
        iopt = idTr;
        sgn=-1;
    end
end
%pause(5);
base_learner.b = sgn*0.5*(P(iopt)+P(iopt+1));
if sgn==-1, base_learner.w = -base_learner.w; end