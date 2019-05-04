if [[ -z "$JOHNNYDECIMAL_BASE" ]];
then
    echo "No Johnny.Decimal basedir given";
    echo "Using ~/johnny";

    mkdir ~/johnny;
    export JOHNNYDECIMAL_BASE=~/johnny;
fi;

_johnny_fetchpath()
{
    unset retval;
    local targetpath=("${JOHNNYDECIMAL_BASE}/${_j_area} "*"/${_j_category} "*"/${_j_category}.${_j_unique} "*);
    retval=$(realpath ${targetpath});
}

_johnny_splitdecimal()
{
    _j_category=${1:0:2}
    _j_unique=${1:3:2}
    
    _j_area_lower=$(expr "(" ${_j_category} / 10 ")" "*" 10) 
    _j_area_upper=$(($_j_area_lower + 9));
    _j_area="${_j_area_lower}-${_j_area_upper}";
}

jcd()
{
    if [[ ! $# -eq 1 ]];
    then
	echo "Usage:";
	echo "$ jcd CATEGORY.UNIQUE"
	return;
    fi;
    _johnny_splitdecimal "$1";
    _johnny_fetchpath;
    pushd "${retval}";
}

jcp()
{
    if [[ $# -lt 2 ]];
    then
	echo "Usage:";
	echo "$ jcp CATEGORY.UNIQUE SRC"
	return;
    fi;
    _johnny_splitdecimal "$1";
    _johnny_fetchpath;
    cp --no-clobber --verbose --recursive "${@:2}" "$retval";
}

jmv()
{
    if [[ $# -lt 2 ]];
    then
	echo "Usage:";
	echo "$ jcp CATEGORY.UNIQUE SRC"
	return;
    fi;
    _johnny_splitdecimal "$1";
    _johnny_fetchpath;
    mv --no-clobber --verbose "${@:2}" "$retval";
}


jmkarea()
{
    if [[ ! $# -eq 2 ]];
    then
	echo "Usage:";
	echo "$ jmkarea CATEGORY DESC";
	return;
    fi;

    _johnny_splitdecimal "${1}.00";
    mkdir --verbose "${JOHNNYDECIMAL_BASE}/${_j_area} ${2}"
}


jmkcat()
{
    if [[ ! $# -eq 2 ]];
    then
	echo "Usage:";
	echo "$ jmkcat CATEGORY DESC";
	return;
    fi;

    _johnny_splitdecimal "$1";
    local targetpath=("${JOHNNYDECIMAL_BASE}/${_j_area} "*);
    mkdir --verbose "$targetpath/${_j_category} ${2}";
}

jmkuni()
{
    if [[ ! $# -eq 2 ]];
    then
	echo "Usage:";
	echo "$ jmkuni CATEGORY.UNIQUE DESC";
	return;
    fi;

    _johnny_splitdecimal "$1";
    local targetpath=("${JOHNNYDECIMAL_BASE}/${_j_area} "*"/${_j_category} "*);
    mkdir --verbose "$targetpath/${_j_category}.${_j_unique} ${2}"
}
