fileIn = open("/p200/zengchq_group/guanxn/mzp/4C/cut_and_split_180316/tmp", 'r')
fileOut = open("/p200/zengchq_group/guanxn/mzp/4C/cut_and_split_180316/tmp.T2D_v1_F_36bp_chr1-22.sam", 'w')

lines = ""
b = True
chrName = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22"]
sep = "\t"


while b:
	lines = fileIn.readline()
	if lines == "":
		b = False
	else:
		myList = lines.split("\t")
		if myList[2] in chrName:
			myLine = sep.join(myList)
			fileOut.write(myLine)
