fileIn = open("/p200/zengchq_group/guanxn/mzp/4C/cut_and_split_180316/tmp", 'r')
fileOut = open("/p200/zengchq_group/guanxn/mzp/4C/cut_and_split_180316/T2D_v1_F_36bp_chr1-22_fullName.sam", 'w')

lines = ""
b = True
sep = "\t"


while b:
	lines = fileIn.readline()
	if lines == "":
		b = False
	else:
		myList = lines.split("\t")
		myList[2] = 'chr' + myList[2]
		myLine = sep.join(myList)
		fileOut.write(myLine)
