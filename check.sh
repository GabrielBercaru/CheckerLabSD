#!/bin/bash

echo ""
echo "=============== CHECKING LAB $LabSD ==============="
echo ""

task="task"
bonus="bonus"

points1=(1.0 2.0 3.0 4.0 5.0 3.0 3.0)
points2=(1.0 2.0 3.0 1.0 3.0 5.0)
points3=(1.0 1.0)
points4=(1.0 2.5)
points5=(2.0 3.0 4.0)
points6=(1.0 1.0 1.0)
points7=(1.0 2.0 3.0 4.0 5.0)
points8=(1.0 1.0 1.0 1.0)
points9=(3.0 3.0 3.0 1.0)
points10=(1.0 2.0 3.0 4.0)
points11=(4.0 5.0 1.0)

ref_path=Ref/Lab$LabSD
out_path=Out/Lab$LabSD

ref_ext=".ref"
out_ext=".out"

if [ "$1" == "" ]; then
    # No parameter given, check all tasks
    it=0
    grade="0.0"
    max_grade="0.0"
    labPoints="points$LabSD"

    for ref_file in $((ls $ref_path/$task* && ls $ref_path/$bonus*) | xargs -n1 basename); do
        test=$(echo $ref_file | cut -d'.' -f1)
        out_file="$test$out_ext"

        current_task_score=points$LabSD[$it]
        max_grade=$(bc <<< $(echo "$max_grade + ${!current_task_score}"))

        ls $out_path/$out_file &> /dev/null
        if [ $? -gt 0 ]; then
            echo "Could not find $out_file .................... FAILED 0.0/${!current_task_score}"
        else
            if [ "$(diff $ref_path/$ref_file $out_path/$out_file)" != "" ]; then
                echo "$test .................... FAILED 0.0/${!current_task_score}"
            else
                grade=$(bc <<< $(echo "$grade + ${!current_task_score}"))
                echo "$test .................... PASSED ${!current_task_score}/${!current_task_score}"
            fi
        fi

        it=$((it+1))
       
    done

    echo ""
    echo "---------------------------------------------"
    echo "Final grade: $grade/$max_grade"
else
    grade="0.0"
    max_grade="0.0"
    valid=1
    # Check given task
    if [ "$1" == "T" ]; then
        if [ $2 -gt $(ls $ref_path/$task* | wc -l) -o $2 -le 0 ]; then
            echo "No such $task $2"
            valid=0
        else
            index=$(($2-1))
            current_task_score=points$LabSD[$index]
            max_grade=${!current_task_score}

            if [ "$(diff $ref_path/"$task$2.ref" $out_path/"$task$2.out")" != "" ]; then
                echo "$task$2 .................... FAILED"
            else
                grade=$max_grade
                echo "$task$2 .................... PASSED"
            fi
        fi
    elif [ "$1" == "B" ]; then
        if [ $2 -gt $(ls $ref_path/$bonus* | wc -l) -o $2 -le 0 ]; then
            echo "No such $bonus $2"
            valid=0
        else
            offset=$(ls $ref_path/$task* | wc -l)
            index=$(($2+$offset-1))
            current_task_score=points$LabSD[$index]
            max_grade=${!current_task_score}

            if [ "$(diff $ref_path/"$bonus$2.ref" $out_path/"$bonus$2.out")" != "" ]; then
                echo "$bonus$2 .................... FAILED"
            else
                grade=$max_grade
                echo "$bonus$2 .................... PASSED"
            fi
        fi
    fi

    if [ $valid -eq 1 ]; then
        echo ""
        echo "---------------------------------------------"
        echo "Final grade: $grade/$max_grade"
    fi

    echo ""
    echo "=============================================="
fi

echo ""
