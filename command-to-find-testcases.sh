matrixJson='{"subcommand": [], "include": []}'

# Add plain vanilla test cases based seeded by executable files in the cwd
for testcase in $(find . -maxdepth 1 -perm -111 -type f)
do
  matrixJson=$(jq --arg testcase ${testcase} '.subcommand += [$testcase]' <<< "${matrixJson}");
done

# Add special case testcase
matrixJson=$(jq --argjson testcase '{"subcommand": "md5", "optionalArgs": "@s"}' '.include += [$testcase]' <<< "${matrixJson}");

# Echo out the JSON as output of the script
echo "${matrixJson}"

# Example format:
#'{"subcommand": ["df", "gs", "cp"], "include": [{"subcommand": "md5", "optionalArgs": "@s"}]}'
