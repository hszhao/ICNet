function eval_sub(data_name,data_root,eval_list,model_weights,model_deploy,fea_cha,crop_size_h,crop_size_w,data_class,data_colormap, ...
		  is_save_feat,save_gray_folder,save_color_folder,save_feat_folder,gpu_id,step,skipsize,mean_r,mean_g,mean_b)
list = importdata(fullfile(data_root,eval_list));
load(data_class);
load(data_colormap);
if(~isdir(save_gray_folder))
    mkdir(save_gray_folder);
end
if(~isdir(save_color_folder))
    mkdir(save_color_folder);
end
if(~isdir(save_feat_folder) && is_save_feat)
    mkdir(save_feat_folder);
end

phase = 'test';
if ~exist(model_weights, 'file')
  error('Model missing!');
end
caffe.reset_all();
caffe.set_mode_gpu();
caffe.set_device(gpu_id);
net = caffe.Net(model_deploy, model_weights, phase);

for i = skipsize+1:skipsize+step
    fprintf(1, 'processing %d (%d)...\n', i, numel(list));
    str = strsplit(list{i});
    img = imread(fullfile(data_root,str{1}));
    im_pad = imresize(img,[crop_size_h crop_size_w],'bilinear');
    im_mean = zeros(crop_size_h,crop_size_w,3,'single');
    im_mean(:,:,1) = mean_r;
    im_mean(:,:,2) = mean_g;
    im_mean(:,:,3) = mean_b;
    im_pad = single(im_pad) - im_mean;
    im_pad = im_pad(:,:,[3 2 1]);
    input_data = permute(im_pad,[2 1 3]);
    net.blobs('data').reshape([size(input_data) 1]);
    score = net.forward({input_data});
    score = score{1};
    score = permute(score, [2 1 3]);
    score = exp(score);
    score = bsxfun(@rdivide, score, sum(score, 3));
    data = imresize(score,[size(img,1) size(img,2)],'bilinear');

    img_fn = strsplit(str{1},'/');
    img_fn = img_fn{end};
    img_fn = img_fn(1:end-4);

    [~,imPred] = max(data,[],3);
    imPred = uint8(imPred);
    
    switch data_name
        case 'cityscapes'
            imPred = imPred - 1;
            imwrite(imPred,[save_gray_folder img_fn '.png']);
            imwrite(imPred,colormapcs,[save_color_folder img_fn '.png']);
    end

    if(is_save_feat)
        save([save_feat_folder img_fn],'data');
    end
end
caffe.reset_all();
end
