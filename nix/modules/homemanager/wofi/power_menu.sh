menu=$(cat <<EOF
<span font_size="large">󰍁</span>  <span font_size="large">Lock</span>
<span font_size="large">󰍃</span>  <span font_size="large">Logout</span>
<span font_size="large"></span>  <span font_size="large">Restart</span>
<span font_size="large">󰤄</span>  <span font_size="large">Sleep</span>
<span font_size="large">󰐥</span>  <span font_size="large">Shutdown</span>
EOF
)

selection=$(echo "$menu" | wofi --dmenu --prompt="Choose an action:" --lines=10 -Ddmenu-print_line_num=true)
