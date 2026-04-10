#!/bin/bash
#SBATCH --job-name=astarnet_visualize
#SBATCH --partition=gpu_h100
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=48
#SBATCH --time=01:00:00
#SBATCH --output=astarnet_visualize_%j.log

source ~/Seminar/NBFNet/nbfnet_env/bin/activate

export PYTHONUNBUFFERED=1

cd ~/Seminar/AStarNet

mkdir -p ~/experiments/astarnet_visualize

python script/visualize.py  -c config/inductive/wn18rr_astarnet_visualize.yaml --checkpoint {{ checkpoint }} --gpus {{ gpus }}

deactivate
