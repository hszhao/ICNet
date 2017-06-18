## ICNet for Real-Time Semantic Segmentation on High-Resolution Images

by Hengshuang Zhao, Xiaojuan Qi, Xiaoyong Shen, Jianping Shi, Jiaya Jia, details are in [project page](https://hszhao.github.io/projects/icnet).

### Introduction

Based on [PSPNet](https://github.com/hszhao/PSPNet), this repository is build for evaluation in ICNet. For installation, please follow the description in PSPNet repository (support CUDA 7.0/7.5 + cuDNN v4).

### Usage

1. Clone the repository recursively:

   ```shell
   git clone --recursive https://github.com/hszhao/ICNet.git
   ```

2. Build Caffe and matcaffe:

   ```shell
   cd $ICNET_ROOT/PSPNet
   cp Makefile.config.example Makefile.config
   vim Makefile.config
   make -j8 && make matcaffe
   cd ..
   ```

3. Evaluation mIoU:

   - Evaluation code is in folder 'evaluation'.
   - Download trained models and put them in folder 'evaluation/model':
     - icnet_cityscapes_train_30k.caffemodel: [GoogleDrive](https://drive.google.com/open?id=0BzaU285cX7TCRXpXMnVIbXdfaW8) 

       (31M, md5: c7038630c4b6c869afaaadd811bdb539; train on trainset for 30k)

     - icnet_cityscapes_trainval_90k.caffemodel: [GoogleDrive](https://drive.google.com/open?id=0BzaU285cX7TCTFVpZWJINi1Iblk) 

       (31M, md5: 4f4dd9eecd465dd8de7e4cf88ba5d5d5; train on trainvalset for 90k)
   - Modify the related paths in 'eval_all.m':
     - Mainly variables 'data_root' and 'eval_list', and your image list for evaluation should be similar to that in folder 'evaluation/samplelist' if you use this evaluation code structure. 

   ```shell
   cd evaluation
   vim eval_all.m
   ```

   - Run the evaluation scripts:

   ```
   ./run.sh
   ```

4. Evaluation time:

   - To get inference time as accurate as possible, it's suggested to make sure the GPU card with specified ID in script 'test_time.sh' is empty (without other processes executing)

   - Run the evaluation scripts:

   ```
   ./test_time.sh
   ```

5. Results: 

   - Prediction results will show in folder 'evaluation/mc_result' and the expected scores are:
     - ICNet train on trainset for 30K, evaluated on valset (mIoU/pAcc): 67.7/94.5
     - ICNet train on trainvalset for 90K, evaluated on testset (mIoU): 69.5
   - Log information of inference time will be in file 'time.log', approximately 33~36ms on TitanX.

6. Demo video:

   - Video processed by ICNet on cityscapes dataset:
     - Alpha blending with value as 0.5: [Video](https://youtu.be/qWl9idsCuLQ)

## Citation

If ICNet is useful for your research, please consider citing:

    @article{zhao2017icnet,
      author = {Hengshuang Zhao and
                Xiaojuan Qi and
                Xiaoyong Shen and
                Jianping Shi and
                Jiaya Jia},
      title = {ICNet for Real-Time Semantic Segmentation on High-Resolution Images},
      journal={arXiv preprint arXiv:1704.08545},
      year = {2017}
    }
### Questions

Please contact 'hszhao@cse.cuhk.edu.hk'
