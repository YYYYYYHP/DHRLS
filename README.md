Dual Hypergraph Regularized Least Squares (DHRLS)
=================
DHRLS is one novel computational method, which utilizes Multiple kernels learning and Hypergraph Regularized Least Squares to predict the association between diseases and genes.
![Image text](http://yhpjc.vip/download/DHRLS/dhrls_flow.jpg)
1.Code.
>1)cka_kernels_weights.p: function implementing CKA algorithm;

>2)construct_Hypergraphs_knn_weight.p: function implementing Hypergraph Laplacian matrix;

>3)DHRLS.p: predict the association between diseases and genes

>4)fold_10.m:function implementing ten fold cross validation



2.Dataset.

>1)disease_name and gene_name: store disease name and gene name, respectively;

>2)gene_disease_Y.mat:store the matrix of association between diseases and genes

>Due to file upload restrictions, click [DATA](http://yhpjc.vip/download/DHRLS/gene_disease_dataset.mat) to get all data

3.Predicting_novel_interactions.

>This folder contains the DHRLS model's Top50 prediction results for 960 diseases, including the gene name prediction score and whether it has been verified
