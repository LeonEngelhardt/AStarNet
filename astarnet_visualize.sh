#!/bin/bash
#SBATCH --job-name=astarnet_visualize
#SBATCH --partition=gpu_a100_short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=24
#SBATCH --time=00:30:00
#SBATCH --output=astarnet_visualize_%j.log

source ~/Seminar/AStarNet/astarnet_env/bin/activate
module load devel/cuda/11.8
export CUDA_HOME=$(dirname $(dirname $(which nvcc)))
export PATH="$CUDA_HOME/bin:$PATH"
export LD_LIBRARY_PATH="$CUDA_HOME/lib64:$LD_LIBRARY_PATH"

export PYTHONUNBUFFERED=1
export OMP_NUM_THREADS=24

cd ~/Seminar/AStarNet

mkdir -p ~/experiments/astarnet_visualize

CHECKPOINT_DIR=$(ls -td ~/experiments/InductiveKnowledgeGraphCompletion/WN18RRInductive/AStarNet/* 2>/dev/null | head -n 1)
CHECKPOINT_PATH="$CHECKPOINT_DIR/model_epoch_18.pth"

if [ -z "$CHECKPOINT_DIR" ] || [ ! -f "$CHECKPOINT_PATH" ]; then
  echo "Kein passender AStarNet-Checkpoint gefunden: $CHECKPOINT_PATH"
  exit 1
fi

python script/visualize.py -c config/inductive/wn18rr_astarnet_visualize.yaml --checkpoint "$CHECKPOINT_PATH" --gpus [0]

deactivate