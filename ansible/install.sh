proxies=$(env | grep proxy | tr '\n' ' ')
echo "Proxies obtained: "$proxies
proxies=$(echo $proxies | sed 's/welcome%404567/sep%402016/g')

cd /etc/ansible

#-------------Installing Mysql--------------------------------
#Retrieve the db server's IP address
dbserverIP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' testdbserver)
echo "IP of db server is:",$dbserverIP

export ANSIBLE_HOST_KEY_CHECKING=False

ansible-playbook -i hosts -u root InstallMysql.yml --extra-vars "host=$dbserverIP $proxies"

#---------------Installing Tomcat---------------------------------
#Retrieve the web server's IP address
webserverIP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' testwebserver)
echo "IP of web server is:",$webserverIP

ansible-playbook -i hosts -u root InstallTomcat.yml  --extra-vars "host=$webserverIP $proxies"

#---------------Deploying war in Tomcat---------------------------
#Deploy war in tomcat
knife bootstrap $webserverIP -x root -P root -N WebServer -r 'recipe[deploy_war]' --node-ssl-verify-mode none --bootstrap-proxy http://sneha_kanekar:6LUCKIE%24%236@ptproxy.persistent.co.in:8080

knife client delete WebServer -y

knife node delete WebServer -y

#-------------------Installing Selenium-----------------------
#Retrieve the test_env_server's IP address
test_env_serverIP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' test_env_server)
echo "IP of test_env_server is:",$test_env_serverIP

ansible-playbook -i hosts -u root Selenium.yml  --extra-vars "host=$test_env_serverIP $proxies"

docker cp test_env_server:/root/test_result.log /etc/ansible/

