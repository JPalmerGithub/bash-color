#!/bin/bash

# -----------------------------
# doc type
# -----------------------------

# bold	        Start bold text
# smul	        Start underlined text
# rmul	        End underlined text
# rev	        Start reverse video
# blink	        Start blinking text
# invis	        Start invisible text
# smso	        Start "standout" mode
# rmso	        End "standout" mode
# sgr0	        Turn off all attributes
# setaf <value>	Set foreground color
# setab <value>	Set background color

HELP="
usage: source color_constant.sh
-------------------------------
test: ./color_constant.sh test
-------------------------------
create by Kamontat Chantrachirathumrong
since 11/12/60-16:09 (dd/mm/yy-mm:ss)
version 1.1
"

unset C_COMPLETE

if [[ $1 == "help" || $1 == "h" ]]; then
    echo "$HELP"
    exit 0
fi

if command -v tput >/dev/null; then
    ncolors=$(tput colors)
else
    echo "not support tput, use color_raw_constant.sh instead."
    exit 2
fi

# print color bit layout

# echo "$(tput longname)"
# echo "you command line have $ncolors colors"
# echo "  mean your both C_FG_XXX and C_BG_XXX"
# echo "      XXX = 1 - $ncolors"

DEFAULT="C_"
FORGROUND="FG_"
BACKGROUND="BG_"

# temp variable
temp=

# extra word
export C_BO="$(tput bold)"
export C_DI="$(tput dim)"
export C_UL="$(tput smul)"
export C_RV="$(tput rev)"
export C_SM="$(tput smso)"
export C_BL="$(tput blink)"
export C_IV="$(tput invis)"

# reset variable
export C_RE_AL="$(tput sgr0)"
export C_RE_SM="$(tput rmso)"
export C_RE_UL="$(tput rmul)"

# example
# programmer=Ines
# declare $programmer="nice gal"
# echo $Ines # echos nice gal

# declare forground color
for (( i=0; i<=ncolors; i++ )); do
    temp="$DEFAULT$FORGROUND$i"
    # echo "$temp"
    export $temp="$(tput setaf $i)"
done

# declare background color
for (( i=0; i<=ncolors; i++ )); do
    temp="$DEFAULT$BACKGROUND$i"
    export $temp="$(tput setab $i)"
done

# useful function
# print with XXXX color
debug() {
    if [ $ncolors -ge 251 ]; then
        echo "${C_FG_251}$1${C_RE_AL}"
    elif [ $ncolors -ge 102 ]; then
        echo "${C_FG_102}$1${C_RE_AL}"
    elif [ $ncolors -ge 14 ]; then
        echo "${C_FG_14}$1${C_RE_AL}"
    elif [ $ncolors -ge 7 ]; then
        echo "${C_FG_7}$1${C_RE_AL}"
    else 
        echo "$1"
    fi
}

error() {
    if [ $ncolors -ge 196 ]; then
        echo "${C_FG_196}$1${C_RE_AL}"
    elif [ $ncolors -ge 1 ]; then
        echo "${C_FG_1}$1${C_RE_AL}"
    else 
        echo "$1"
    fi
}

info() {
    if [ $ncolors -ge 118 ]; then
        echo "${C_FG_118}$1${C_RE_AL}"
    elif [ $ncolors -ge 46 ]; then
        echo "${C_FG_46}$1${C_RE_AL}"
    elif [ $ncolors -ge 2 ]; then
        echo "${C_FG_2}$1${C_RE_AL}"
    else 
        echo "$1"
    fi
}

warning() {
    if [ $ncolors -ge 220 ]; then
        echo "${C_FG_220}$1${C_RE_AL}"
    elif [ $ncolors -ge 130 ]; then
        echo "${C_FG_130}$1${C_RE_AL}"
    elif [ $ncolors -ge 9 ]; then
        echo "${C_FG_9}$1${C_RE_AL}"
    else 
        echo "$1"
    fi
}

alert() {
    if [ $ncolors -ge 200 ]; then
        echo "${C_FG_200}$1${C_RE_AL}"
    elif [ $ncolors -ge 125 ]; then
        echo "${C_FG_125}$1${C_RE_AL}"
    elif [ $ncolors -ge 5 ]; then
        echo "${C_FG_5}$1${C_RE_AL}"
    else 
        echo "$1"
    fi
}

# export function
export -f debug
export -f error
export -f info
export -f warning
export -f alert

# tester
if [[ $1 == "test" ]]; then
    echo "${C_FG_3}front color 3 ${C_RE_AL}"
    echo "${C_FG_1}front color 1 ${C_RE_AL}"
    echo "${C_FG_7}front color 7 ${C_RE_AL}"
    echo "${C_FG_2}front color 2 ${C_RE_AL}"
    echo "${C_BG_4}back  color 4 ${C_RE_AL}"
    echo "${C_BG_5}back  color 5 ${C_RE_AL}"
    echo "${C_BO}${C_FG_5}BOLD+F5 ${C_RE_AL}"
    echo "${C_BO}${C_FG_7}${C_BG_3}Bold+F7+B3${C_RE_AL}"
    echo "${C_BL}${C_UL}${C_FG_1}Blink+Underline+F1${C_RE_UL} disable underline${C_RE_AL}"
fi

# completely setting color
# you can use this variable to say is setting complete or not
export C_COMPLETE=$ncolors 
