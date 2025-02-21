printf "%.0f\n" $(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')

