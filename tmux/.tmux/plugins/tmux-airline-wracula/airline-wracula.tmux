#!/usr/bin/env bash

main() {

  ## Colors
  black='colour16'
  white='colour231'
  gray='colour236'
  red='colour1'
  orange='colour209'
  green='colour10'

  ## Icons
  left_sep=''
  right_sep=''
  right_alt_sep=''

  tmux set-option -g status on
  tmux set-option -g status-left-length 100
  tmux set-option -g status-right-length 100
  tmux set-option -g status-bg "${orange}"
  tmux set-option -g pane-active-border-fg "${green}"
  tmux set-option -g pane-border-fg "${gray}"
  tmux set-option -g message-bg "${gray}"
  tmux set-option -g message-fg "${black}"
  tmux set-option -g message-command-bg "${gray}"
  tmux set-option -g message-command-fg "${black}"
  tmux set-option -g status-left " #I  "
  tmux set-option -g status-left-style "fg=${white},bg=${orange},bold"
  tmux set-option -g status-right "${left_sep}#[bg=${black},reverse]  #H @ %Y-%m-%d "
  tmux set-option -g status-right-style "fg=${red},bg=${orange}"
  tmux set-window-option -g window-status-activity-style "fg=${black},bg=${gray}"
  tmux set-window-option -g window-status-separator ''
  tmux set-window-option -g window-status-format ' #I #W '
  tmux set-window-option -g window-status-style "fg=${white},bg=${orange}"
  tmux set-window-option -g window-status-current-format \
    "${right_sep}#[fg=${black}] #I ${right_alt_sep} #W #[fg=${orange},reverse]${right_sep}"
  tmux set-window-option -g window-status-current-style "fg=${orange},bg=${red}"
}

main

# vim: set filetype=bash
