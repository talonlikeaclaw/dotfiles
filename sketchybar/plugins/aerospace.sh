#!/usr/bin/env bash

workspace=$(aerospace list-workspaces --focused)

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  # This is called for all workspaces when a change occurs
  if [ "$NAME" = "space.$workspace" ]; then
    sketchybar --set $NAME background.drawing=on icon.color=0xffffffff
  else
    sketchybar --set $NAME background.drawing=off icon.color=0x99ffffff
  fi
else
  # This is called individually for each workspace item
  if [ "$NAME" = "space.$workspace" ]; then
    sketchybar --set $NAME background.drawing=on icon.color=0xffffffff
  else
    sketchybar --set $NAME background.drawing=off icon.color=0x99ffffff
  fi
fi
