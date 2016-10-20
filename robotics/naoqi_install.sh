#################################################################################
# Coding conventions
#
# - Prefer portability, but don't sacrifice security and whitespace awareness
#   to it.
#
# - Prefer builtins over external commands.
#
# - But, use fast external commands to process very large inputs.
#
# - Avoid unnecessary subshells and pipelines.
#
# - Don't preoptimize.
#
# - Learn the rules of quoting. Then, use quotes.
#
# - Use functions to improve readability and control scope.
# 
# - Don't give scripts silly file extensions.
#
# - Never change directory without checking that it worked.
#
# - Eschew hobgoblins
#
#
# "A foolish consistency is the hobgoblin of little minds, adored by little
#  statesmen and philosophers and divines."
#
#  – Ralph Waldo Emerson
#
#
################################################################################

# download pynaoqi-python2.7-2.1.2.17-linux64.tar to your download folder
mkdir ~/naoqi
cp ~/Downloads/pynaoqi* ~/Downloads/naoqi* ~/naoqi
cd ~/naoqi

tar xzf naoqi*
tar xzf pynaoqi*

export PYTHONPATH=~/naoqi/pynaoqi-python2.7-2.1.4.13-linux64:$PYTHONPATH
echo 'export PYTHONPATH=~/naoqi/pynaoqi-python2.7-2.1.4.13-linux64:$PYTHONPATH' >> ~/.bashrc
