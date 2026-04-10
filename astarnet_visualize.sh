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

CHECKPOINT_DIR=$(ls -td ~/experiments/InductiveKnowledgeGraphCompletion/WN18RRInductive/AStarNet/* 2>/dev/null | head -n 1)
CHECKPOINT_PATH="$CHECKPOINT_DIR/model_epoch_20.pth"

if [ -z "$CHECKPOINT_DIR" ] || [ ! -f "$CHECKPOINT_PATH" ]; then
  echo "Kein passender AStarNet-Checkpoint gefunden: $CHECKPOINT_PATH"
  exit 1
fi

python script/visualize.py -c config/inductive/wn18rr_astarnet_visualize.yaml --checkpoint "$CHECKPOINT_PATH" --gpus [0]

deactivate
