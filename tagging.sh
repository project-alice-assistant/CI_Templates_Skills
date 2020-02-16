version=$(jq -r .version *.install)
aliceMinVersion=$(jq -r .aliceMinVersion *.install)
git_refs_url="https://api.github.com/repos/project-alice-assistant/$CI_PROJECT_NAME/git/refs"
new_tag="$version_$aliceMinVersion"
echo "Trying to push new tag $new_tag"
curl -s -X POST $git_refs_url \
-H "Authorization: token $GITHUB_TOKEN" \
-d @- << EOF
{
  "ref": "refs/tags/$new_tag",
  "sha": "$CI_COMMIT_SHA"
}
EOF
