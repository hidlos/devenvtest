#!/usr/bin/env bash

XML_URL=localhost:8080/job/pipe/lastSuccessfulBuild/api/xml
XML_PATH='//workflowRun/action[@_class=\"hudson.plugins.git.util.BuildData\"]/lastBuiltRevision/SHA1/text()'
LAST_SUCCESSFUL_BUILD_HASH=`curl GET $XML_URL | xmllint --xpath '$XML_PATH' -`
echo $LAST_SUCCESSFUL_BUILD_HASH
