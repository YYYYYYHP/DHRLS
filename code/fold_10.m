clear;
load('gene_disease_dataset.mat');
y = gene_disease_Y;
gamma = 0.5;
beta = 1;
lamda_1 = 1;
lamda_2 = 0.25;
knn = 50;
iter_max = 10;

fold_aupr_dhrls_ka=[];fold_auc_dhrls_ka=[];
nfolds =10;
crossval_idx = crossvalind('Kfold',y(:),nfolds);
for fold = 1:nfolds
	y_train = gene_disease_Y;
	test_idx  = find(crossval_idx==fold);
	y_train(test_idx) = 0;
	K1_list(:,:,2) = getGipKernel(y_train,gamma);
	K2_list(:,:,4) = getGipKernel(y_train',gamma);
 
	[weight_v1] = cka_kernels_weights(K1_list,y_train,1);
	K_COM1 = combine_kernels(weight_v1, K1_list);		

	[weight_v2] = cka_kernels_weights(K2_list,y_train,2);
	K_COM2 = combine_kernels(weight_v2, K2_list);
	
	[A_cos_com]  = DHRLS(K_COM1,K_COM2,y_train,beta,lamda_1,lamda_2,knn,iter_max);
	
	yy=y;
    test_labels = yy(test_idx);
    predict_scores = A_cos_com(test_idx);
    [X,Y,tpr,aupr] = perfcurve(test_labels,predict_scores,1, 'xCrit', 'reca', 'yCrit', 'prec');
    [X,Y,THRE,auc,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(test_labels,predict_scores,1);


    fprintf('---------------- FOLD %d  \n',  fold)
    fprintf('--- FOLD %d - DHRLS---AUPR: %f ---AUC: %f \n', fold, aupr, auc)

    fold_aupr_dhrls_ka=[fold_aupr_dhrls_ka;aupr];
    fold_auc_dhrls_ka=[fold_auc_dhrls_ka;auc];

end
mean_aupr_dhrls_ka = mean(fold_aupr_dhrls_ka)
mean_auc_dhrls_ka = mean(fold_auc_dhrls_ka)
