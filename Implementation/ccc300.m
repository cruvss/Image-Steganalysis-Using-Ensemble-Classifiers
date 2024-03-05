function F = ccc300(IMAGE,QF)
% -------------------------------------------------------------------------
% Copyright (c) 2011 DDE Lab, Binghamton University, NY.
% All Rights Reserved.
% -------------------------------------------------------------------------
% Permission to use, copy, modify, and distribute this software for
% educational, research and non-profit purposes, without fee, and without a
% written agreement is hereby granted, provided that this copyright notice
% appears in all copies. The program is supplied "as is," without any
% accompanying services from DDE Lab. DDE Lab does not warrant the
% operation of the program will be uninterrupted or error-free. The
% end-user understands that the program was developed for research purposes
% and is advised not to rely exclusively on the program for any reason. In
% no event shall Binghamton University or DDE Lab be liable to any party
% for direct, indirect, special, incidental, or consequential damages,
% including lost profits, arising out of the use of this software. DDE Lab
% disclaims any warranties, and has no obligations to provide maintenance,
% support, updates, enhancements or modifications.
% -------------------------------------------------------------------------
% Contact: jan@kodovsky.com | fridrich@binghamton.edu | November 2011
%          http://dde.binghamton.edu/download/feature_extractors
% -------------------------------------------------------------------------
% Extracts CC-C300 features [1] from the given IMAGE. The output is stored
% in a structured variable 'f'. Total dimensionality of the features: 24300
% (uncalibrated). Cartesian calibration [2] doubles the dimensionality to
% the total 48600.
% -------------------------------------------------------------------------
% Input:  IMAGE .. path to the JPEG image
%         QF ..... JPEG quality factor of the reference image (we
%                   recommend to keep it the same as the original image QF)
% Output: F ...... extracted CC-C300 features
% -------------------------------------------------------------------------
% IMPORTANT: For accessing DCT coefficients of JPEG images, we use Phil
% Sallee's Matlab JPEG toolbox (function jpeg_read) available at
% http://philsallee.com/jpegtbx/
% -------------------------------------------------------------------------
% [1] Steganalysis in high dimensions: fusing classifiers built on random
% subspaces, J. Kodovsky and J. Fridrich, Proc. SPIE, Electronic Imaging,
% Media, Watermarking, Security and Forensics XIII, San Francisco, CA,
% January 23-26, 2011.
% -------------------------------------------------------------------------


% Original C300 features (no calibration) - 24300
X = DCTPlane(IMAGE);
R = [2 1 2 9;1 2 9 2;3 1 3 9;4 1 3 1;1 3 9 3;2 1 2 17;1 4 1 3;5 1 4 1;1 3 1 2;2 3 1 3;3 1 2 1;1 2 17 2;3 2 3 1;3 2 2 2;1 2 1 10;2 3 2 2;2 2 1 2;2 2 3 1;1 3 2 2;2 1 10 1;2 2 2 10;2 2 2 1;2 3 3 2;5 1 3 1;2 2 10 2;4 1 4 9;4 2 4 1;4 2 3 2;3 3 2 3;2 4 1 4;1 5 1 4;3 3 3 2;1 2 9 10;2 1 10 9;2 4 2 3;3 2 4 1;1 4 9 4;1 4 2 3;3 2 3 10;1 2 2 1;4 1 3 9;3 3 2 2;3 1 4 9;4 1 2 1;3 1 3 17;4 2 3 1;2 3 10 3;1 4 1 2;2 1 3 9;2 2 2 9;2 1 2 10;2 2 9 2;3 1 2 9;3 2 3 9;3 1 3 10;1 3 9 2;3 3 1 3;1 2 10 2;1 2 9 3;3 1 11 1;1 3 1 11;2 4 1 3;1 3 17 3;3 3 4 2;1 3 9 4;3 3 3 1;2 3 9 3;4 2 5 1;5 2 4 2;2 1 10 17;1 4 9 3;1 5 1 3;1 3 10 3;4 2 2 2;1 2 17 10;2 4 3 3;4 3 3 3;2 2 3 10;3 2 2 10;2 3 1 2;2 2 10 10;2 4 2 2;6 1 5 1;3 2 2 1;5 2 5 1;2 2 4 1;2 2 10 3;2 3 10 2;4 3 3 2;1 2 1 18;2 2 3 9;5 2 4 1;3 1 2 10;4 3 4 2;3 1 11 9;2 3 2 10;3 2 10 2;3 4 3 3;2 2 9 3;3 2 1 2;5 1 5 9;2 2 2 11;1 3 10 2;2 3 2 11;1 3 9 11;2 2 11 2;4 1 5 9;5 1 4 9;3 2 11 2;1 4 2 2;3 2 5 1;4 2 4 10;1 3 3 2;5 2 3 2;4 3 4 1;4 3 2 3;2 1 18 1;4 1 4 17;1 2 1 11;1 3 1 10;3 4 2 3;1 2 9 18;1 2 2 10;3 4 2 4;2 2 1 10;4 1 3 17;5 1 3 9;3 3 3 10;2 5 2 4;3 4 1 4;4 1 4 10;2 3 4 2;1 5 2 4;3 2 3 11;4 2 4 9;2 3 3 1;3 1 10 1;6 1 4 1;3 2 4 10;3 1 5 9;3 3 10 3;3 1 4 17;2 3 11 3;2 3 2 1;2 2 2 18;4 2 3 10;1 4 3 3;2 1 18 9;4 1 11 1;2 1 11 1;3 1 12 1;3 2 4 9;4 1 3 10;3 3 4 1;2 2 1 11;1 3 2 10;2 2 10 1;2 3 3 10;3 4 3 2;2 1 3 17;3 2 2 11;2 2 18 2;2 3 1 11;1 3 2 11;3 1 2 17;2 1 10 2;2 4 3 2;2 3 11 2;3 3 3 11;4 1 2 9;1 3 17 2;2 1 4 9;4 1 12 1;3 1 11 17;3 2 10 3;2 3 9 4;2 4 10 4;1 4 1 11;2 2 11 1;1 4 17 4;1 2 17 3;1 3 1 12;1 2 17 18;3 1 10 2;5 2 3 1;3 1 11 2;3 3 11 3;3 2 11 1;3 2 11 10;2 5 1 4;1 4 10 3;2 3 10 4;4 2 3 9;2 3 10 11;3 1 4 10;2 3 3 11;3 3 2 11;2 4 10 3;2 4 9 4;1 3 17 11;1 4 10 4;2 1 18 17;2 2 11 10;1 3 17 4;3 2 10 10;1 4 17 3;2 2 10 18;1 3 9 10;1 4 9 2;1 2 9 11;3 3 11 2;2 3 10 10;2 2 10 11;1 2 9 4;3 2 11 3;2 5 2 3;2 1 1 10;3 1 10 9;1 2 2 9;2 2 18 10;3 3 2 10;2 5 1 5;1 4 1 12;2 2 3 11;3 2 3 18;1 5 2 3;2 3 4 1;2 1 11 9;1 5 9 4;4 1 11 9;3 3 10 2;1 4 9 5;1 4 3 2;2 2 9 10;1 2 10 1;1 3 10 10;3 1 12 9;2 2 11 3;1 2 10 10;4 3 5 2;2 2 9 11;2 1 9 2;4 3 3 1;2 2 11 9;2 3 18 3;3 2 3 17;2 3 9 11;1 3 10 4;3 1 3 18;1 3 1 19;3 1 10 10;4 1 12 9;1 3 10 11;2 4 9 3;4 1 2 10;4 3 2 2;4 2 11 2;2 2 4 9;3 2 11 9;2 2 3 18;3 1 11 10;3 2 2 18;2 2 10 9;3 2 12 2;2 2 3 17;3 1 19 1;2 3 11 10;2 1 10 10;6 1 3 1;4 1 5 17;3 4 4 3;3 1 2 18;1 2 10 9;4 2 3 11;3 2 10 11;3 4 1 3;1 3 3 1;3 3 4 10;2 1 9 10;2 3 17 3;1 5 9 5;1 3 18 3;3 3 5 2;1 4 9 11;5 1 4 10;1 3 9 12;4 2 2 10;2 2 4 10;5 1 4 17;4 2 5 9;3 3 9 3;1 3 18 2;3 3 10 11;4 3 5 1;2 2 17 3;2 2 18 18;2 3 2 12;2 3 9 2;2 3 11 11;2 3 18 2]; % TOP 300 DCT mode pairs
F = zeros(81,300,'single');
for i=1:300,eval(sprintf('F(:,%i) = extract_CF(X,[%i %i],[%i %i],4);',i,R(i,1:4))); end
f.ccc300 = F(:);

% Reference C300 features - another 24300
X = DCTPlane_reference(IMAGE,QF);
F = zeros(81,300,'single');
for i=1:300,eval(sprintf('F(:,%i) = extract_CF(X,[%i %i],[%i %i],4);',i,R(i,1:4))); end
f.ccc300_ref = F(:);

% union of both as a final 48600-dim CC-C300 feature vector
F = [f.ccc300;f.ccc300_ref];

function f = normalize(f)
S = sum(f(:));
if S~=0, f=f/S; end

function F = extract_CF(X,M1,M2,T)
% -------------------------------------------------------------------------
% Extractor of cooccurence features in DCT domain.
% IMAGE: jpg image
% M1,M2 : modes
% T : truncation parameter
% -------------------------------------------------------------------------
F = reshape(single(normalize(extractCooccurencesFromColumns(ExtractCoocColumns(X,[M1;M2]),T))),[],1);
% -------------------------------------------------------------------------
function F = extractCooccurencesFromColumns(blocks,t)
% blocks = columns of values from which we want to extract the
% cooccurences. marginalize to [-t..t]. no normalization involved

blocks(blocks<-t) = -t; % marginalization
blocks(blocks>t) = t;   % marginalization

% pre-allocate output cooccurence features
F = zeros(2*t+1,2*t+1);
for i=-t:t
    fB = blocks(blocks(:,1)==i,2);
    if ~isempty(fB)
        for j=-t:t
            F(i+t+1,j+t+1) = sum(fB==j);
        end
    end
end
function columns = ExtractCoocColumns(A,target)
% Take the target DCT modes and extracts their corresponding n-tuples from
% the DCT plane A. Store them as individual columns.
mask = getMask(target);
v = floor(size(A,1)/8)+1-(size(mask,1)/8); % number of vertical block shifts
h = floor(size(A,2)/8)+1-(size(mask,2)/8); % number of horizontal block shifts

for i=1:size(target,1)
    C = A(target(i,1)+(1:8:8*v)-1,target(i,2)+(1:8:8*h)-1);
    if ~exist('columns','var'),columns = zeros(numel(C),size(target,1)); end
    columns(:,i) = C(:);
end
function mask = getMask(target)
% transform list of DCT modes of interest into a mask with all zeros and
% ones at the positions of those DCT modes of interest
x=8;y=8;
if sum(target(:,1)>8)>0 && sum(target(:,1)>16)==0, x=16; end
if sum(target(:,1)>16)>0 && sum(target(:,1)>24)==0, x=24; end
if sum(target(:,1)>24)>0 && sum(target(:,1)>32)==0, x=32; end
if sum(target(:,2)>8)>0 && sum(target(:,2)>16)==0, y=16; end
if sum(target(:,2)>16)>0 && sum(target(:,2)>24)==0, y=24; end
if sum(target(:,2)>24)>0 && sum(target(:,2)>32)==0, y=32; end

mask = zeros(x,y);
for i=1:size(target,1)
    mask(target(i,1),target(i,2)) = 1;
end

function Plane=DCTPlane(path)
%loads DCT Plane of the given JPEG image

jobj=jpeg_read(path);
Plane=jobj.coef_arrays{1};
function Plane=DCTPlane_reference(path,QF)
% obtain reference image DCT plane (see [3])
I = imread(path);      % decompress into spatial domain
I = I(5:end-4,5:end-4); % crop by 4x4 pixels
TMP = ['img_' num2str(round(rand()*1e7)) num2str(round(rand()*1e7)) '.jpg']; % temporary reference image
while exist(TMP,'file'), TMP = ['img_' num2str(round(rand()*1e7)) num2str(round(rand()*1e7)) '.jpg']; end
imwrite(I,TMP,'Quality',QF); % save as temporary jpeg image using imwrite
Plane = DCTPlane(TMP); % load DCT plane of the reference image
delete(TMP); % delete the temporary reference image
