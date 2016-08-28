
cd /etc/ansible
sudo chmod 777 hosts

#Retrieve the db server's IP address
dbserverIP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' testdbserver)
echo "IP of db server is:",$dbserverIP

echo "[testdbserver]" > hosts
echo $dbserverIP "ansible_ssh_pass=root" >> hosts
echo "" >> hosts

#Retrieve the test_env_server's IP address
test_env_serverIP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' test_env_server)
echo "IP of test_env_server is:",$test_env_serverIP

echo "[test_env_server]" >> hosts
echo $test_env_serverIP "ansible_ssh_pass=root" >> hosts
echo "" >> hosts

#Retrieve the web server's IP address
webserverIP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' testwebserver)
echo "IP of web server is:",$webserverIP

echo "[testwebserver]" >> hosts
echo $webserverIP "ansible_ssh_pass=root" >> hosts
echo "" >> hosts

echo "[jenkinhost]" >> hosts
echo "10.51.237.131 ansible_ssh_pass=Pspl123" >> hosts
echo "" >> hosts

