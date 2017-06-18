export LD_LIBRARY_PATH=../PSPNet/build/lib:$LD_LIBRARY_PATH
matlab -nodisplay -r "eval_all;exit" 2>&1 | tee matlab.log
