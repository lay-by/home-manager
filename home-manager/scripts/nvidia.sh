#! /usr/bin/env nix-shell
# shellcheck shell=bash
#! nix-shell -i bash -p nvidia-smi

get_gpu() {
    TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)
    GPU=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
}
get_gpu

threshold=76

if ((TEMP > threshold)); then
    echo "$GPU %{F#FE3120}$TEMP°C"
else
    echo "$GPU% $TEMP°C"
fi
