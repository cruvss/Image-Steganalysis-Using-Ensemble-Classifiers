path_train_cover = fullfile('grayCover_v8.mat');
%path_train_stego = fullfile('grayStego_v8.mat');
path_existing_model = fullfile('D:', 'desktop', 'Minor project', 'FINAL MODEL','re_trained.mat');
path_clf_out=fullfile('D:', 'desktop', 'new matlab','grayModel.mat');
path_train_stego=fullfile('grayCover_v8.mat');

test=fullfile('D:', 'desktop', 'new matlab','V1_ccchen','cover_.mat');
path_votes_out=fullfile('D:', 'desktop', 'new matlab','V1_ccchen','v22.txt');

%ensemble_fit(path_train_cover, path_train_stego, path_clf_out)
ensemble_predict(path_clf_out, path_train_stego, path_votes_out)
%retrain_ensemble(path_train_cover, path_train_stego, path_existing_model,path_clf_out);
%retrain_ensemble(path_existing_model, path_train_cover, path_train_stego, path_clf_out);
