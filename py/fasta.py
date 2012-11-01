from collections import OrderedDict

def read_fasta(obj):
    strands = OrderedDict()

    lines = (l.strip() for l in obj.readlines())
    name = lines.next()[1:].strip()
    strand = ''
    for line in lines:
        if line.startswith('>'):
            strands[name] = strand
            name = line[1:].strip()
            strand = ''
        else:
            strand += line.strip()
    else:
        strands[name] = strand
    return strands
            
