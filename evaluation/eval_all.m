close all; clc; clear;
addpath('../PSPNet/matlab'); %add matcaffe path
addpath('visualizationCode');
data_name = 'cityscapes';

switch data_name
    case 'cityscapes'
        isVal = true; %false for testset
        step = 500; %1525 for testset
        data_root = '/mnt/sda1/hszhao/dataset/cityscapes'; %data folder
        eval_list = 'list/fine_val.txt'; %fine_test for testset
        save_root = 'mc_result/cityscapes/val/icnet_train_30k/'; %test/icnet_trainval_90k/ for testset
        model_weights = 'model/icnet_cityscapes_train_30k.caffemodel'; %trainval_90k for testset
        model_deploy = 'prototxt/icnet_cityscapes.prototxt';
        fea_cha = 19;
        crop_size_h = 1025;
        crop_size_w = 2049;
        data_class = 'objectName19.mat';
        data_colormap = 'colormapcs.mat';
end
skipsize = 0; %skip serveal images in the list

is_save_feat = false; %set to true if final feature map is needed (not suggested for storage consuming)
save_gray_folder = [save_root 'gray/']; %path for predicted gray image
save_color_folder = [save_root 'color/']; %path for predicted color image
save_feat_folder = [save_root 'feat/']; %path for predicted feature map
mean_r = 123.68; %means to be subtracted and the given values are used in our training stage
mean_g = 116.779;
mean_b = 103.939;

acc = double.empty;
iou = double.empty;
gpu_id = 0;

eval_sub(data_name,data_root,eval_list,model_weights,model_deploy,fea_cha,crop_size_h,crop_size_w,data_class,data_colormap, ...
           is_save_feat,save_gray_folder,save_color_folder,save_feat_folder,gpu_id,step,skipsize,mean_r,mean_g,mean_b);
if(isVal)
   eval_acc(data_name,data_root,eval_list,save_gray_folder,data_class,fea_cha);
end
