# Indent GEDCOM files for better human readability.
#
# NOTE!
#    Do NOT save GEDCOM files with indentation.
#    The GEDCOM specification states gedcom writers (software)
#    "must not indent lines based on their level."
#
# Usage:
#   gedindent GEDCOM


tab = " " * 4
ARGF.each_line { |line|
   indent, rest = line.split
   puts if indent == "0"
   print tab * indent.to_i
   puts line
}
