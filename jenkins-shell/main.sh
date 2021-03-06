#!/usr/bin/env bash
echo "==================================================="
if [ -z "${JENKINS_SHELL_DIR}" ]; then
    JENKINS_SHELL_DIR=/var/www/jenkins-shell  # 默认脚本位置
fi
if [ -z "${JAVA_APP_DIR}" ]; then
    JAVA_APP_DIR=/var/www/java-app      # 默认java项目位置
fi
if [ ! -d "${JAVA_APP_DIR}" ]; then
  mkdir -p "${JAVA_APP_DIR}"        # 没有java项目放置目录就生成
fi

JAR_NAME=`ls ~/.jenkins/workspace/${JOB_NAME}/target/ | grep .jar$`
echo "找到构建完成的jar包：" ${JAR_NAME}

echo "JAVA_APP_DIR: " ${JAVA_APP_DIR}
echo "JENKINS_SHELL_DIR: " ${JENKINS_SHELL_DIR}
echo "JAR_NAME: " ${JAR_NAME}
echo "BRANCH: " ${GIT_BRANCH}

export JAVA_APP_DIR
export JENKINS_SHELL_DIR
export JAR_NAME

echo "==================================================="
sh ${JENKINS_SHELL_DIR}/stop.sh
echo "==================================================="
sh ${JENKINS_SHELL_DIR}/replace.sh
echo "==================================================="
sh ${JENKINS_SHELL_DIR}/startup.sh
echo "==================================================="

