# prints the number of terminal columns
ret = `mode`
m = ret.match(/Columns:.*?(\d+)/)
cols = m[1]
print cols
