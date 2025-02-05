#!/bin/bash

CONFIG_DIR="$HOME/.config/sketchybar"
. "$CONFIG_DIR/globals.sh"

sb_separator() {
	sepName="sep$RANDOM"
	sketchybar \
		--add item "$sepName" "$1" \
		--set "$sepName" \
		\
		label="───────" \
		padding_left="$2" \
		padding_right="$3" \
		icon.drawing=off \
		label.font.size=9.0 \
		label.color="$OX_DIM"
}

sb_clock() {
	sketchybar \
		--add item clock "$1" \
		--set clock \
		\
		update_freq=10 \
		label.font.size=14.0 \
		icon= \
		icon.drawing=off \
		script="$PLUGIN_DIR/clock.sh"
}

sb_pomodoro() {
	sketchybar \
		--add item pomodoro "$1" \
		--set pomodoro \
		\
		icon="" \
		update_freq=1 \
		label.font.size=14.0 \
		label.color="$OX_ORG" \
		updates=on \
		drawing=off \
		icon.drawing=off \
		label.drawing=off \
		click_script="$PLUGIN_DIR/pomodoro.sh" \
		script="$PLUGIN_DIR/pomodoro.sh" \
		--subscribe pomodoro mouse.clicked pomodoro_start
}

sb_date() {
	sketchybar \
		--add item day "$1" \
		--set day \
			update_freq=120 \
			icon.drawing=off \
			padding_right=4 \
			script="$PLUGIN_DIR/date.sh" \
		\
		--add item date_month "$1" \
		--set date_month \
			update_freq=120 \
			icon.drawing=off \
			padding_right=4 \
			script="$PLUGIN_DIR/date.sh" 
}

sb_spaces() {
	for sid in "${!SPACE_ICONS[@]}"; do

		sketchybar \
			--add item space.$sid "$1" \
			--subscribe space.$sid aerospace_workspace_change \
			--set space.$sid \
			\
			icon="${SPACE_ICONS[$sid]}" \
		  icon.font="sketchybar-app-font:Regular:18.0" \
			label="·" \
			label.drawing=off \
			click_script="aerospace workspace $((sid + 1))" \
			script="$PLUGIN_DIR/aerospace.sh $sid"

		if [[ $sid == 4 ]]; then sb_separator left 14 14; fi
	done
}

sb_frontapp() {
	sketchybar \
		--add item front_app "$1" \
		--subscribe front_app front_app_switched \
		--set front_app "${FRONT_APP[@]}" \
		\
		icon.font="sketchybar-app-font:Regular:18.0" \
		icon.color=0xffe9897c \
		script="$PLUGIN_DIR/front_app.sh"
}

sb_wifi() {
	sketchybar \
		--add item wifi "$1" \
		--subscribe wifi wifi_change \
		--set wifi \
		\
		script="$PLUGIN_DIR/wifi.sh" \
		icon=􀙇 \
		label.color=$OX_DIM
}

sb_battery() {
	sketchybar \
		--add item battery "$1" \
		--subscribe battery system_woke power_source_change \
		--set battery \
		\
		script="$PLUGIN_DIR/battery.sh" \
		update_freq=120 \
		label.color=$OX_DIM
}

sb_volume() {
	sketchybar \
		--add item volume "$1" \
		--subscribe volume volume_change \
		--set volume \
		\
		script="$PLUGIN_DIR/volume.sh" \
		label.color=$OX_DIM
}

sb_cpu() {
	sketchybar \
		--add item cpu "$1" \
		--set cpu \
		\
		script="$PLUGIN_DIR/cpu.sh" \
		icon=􀫥 \
		icon.color=$OX_DIM \
		label.color=$OX_DIM \
		update_freq=2
}
