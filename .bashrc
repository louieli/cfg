
###############################################################################
#                                   别名
###############################################################################

alias e=dancepill
alias h='history' 
alias pdb='python -m pdb'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'



###############################################################################
#                                   实用函数
###############################################################################
# Quick extract script for Bash
# from https://github.com/lzap/dancepill
dancepill() {
  for F in "$@"; do
    if [ -f "$F" ] ; then
      FT1=$(file -bi "$F" | grep -Eo '[[:alnum:]_-]+/[[:alnum:]_-]+')
      DIR=$(mktemp -d -p . -t "$F-XXXXXXXX")
      pushd "$DIR"
      case $FT1 in
        "application/x-bzip2") tar xvjf "../$F" || bunzip2 "../$F" ;;
        "application/x-gzip") tar xvzf "../$F" || gunzip "../$F" ;;
        "application/x-xz") tar xvJf "../$F" ;;
        "application/x-rar") unrar x "../$F" || rar x "../$F" ;;
        "application/x-arj") arj x "../$F" || 7za x "../$F" ;;
        "application/x-lha") lha x "../$F" || 7za x "../$F" ;;
        "application/x-cpio") cpio -i "../$F" ;;
        "application/x-tar") tar xvf "../$F" || gunzip "../$F" ;;
        "application/x-zip") unzip "../$F" ;;
        "application/x-rpm") rpm2cpio "../$F" | cpio -idmv ;;
        "application/zip") unzip "../$F" ;;
        "application/x-7z-compressed") 7za x "../$F" ;;
        "application/x-7za-compressed") 7za x "../$F" ;;
        "application/octet-stream") unlzma "../$F" || 7za x "../$F" || uncompress "../$F" ;;
        *) echo "'../$F' ($FT1) cannot be extracted via e() bash function" ;;
      esac
      popd
      # expecting only one file/directory to be extracted (prevent mess)
      if [ "$(ls "$DIR" | wc -l)" == "1" ]; then
        mv -v "$DIR"/* . && rmdir "$DIR"
      fi
    else
      echo "'$F' is not a valid file"
    fi
  done
}

#  Displays Structure of Directory Hierarchy
tree() {
    echo
    if [ "$1" != "" ]  #if parameter exists, use as base folder
       then cd "$1"
    fi
    pwd
    \ls -R | grep ":$" |   \
       sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
    # 1st sed: remove colons
    # 2nd sed: replace higher level folder names with dashes
    # 3rd sed: indent graph three spaces
    # 4th sed: replace first dash with a vertical bar
    if [ `\ls -F -1 | grep "/" | wc -l` = 0 ]   # check if no folders
       then echo "   -> no sub-directories"
    fi
    echo
}

#使用less彩色输出man手册页
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;37m") \
        LESS_TERMCAP_md=$(printf "\e[1;37m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;47;30m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[0;36m") \
            man "$@"
}




