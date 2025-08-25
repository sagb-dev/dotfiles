#!/bin/bash

# Function to get dconf dump
get_dconf_dump() {
    dconf dump / > /tmp/dconf_dump_$1.txt
}

# Get initial state
echo "Taking initial dconf snapshot..."
get_dconf_dump "before"

echo "Make your changes now. Press Enter when done..."
read

# Get state after changes
echo "Taking final dconf snapshot..."
get_dconf_dump "after"

# Show differences
echo "Showing differences:"
diff /tmp/dconf_dump_before.txt /tmp/dconf_dump_after.txt

# Cleanup
rm /tmp/dconf_dump_before.txt /tmp/dconf_dump_after.txt
