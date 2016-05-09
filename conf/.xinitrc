#!/bin/bash

#export LANG=zh_CN.UTF-8
#export LC_ALL="zh_CN.UTF-8"
export GDK_USE_XFT=1
export XMODIFIERS=@im=fcitx
export GTKIMMODULE=fcitx
export QTIM_MODULE=fcitx

DEFAULTSESSION=openbox-session
#DEFAULTSESSION=awesome
#DEFAULTSESSION=enlightenment_start
case "$1" in
	 "Enlightenment")
	 	 exec enlightenment_start
		 ;;
	 "KDE")
		 exec startkde
		 ;;
	 "Fluxbox")
	         exec startfluxbox
	         ;;
	 "Openbox")
	 	 exec openbox-session
		 ;;
	 "Awesome")
	 	 exec awesome
		 ;;
	 "Blackbox")
	 	 exec blackbox
		 ;;
	 *)
	         exec $DEFAULTSESSION
	         ;;
esac
