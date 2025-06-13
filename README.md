<div align="center">

# [2024 ECCV🔥] Long-range Turbulence Mitigation: <br> A Large-scale Dataset and A Coarse-to-fine Framework
</div>


## [[Project Page]](https://shengqi77.github.io/RLR-AT.github.io/) | [[Paper]](https://arxiv.org/pdf/2407.08377) | [[Appendix]](https://www.ecva.net/papers/eccv_2024/papers_ECCV/papers/05881-supp.pdf) | [[Dataset]](https://drive.google.com/file/d/14z0CvHcEVhkxWu5U7nq64xmB8Apqnx54/view?usp=drive_link)
<img width="864" alt="image" src="https://github.com/Shengqi77/RLR-AT/blob/main/image/2024ECCV.gif">
<img width="864" alt="image" src="https://github.com/Shengqi77/RLR-AT/blob/main/image/Ref.png">

## 🛠️ Code Instruction
### Step 1. Geometric Distortion Correction
Run the Demo_Distortion_Correction.m file for correcting the geometric distortion.
### Step 2. Blur Removal
We use [Uformer](https://github.com/ZhendongWang6/Uformer) for deblurring. 

**Uformer Setup**
```
git clone https://github.com/ZhendongWang6/Uformer.git
cd Uformer
pip install -r requirements.txt
```
**Training Data**  
The details for constructing **Deblurring Training Data** are provided in the **Section 3.3** of [appendix](https://www.ecva.net/papers/eccv_2024/papers_ECCV/papers/05881-supp.pdf)  
**Training Code**   
```
#Please modify the paths for training data.
sh script/train_motiondeblur.sh
```
**Test Code**
```
#Please modify the paths for images and model weights.
python /test/test_realblur.py
```
**Pre-trained deblurring weights:**  
https://drive.google.com/drive/folders/1uPiXSeczKwMY0_xYJ9A5fLnW2w4-HUpy?usp=drive_link

## 🧩 Dataset Download

**Small-version** (Including 45 typical real turbulence videos. It's enough to use them for evaluation.)  
https://drive.google.com/file/d/14z0CvHcEVhkxWu5U7nq64xmB8Apqnx54/view?usp=drive_link

**Large-version** (Including both **dynamic** and static scene turbulence videos. Feel free to use them for your research)
https://drive.google.com/drive/folders/1cJpsyx_sYwGnBRdTaBWjPgIbh9d76-2w?usp=drive_link

## 👍 Useful Resource
If you’re also working on turbulence mitigation, I strongly recommend that you look into the following resources. They could be of significant help to your research！

[Purdue Intelligent Imaging Lab (i2Lab)](https://engineering.purdue.edu/ChanGroup/project_turbulence.html) 

i2Lab focuses on computational imaging and has produced many excellent works related to imaging through turbulence, including turbulence mitigation and simulation.


## 📘 Citation
If you find our work helpful for your own research or work, please cite our paper.
```
@article{xu2024long,
  title={Long-range Turbulence Mitigation: A Large-scale Dataset and A Coarse-to-fine Framework},
  author={Xu, Shengqi and Sun, Run and Chang, Yi and Cao, Shuning and Xiao, Xueyao and Yan, Luxin},
  journal={arXiv preprint arXiv:2407.08377},
  year={2024}
}
```
