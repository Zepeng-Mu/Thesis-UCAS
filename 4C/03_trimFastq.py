myLen = 36

inFile = open('/p200/zengchq_group/guanxn/mzp/4C/cut_and_adapt_180316/T2D_v1_F_Q20_1.fastq', 'r')
outFile = open('/p200/zengchq_group/guanxn/mzp/4C/cut_and_adapt_180316/T2D_v1_F_Q20_1_36bp.fastq', 'w')

b = True
lines = ''

while b:
	lines = inFile.readline()

	if lines == '':
		b = False

	else if lines.startswith('>'):
		header = lines
		optional = inFile.readline()
		seq = inFile.readline()
		qual = inFile.readline()

		if len(seq) > myLen:
			trimmedSeq = seq[0:myLen]
			trimmedQual = qual[0:myLen]
			outList = [header, optional, trimmedSeq, trimmedQual]
			outFile.writeline(outList)

inFile.close()
outFile.close()
