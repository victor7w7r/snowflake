#!/usr/bin/env bash
set -eu

MCONFIG="macminiconfig"
ROGCONFIG="rogallyconfig"
SRVCONFIG="serverconfig"
SUNXICONFIG="sunxiconfig"
QCOMCONFIG="qcomconfig"
QCOMFLAT="qcomconfigflat"
GENDIR="kernel/generated"
ACTUAL=""
ARCH=$(uname -m)

case "$ARCH" in
    x86_64|amd64) ACTUAL="x86_64-linux";;
    aarch64|arm64) ACTUAL="aarch64-linux";;
esac

runbuild() {
    local PC=$1
    nix build -L ".#packages.${ACTUAL}.${PC}" --no-link --print-out-paths
}

x86_gen() {
    if res=$(runbuild $SRVCONFIG); then cat "$res" >"${GENDIR}/${SRVCONFIG}.x86_64-linux.nix"; else exit 1; fi
    if res=$(runbuild $MCONFIG); then cat "$res" >"${GENDIR}/${MCONFIG}.x86_64-linux.nix"; else exit 1; fi
    if res=$(runbuild $ROGCONFIG); then cat "$res" >"${GENDIR}/${ROGCONFIG}.x86_64-linux.nix"; else exit 1; fi
}

q_gen() {
    if res=$(runbuild $QCOMCONFIG); then
        cat "$res" >"kernel/sdm845/config.aarch64-linux.nix"
        cp $(runbuild $QCOMFLAT) "kernel/sdm845/sdm845.config"
    else exit 1; fi
}

arm_gen() {
    if res=$(runbuild $SUNXICONFIG); then cat "$res" >"kernel/sunxi/config.aarch64-linux.nix"; else exit 1; fi
    q_gen
}

while getopts ":aqxe" opt; do
    case "${opt}" in
        a) arm_gen;;
        q) q_gen;;
        x) x86_gen;;
        \?)
            x86_gen
            arm_gen;;
    esac
done
