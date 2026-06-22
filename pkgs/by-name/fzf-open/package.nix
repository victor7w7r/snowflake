{ pkgs }:
pkgs.writeShellApplication {
  name = "fzf-open";
  runtimeInputs = with pkgs; [
    fzf
    fd
  ];
  text = ''
    query=''${1:-""}
    match=$(fd --color=always | fzf --query="$query" --no-multi --ansi)
    echo "Selected: $match"

    mimetype=$(file --mime-type -b "$match")
    echo "MIME type: $mimetype"

    if [ -z "$match" ]; then
     	exit 0
    elif [ -d "$match" ]; then
     	echo "Opening $match in $SHELL"
     	cd "$match" && exec $SHELL
    elif echo "$mimetype" | grep -q 'text/'; then
     	echo "Opening $match in $EDITOR"
     	$EDITOR "$match"
    elif [ -f "$match" ]; then
     	echo "Opening $match with default program"
     	open "$match"
    else
     	stat "$match"
    fi
  '';
}
