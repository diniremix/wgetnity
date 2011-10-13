#!/bin/bash
#Idea Original de Isabella Hizzlechone
#URL http://boards.420chan.org/prog/res/13467.php
#Una implementacion de Jorge Brunal a.k.a. Diniremix 

##################################################################################
#Copyright (C) 2011  Jorge Brunal (a.k.a. Diniremix)				 #
#This program is free software; you can redistribute it and/or			 #
#modify it under the terms of the GNU General Public License			 #
#as published by the Free Software Foundation; either version 2			 #
#of the License, or (at your option) any later version.				 #
#										 #
#This program is distributed in the hope that it will be useful,		 #
#but WITHOUT ANY WARRANTY; without even the implied warranty of			 #
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the			 #
#GNU General Public License for more details.					 #
#										 #
#You should have received a copy of the GNU General Public License		 #
#along with this program; if not, write to the Free Software			 #
#Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA. #
##################################################################################
VERSION="0.1";

function _init(){
	option=$(zenity --list --title "Zenity Downloader" --text "Seleccione lo que desea hacer" --radiolist --column "Opción" --column "Comando" TRUE "Ejecutar aplicación" FALSE "Mostrar ayuda"); 
  case $option in
      "Ejecutar aplicación")
	  		_download;;
      "Mostrar ayuda")
			_info;;
      " ")
			_error;;
  esac
}
 
function _download(){
VAR=0;
LINK=$(zenity --entry --title "Zenity Downloader" --text "Insertar enlace" --entry-text "url_del_archivo" --width 500)
if [ $LINK = "url_del_archivo" ]; then
	_error;
elif [ -z $LINK ]; then
	_error;
fi
wget -U $BROWSER -c $LINK 2>&1 | sed -u 's/.* \([0-9]\+%\)\ \+\([0-9.]\+.\) \(.*\)/\1\n# Descargando enlace a \2\/s, Tiempo restante: \3/' | zenity --progress --title "Zenity Downloader" --text "Descargando $LINK"
 
}
 
function _error(){
	zenity --error --title "Zenity Downloader" --text "No se ha especificado una url valida, cerrando..."
	exit
}
 
function _info(){
	zenity --info --title "Zenity Downloader" --text "Zenity Downloader V. $VERSION\nIdea Original: Isabella Hizzlechone\nhttp://boards.420chan.org/prog/res/13467.php";
}
 
_init;

