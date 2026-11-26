#!/bin/bash

# ==========================================
# 1. Slurm Resource Requests (from your srun)
# ==========================================
#SBATCH --job-name=pi05_training
#SBATCH --partition=gpu
#SBATCH --gres=gpu:rtx4090:1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=72:00:00               # Adjust this time limit as needed (HH:MM:SS)
#SBATCH --output=/home_net/go52zag/Desktop/crisp_gym_ITR/logs/job_%j.out       # Saves terminal output to a logs folder
#SBATCH --error=/home_net/go52zag/Desktop/crisp_gym_ITR/logs/job_%j.err        # Saves errors to a logs folder

# Ensure the script starts in the directory where you ran sbatch
cd "$SLURM_SUBMIT_DIR"

# ==========================================
# 2. Environment & Container Execution
# ==========================================

# We change 'shell' to 'exec', and append the python command at the very end
apptainer exec --nv --cleanenv \
  --home "$PWD/.cache/home":/home/user_lerobot \
  --bind "$PWD":/workspace \
  --pwd /workspace \
  --env HF_HOME=/workspace/.cache/huggingface \
  --env HF_LEROBOT_HOME=/workspace/.cache/huggingface/lerobot \
  --env TORCH_HOME=/workspace/.cache/torch \
  --env TRITON_CACHE_DIR=/workspace/.cache/triton \
  --env WANDB_DIR=/workspace/.cache/wandb \
  --env WANDB_API_KEY="${WANDB_API_KEY}" \
  docker/pi05.sif \
  ./docker/docker_train_pi05.sh