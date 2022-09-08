
#echo "$1"
#while read line
#do
#       echo "$line"
#done < "$1




keys=$(cat $1 | jq 'keys[]')

arrVar=()

dumurl="https://groups.wotif.com/Login/"
dumsp="_____________________________"*
openbracket="["
closebracket="]"
#empty file
fileName="readyUrls.txt"
emptyFile= $(truncate -s 0 $fileName)
echo "$emptyFile"
for i in ${keys[@]}
do
        url=$(echo "$i" | sed 's/[[:space:]]//g')
        dummy_url=$( echo "$i" | tr -d '"')
        body=$(cat $1 |jq -r ".\"$dummy_url\"")
        params=$(echo $body | jq '.params')
        for array_of_params in "${params[@]}"
        do
                #echo ${array_of_params}
                for j in ${array_of_params}
                do
                        if [[ $j != $openbracket && $j != $closebracket ]]; then
                            readyParams=$( echo "$j" | tr -d '" ,')
                            readyUrl="${dummy_url}?${readyParams}=FUZZ"
                            #echo "$readyUrl"
                            arrVar[${#arrVar[@]}]="$readyUrl"
                        fi
                done
        done

done
#### printing and writing crafted urls 

# Iterate the loop to read and print each array element
for value in "${arrVar[@]}"
do
     writeToFile=$(echo $value >> $fileName)
done
