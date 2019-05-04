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
    local targetpath=(${JOHNNYDECIMAL_BASE}/${1}\ */${1}.${2}\ *);
    retval=$(realpath ${targetpath});
}

_johnny_nextindex()
{
    unset retval;
    if [ -f "${1}/.index" ];
    then
       local index=$(cat "${1}/.index");
       local newindex=$(printf '%04u' $((1 + $index)));

       fileCheck=$(find "${1}" -maxdepth 1 -name "$newindex *")
       if [ -z "${fileCheck}" ];
       then
	   retval=$newindex;
	   echo -n $retval > "${1}/.index"	   
	   return 0;
       fi;
       echo "File with index ${newindex} already exists";
       echo "Detecting new index";
    fi;
    
    # We need to detect the new index
    local maxindex=1;
    for i in ${1}/*;
    do
	i=$(basename $i);
	if [[ ${i:0:4} -ge maxindex ]];
	then
	    maxindex=${i:0:4};
	fi;
    done;
    retval=$(printf '%04u' $((1 + $maxindex)));
    echo -n $retval > "${1}/.index"
}


jcd()
{
    if [[ ! $# -eq 2 ]];
    then
	echo "Usage:";
	echo "$ jcd AREA CATEGORY"
	return;
    fi;
    _johnny_fetchpath "${1}" "${2}";    
    pushd "${retval}";
}

jcp()
{
    if [[ $# -lt 3 ]];
    then
	echo "Usage:";
	echo "$ jcp AREA CATEGORY SRC"
	return;
    fi;
    _johnny_fetchpath "${1}" "${2}";
    local targetpath=$retval;

    for s in ${@:3};
    do	
	_johnny_nextindex $targetpath;
	target="${targetpath}/${retval} $(basename ${s})";
	cp --no-clobber --verbose --recursive "$s" "$target";
    done;
}

jmv()
{
    if [[ $# -lt 3 ]];
    then
	echo "Usage:";
	echo "$ jcp AREA CATEGORY SRC"
	return;
    fi;
    _johnny_fetchpath "${1}" "${2}";
    local targetpath=$retval;

    for s in ${@:3};
    do	
	_johnny_nextindex $targetpath;
	target="${targetpath}/${retval} $(basename ${s})";
	mv --no-clobber --verbose "$s" "$target";
    done;
}

jmkdir()
{
    if [[ $# -eq 2 ]];
    then
	mkdir --verbose "${JOHNNYDECIMAL_BASE}/${1} ${2}";
	return $?;
    fi;

    if [[ $# -eq 3 ]];
    then
	
	local areapath=$(realpath ${JOHNNYDECIMAL_BASE}/${1}\ *);
	mkdir --verbose "${areapath}/${2} ${3}";
	return $?;
    fi;

    echo "Usage: ";
    echo "$ jmkdir AREA DESCRIPTION"
    echo "$ jmkdir AREA CATEGORY DESCRIPTION"
    return 1;
}

