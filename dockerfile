# CUDA 11.3 on x86
FROM nvcr.io/nvidia/pytorch:21.05-py3
ARG DEBIAN_FRONTEND=noninteractive
ENV FORCE_CUDA 1

WORKDIR /repos

# install dependecies
RUN apt-get update && apt-get install -y libusb-1.0-0 ffmpeg libsm6 libxext6 

RUN pip install --upgrade pip
RUN pip install torch==1.10.1+cu113 torchvision==0.11.2+cu113 torchaudio==0.10.1 -f https://download.pytorch.org/whl/torch_stable.html

COPY requirements_new.txt /repos/requirements.txt
RUN pip install -r /repos/requirements.txt
RUN pip install torch-scatter==2.0.9 torch-sparse==0.6.12 torch-cluster==1.5.9 -f https://data.pyg.org/whl/torch-1.10.1+cu113.html
RUN pip install torch-points-kernels

RUN git clone https://github.com/lmitechnologies/torch-points3d.git
RUN pip install opencv-python==4.5.5.64

WORKDIR /repos/torch-points3d
