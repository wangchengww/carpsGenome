#!/python3
import sys
import pandas as pd

data = pd.read_table(sys.argv[1])

col = data.columns

wf = open(sys.argv[2],'w')
for i in col[2:]:
	print(">"+ i,"".join(j for j in list(data[i])),sep = "\n",end = "\n",file = wf)

wf.close()

