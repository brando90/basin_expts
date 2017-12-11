#!/bin/bash
alias matlab='/Applications/MATLAB_R2017a.app/bin/matlab -nodesktop -nosplash'

hello=hellohello
echo $hello
matlab -nodesktop -nosplash -nojvm -r "test_sh"