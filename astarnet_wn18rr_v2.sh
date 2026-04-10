#!/bin/bash
#SBATCH --job-name=astarnet_wn18rr
#SBATCH --partition=gpu_h100
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=24
#SBATCH --time=04:00:00
#SBATCH --output=astarnet_wn18rr_%j.log

source ~/Seminar/NBFNet/nbfnet_env/bin/activate

export PYTHONUNBUFFERED=1
export OMP_NUM_THREADS=24

cd ~/Seminar/AStarNet

mkdir -p ~/experiments/astarnet_wn18rr_v2

python script/run.py -c config/inductive/wn18rr_astarnet.yaml --gpus [0] --version v1

deactivate
