# jq_preview_with_groups.jq

# Capture the root object
. as $root
| $root.windows | to_entries[]
| .key as $win_index
| .value as $win_val
| (
    # Per-window: extract group name and color maps
    ($win_val.groups // [] | map({ (.id): .name }) | add) as $group_names |
    ($win_val.groups // [] | map({ (.id): .color }) | add) as $group_colors |

    #"\n\n🪟 Window \($win_index + 1) (\($win_val.tabs | length) tabs):" +
    "\n\n__WIN\($win_index)____BOLD__🪟 Window \($win_index + 1) (\($win_val.tabs | length) tabs):__RESET__" +

    (
      reduce ($win_val.tabs | to_entries[]) as $tab_ent (
        { prev: "", out: "" };
        . as $state |

        # Handle group ID → name/color safely
        ($tab_ent.value.groupId // "ungrouped") as $gid |
        ($group_names[$gid] // "Ungrouped") as $grp_name |
        ($group_colors[$gid] // "none") as $grp_color |

        $state.out + 
          (
            if $grp_name != $state.prev then
              "\n\n📁 Group: \($grp_name) (\($grp_color))"
            else "" end
          ) +

          "\n    " +
          (if ($tab_ent.value.selected // null) != null and $tab_ent.key == ($tab_ent.value.selected - 1)
           then "✅" else "  " end) +
          " [" + ($tab_ent.key|tostring) + "] " +
          (
            if $tab_ent.value.entries[-1].title == $tab_ent.value.entries[-1].url
            then "same as URL"
            else "__WIN\($win_index)__" + ($tab_ent.value.entries[-1].title // "No Title") + "__RESET__"
            end
          ) + "\n" +
          "         " + ($tab_ent.value.entries[-1].url // "") |

        # Update previous group name
        { prev: $grp_name, out: . }
      )
    ).out
)
