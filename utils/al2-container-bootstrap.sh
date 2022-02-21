#!/bin/bash

yum update -y
yum install java-11-amazon-corretto -y
yum install unzip jq -y

creds=$(aws sts assume-role --role-arn arn:aws:iam::462418267981:role/iag-idam-sharedservices-ssvc-root-satellite-components --role-session-name "gateway-bootstrap")

echo $creds | jq .
# remove if running locally
unset AWS_PROFILE

AWS_ACCESS_KEY_ID=$(echo $creds | jq -r '.Credentials.AccessKeyId')
AWS_SECRET_ACCESS_KEY=$(echo $creds | jq -r '.Credentials.SecretAccessKey')
AWS_SESSION_TOKEN=$(echo $creds | jq -r '.Credentials.SessionToken')

aws s3 cp s3://iag-idam-sharedservices-ssvc-root-satellite-components/identityiq-CloudGateway-8.1-modified.zip identityiq-CloudGateway-8.1-modified.zip
unzip identityiq-CloudGateway-8.1-modified.zip 1> /dev/null
mv apache-tomcat-9.0.24/ /usr/share/

# mv tomcat.service /etc/systemd/system/tomcat.service

chmod +x /usr/share/apache-tomcat-9.0.24/bin/*.sh
chmod +x /usr/share/apache-tomcat-9.0.24/webapps/CloudGateway/WEB-INF/bin/*.sh
ln -s /usr/share/apache-tomcat-9.0.24/ /usr/share/tomcat
KEYSTORE_PASSWORD=$(aws secretsmanager get-secret-value --secret-id arn:aws:secretsmanager:eu-west-1:462418267981:secret:satellite-components | jq --raw-output '.SecretString' | jq -r .IG_CG_KEYSTORE_PASS)
CIB_PASSWORD=$(aws secretsmanager get-secret-value --secret-id arn:aws:secretsmanager:eu-west-1:462418267981:secret:satellite-components | jq --raw-output '.SecretString' | jq -r .IG_CG_CIBADMIN_PASS)
cd /usr/share/tomcat/keystore/ 
keytool -noprompt -keystore cloudgateway \
# -storetype jceks \
-storetype pkcs12 \
-genseckey \
-alias 2 \
-keysize 128 \
-keyAlg AES \
-storepass $KEYSTORE_PASSWORD \
-keypass $KEYSTORE_PASSWORD \
-dname "CN=Unkown, OU=Unkown, O=Unkown, L=Unkown, S=Unknown, C=GB"
cd ../webapps/CloudGateway/WEB-INF/bin/
KEYSTORE_PASSWORD_ENCRYPTED=$(./cib.sh encrypt $KEYSTORE_PASSWORD)
sed -i "s|#KEYSTORE_FILE|keyStore.file=/usr/share/tomcat/keystore/cloudgateway|g" ../classes/iiq.properties
sed -i "s|#KEYSTORE_PASSWORD|keyStore.password=${KEYSTORE_PASSWORD_ENCRYPTED}|g" ../classes/iiq.properties
CIB_PASSWORD_ENCRYPTED=$(./cib.sh encrypt $CIB_PASSWORD 2)
sed -i "s|1:ACP:GFHA9PcXj/42eNXh8SnQvg2buP1RZRdp1xhAV4fhAeM=|${CIB_PASSWORD_ENCRYPTED}|g" ../classes/iiq.properties
ln -s /usr/share/apache-tomcat-9.0.24/ /usr/share/tomcat
groupadd --system tomcat
useradd -d /usr/share/tomcat -r -s /bin/false -g tomcat tomcat
chown -R tomcat:tomcat /usr/share/tomcat
chown -R tomcat:tomcat /usr/share/apache-tomcat-9.0.24/
systemctl daemon-reload
systemctl start tomcat
systemctl enable tomcat
