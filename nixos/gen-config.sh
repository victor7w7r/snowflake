#!/usr/bin/env bash
set -eu

MCONFIG="macminiconfig"
ROGCONFIG="rogallyconfig"
SRVCONFIG="serverconfig"
SUNXICONFIG="sunxiconfig"
QCOMCONFIG="qcomconfig"
ACTUALARCH=""
ARCH=$(uname -m)

case "$ARCH" in
    x86_64|amd64)
        ACTUALARCH="x86_64-linux";;
    aarch64|arm64)
        ACTUALARCH="aarch64-linux";;
esac

runbuild() {
    local PC=$1
    nix build -L ".#packages.${ACTUALARCH}.${PC}" --no-link --print-out-paths
}

x86_gen() {
    if res=$(run-build $SRVCONFIG); then
        cat "$res" >"kernel/generated/${SRVCONFIG}.x86_64-linux.nix"
    else
        exit 1
    fi

    if res=$(run-build $MCONFIG); then
        cat "$res" >"kernel/generated/${MCONFIG}.x86_64-linux.nix"
    else
        exit 1
    fi

    if res=$(run-build $ROGCONFIG); then
        cat "$res" >"kernel/generated/${ROGCONFIG}.x86_64-linux.nix"
    else
        exit 1
    fi
}

q_gen() {
    if res=$(runbuild $QCOMCONFIG); then
        cat "$res" >"kernel/sdm845/config.aarch64-linux.nix"
        nix build -L ".#packages.${ACTUALARCH}.qcomconfigflat" --no-link --print-out-paths
    else
        exit 1
    fi
}

arm_gen() {
    if res=$(runbuild $SUNXICONFIG); then
        cat "$res" >"kernel/sunxi/config.aarch64-linux.nix"
    else
        exit 1
    fi
    q_gen
}

while getopts ":aqxe" opt; do
    case "${opt}" in
        a)
            arm_gen;;
        q)
            q_gen;;
        x)
            x86_gen;;
        \?)
            x86_gen
            arm_gen;
    esac
done
