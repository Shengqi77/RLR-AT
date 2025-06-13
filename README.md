<div align="center">

# 【ECCV'2024🔥】 Long-range Turbulence Mitigation: A Large-scale Dataset and A Coarse-to-fine Framework
</div>


## [🔥 Project Page](https://shengqi77.github.io/RLR-AT.github.io/) | [Paper](https://arxiv.org/pdf/2407.08377) | [Dataset](https://drive.google.com/file/d/14z0CvHcEVhkxWu5U7nq64xmB8Apqnx54/view?usp=drive_link)
<img width="864" alt="image" src="https://github.com/Shengqi77/RLR-AT/blob/main/image/2024ECCV.gif">
<img width="864" alt="image" src="https://github.com/Shengqi77/RLR-AT/blob/main/image/results.png">
<img width="864" alt="image" src="https://github.com/Shengqi77/RLR-AT/blob/main/image/Ref.png">

## 🛠️ CDSP Code Instruction
### 1. Geometric Distortion Correction
Run the Demo_Distortion_Correction.m file for correcting the geometric distortion.
### 2. Blur Removal
We use [Uformer](https://github.com/ZhendongWang6/Uformer) for deblurring. The detailed methodology for constructing **blurred-sharp training data pairs** is provided in the **Section 3** of [supplementary materials](https://www.ecva.net/papers/eccv_2024/papers_ECCV/papers/05881-supp.pdf)  
```
git clone https://github.com/ZhendongWang6/Uformer.git
cd Uformer
pip install -r requirements.txt
```
**Pre-trained deblurring mode**l：  
https://drive.google.com/drive/folders/1uPiXSeczKwMY0_xYJ9A5fLnW2w4-HUpy?usp=drive_link

## 🧩 RLR-AT Dataset Download

**Small-version** (45 typical real turbulence videos. It's enough to use them to test your method.)  
https://drive.google.com/file/d/14z0CvHcEVhkxWu5U7nq64xmB8Apqnx54/view?usp=drive_link

**Large-version**   
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
