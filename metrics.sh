#!/bin/bash
function display_metrics {
Mem=$( free | grep Mem | awk '{printf ("%.2f",$3/$2*100)}' )
echo "Mem usage:$Mem" 
}
display_metrics 
