

dicta = {"DNA":277936200,"LINE":26981440,"SINE":4176254,
          "LTR":41717864,"Other":0,"Unknown":123054744}

#gene_length = 913249663 #913117163  #Ci
#gene_length = 854723385 # Hm
gene_length = 893792919  # Mp
#gene_length = 909760556 # An
#----------------------
for k,v in dicta.items():
	print("{} in genome percent is {}".format(k,round((v/gene_length)*100,2)))


print("Total length is {} and percent is {}".format(sum(dicta.values()),round((sum(dicta.values())/gene_length) * 100,2)))