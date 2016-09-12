#!/usr/bin/python

from rigol import RigolScope
import csv

scope = RigolScope("/dev/usbtmc0")
print scope.getName()

for i in range(1, 599):
    scope.setupAndTrigger()
    (T, A) = scope.getWave('CHAN1')
    print '%d samples' % len(A)
    scope.write(":KEY:FORC")
    
    with open('/mnt/hgfs/scope/duty-cycle/duty-cycle' + str(i) + '.csv', 'w') as f:
        writer = csv.writer(f)
        writer.writerow(['Second', 'Volt'])
        for i in range(len(A)):
            writer.writerow([T[i], A[i]])
