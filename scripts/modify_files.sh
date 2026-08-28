#!/bin/bash
prev_version=$1
curr_version=$2
echo "";
localdir=`pwd`;
echo "Updating main xml from $prev_version to $curr_version";
sed -i "s/$prev_version/$curr_version/g" $prev_version.xml;
mv $prev_version.xml $curr_version.xml;
echo "Renamed $prev_version.xml to $curr_version.xml";
echo "";
list='crds';
for i in $list
do
cd $i/src;
oldfile=`ls -1 *$prev_version*`;
newfile=`echo $oldfile|sed "s/$prev_version/$curr_version/"`;
cat $prev_version*.xml |sed /'include file='/d|sed 's/<changeSet id/STARTtag/g'|sed 's/<\/changeSet>/ENDtag/g'|sed 's/STARTtag="schemaCompilation"/<changeSet id="schemaCompilation"/g'|sed 's/STARTtag="revokeDDL"/<changeSet id="revokeDDL"/g'|sed '/\/sql/{n;s/.*/Jagadish/}'|sed 's/<\/changeSet>/ENDtag/g'|sed '/STARTtag/,/ENDtag/d'|sed 's/Jagadish/<\/changeSet>/g' >$newfile
echo "Updated $newfile";
cd ../..;
done
echo "";
echo "files updated"
