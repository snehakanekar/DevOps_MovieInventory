
cd /etc/ansible
sudo chmod 777 hosts

#Retrieve the db server's IP address
#dbserverIP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' testdbserver)
#echo "IP of db server is:",$dbserverIP

#echo "[testdbserver]" > hosts
#echo $dbserverIP "ansible_ssh_pass=root" >> hosts
#echo "" >> hosts

#Retrieve the test_env_server's IP address
test_env_serverIP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' test_env_server)
echo "IP of test_env_server is:",$test_env_serverIP

echo "[test_env_server]" > hosts
echo $test_env_serverIP "ansible_ssh_pass=root" >> hosts
echo "" >> hosts

#Retrieve the web server's IP address
webserverIP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' testwebserver)
echo "IP of web server is:",$webserverIP

echo "[testwebserver]" >> hosts
echo $webserverIP "ansible_ssh_pass=root" >> hosts
echo "" >> hosts

#Retrieve the web, DB and test server's IP addresses
managementIP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' management_node)
data1IP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' data_node1)
data2IP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' data_node2)
mysqlIP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' mysql_node)

echo "IP of management_node is:",$managementIP
echo "IP of data_node1 is:",$data1IP
echo "IP of data_node2 is:",$data2IP
echo "IP of mysql_node is:",$mysqlIP

echo "[management_node]" >> hosts
echo $managementIP  "ansible_ssh_pass=root" >> hosts
echo "" >> hosts
echo "[data_node1]" >> hosts
echo $data1IP  "ansible_ssh_pass=root" >> hosts
echo "" >> hosts
echo "[data_node2]" >> hosts
echo $data2IP  "ansible_ssh_pass=root" >> hosts
echo "" >> hosts
echo "[mysql_node]" >> hosts
echo $mysqlIP  "ansible_ssh_pass=root" >> hosts
echo "" >> hosts
