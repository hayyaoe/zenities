printf "%.0f\n" $(df --output=pcent / | tail -n1 | tr -dc '0-9')

