#!/usr/bin/env sh

ScrDir=`dirname $(realpath $0)`
source $ScrDir/globalcontrol.sh
roconf="~/.config/rofi/config.rasi"

# Define el modo que quieres usar, por ejemplo, "window"
r_mode="window"

# Lee los valores de hypr_border y ajusta los bordes y radios de bordes de la ventana y elementos de rofi.
wind_border=$(( hypr_border * 3 ))
elem_border=`[ $hypr_border -eq 0 ] && echo "10" || echo $(( hypr_border * 2 ))`
r_override="window {border: ${hypr_width}px; border-radius: ${wind_border}px;} element {border-radius: ${elem_border}px;}"

# Lee la configuración de tamaño de fuente de Gnome y la aplica a la configuración de rofi.
fnt_override=`gsettings get org.gnome.desktop.interface font-name | awk '{gsub(/'\''/,""); print $NF}'`
fnt_override="configuration {font: \"JetBrainsMono Nerd Font ${fnt_override}\";}"

# Lee la configuración de tema de iconos de Gnome y la aplica a la configuración de rofi.
icon_override=`gsettings get org.gnome.desktop.interface icon-theme | sed "s/'//g"`
icon_override="configuration {icon-theme: \"${icon_override}\";}"

# Lanza rofi con los modos y configuraciones definidos anteriormente.
rofi -show $r_mode -theme-str "${fnt_override}" -theme-str "${r_override}" -theme-str "${icon_override}" -config "${roconf}"
