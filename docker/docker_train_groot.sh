#!/bin/bash

# replace with your dataset repo e.g. username/pi05_test_dataset
DATASET_REPO=cbrian/merge_task1_DM_epi_200
# replace with your output directory e.g. outputs/pi05_test_training
# NOTE: Keep "/workspace/outputs/" prefix, only change the folder name after it
OUTPUT_DIR=/workspace/apptainer_outputs/test_groot_sif
# replace with your job name e.g. pi05_test_job
JOB_NAME=test_groot_sif
# replace with your policy repo e.g. username/pi05_test_trained_policy
POLICY_REPO=cbrian/test_groot_sif

STEPS=10

lerobot-train \
    --dataset.repo_id="$DATASET_REPO" \
    --policy.type=groot \
    --output_dir="$OUTPUT_DIR" \
    --job_name="$JOB_NAME" \
    --policy.repo_id="$POLICY_REPO" \
    --wandb.enable=false \
    --wandb.disable_artifact=false \
    --policy.tune_diffusion_model=false \
    --steps=$STEPS \
    --policy.device=cuda:0 \
    --batch_size=2 \
    --save_checkpoint true \
    --save_freq 10 \
    --log_freq=10 \

# Use pixi run -e jazzy-pi05 python -m lerobot.scripts.lerobot_train --help to see all available options and their descriptions.