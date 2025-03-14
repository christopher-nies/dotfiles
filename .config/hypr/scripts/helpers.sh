
get_windows_info() {
  # Get the output from hyprctrl and filter the relevant details
  hyprctl clients -j | jq -r '.[] | "\(.workspace) \(.class) \(.title)"' | while read -r workspace class title; do
    echo "Workspace: $workspace | Class: $class | Title: $title"
  done
}
