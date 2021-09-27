NAME=$('whoami')
URL="C:/Users/$NAME/AppData/Roaming/kicad/"
FP=$URL"fp-lib-table"
SYM=$URL"sym-lib-table"
cp fp-lib-table $FP
cp sym-lib-table $SYM