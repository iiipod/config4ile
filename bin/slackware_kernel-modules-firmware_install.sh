#!/bin/bash
###
### Install slackware kernel to your distro...
###
#####################################

#mirrors="http://mirror.bjtu.edu.cn"
#mirrors="http://mirrors.ustc.edu.cn"
mirrors="mirrors.163.com"

#####################################

release="slackware-14.1"
#ver="slackware64-14.1"

#####################################

#arch="slackware"
arch="slackware64"

#####################################

kernel="3.10.17"

#####################################

#
#http://mirrors.163.com/slackware/slackware64-14.1/slackware64/a/kernel-generic-3.10.17-x86_64-3.txz
#

wget "${mirrors}"/slackware/"${release}"/"{arch}"/a/kernel-huge-smp-"${version}"_smp-i686-3.txz
#tar Jxvf kernel-huge-smp-"${version}"_smp-i686-3.txz -C / boot/  

wget "${mirrors}"/slackware/"${release}"/"{arch}"/a/kernel-modules-smp-"${version}"_smp-i686-3.txz
#tar Jxvf kernel-modules-smp-"${version}"_smp-i686-3.txz -C / lib/	

#####################################

#wget "${mirrors}"/slackware/"${arch}"/slackware/a/kernel-firmware-20131008git-noarch-1.txz
#tar Jxvf kernel-firmware-20131008git-noarch-1.txz -C / lib/



