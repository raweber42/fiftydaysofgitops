gbc() {
  git add .
  git checkout -b "$1"
  git commit -m "$(echo "$1" | sed 's/-/: /1' | tr '-' ' ')"
}
